[CmdletBinding(DefaultParameterSetName = 'Clean')]
param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [Parameter(Mandatory = $true, ParameterSetName = 'Clean')]
    [string]$OutputPath,

    [Parameter(Mandatory = $true, ParameterSetName = 'Verify')]
    [switch]$VerifyOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$BlockedPngChunks = @('caBX', 'eXIf', 'tEXt', 'zTXt', 'iTXt')
$BlockedJpegMarkers = @{
    0xE1 = 'APP1-EXIF-XMP'
    0xEB = 'APP11-JUMBF-C2PA'
    0xED = 'APP13-IPTC'
    0xFE = 'COM'
}

function Get-UInt32BigEndian {
    param([byte[]]$Bytes, [int]$Offset)
    return [int64]$Bytes[$Offset] * 16777216L +
        [int64]$Bytes[$Offset + 1] * 65536L +
        [int64]$Bytes[$Offset + 2] * 256L +
        [int64]$Bytes[$Offset + 3]
}

function Get-ImageKind {
    param([byte[]]$Bytes)
    if ($Bytes.Length -ge 8 -and
        $Bytes[0] -eq 0x89 -and $Bytes[1] -eq 0x50 -and
        $Bytes[2] -eq 0x4E -and $Bytes[3] -eq 0x47 -and
        $Bytes[4] -eq 0x0D -and $Bytes[5] -eq 0x0A -and
        $Bytes[6] -eq 0x1A -and $Bytes[7] -eq 0x0A) {
        return 'PNG'
    }
    if ($Bytes.Length -ge 2 -and $Bytes[0] -eq 0xFF -and $Bytes[1] -eq 0xD8) {
        return 'JPEG'
    }
    throw '지원 형식은 PNG와 JPEG뿐입니다.'
}

function Get-PngMetadata {
    param([byte[]]$Bytes)
    $found = New-Object System.Collections.Generic.List[string]
    $position = 8
    while ($position + 12 -le $Bytes.Length) {
        $length = Get-UInt32BigEndian -Bytes $Bytes -Offset $position
        $type = [Text.Encoding]::ASCII.GetString($Bytes, $position + 4, 4)
        $next = $position + 12L + $length
        if ($next -gt $Bytes.Length) { throw "손상된 PNG 청크: $type" }
        if ($BlockedPngChunks -contains $type) { $found.Add($type) }
        $position = [int]$next
        if ($type -eq 'IEND') { break }
    }
    return $found.ToArray()
}

function Write-CleanPng {
    param([byte[]]$Bytes, [string]$Destination)
    $stream = New-Object IO.MemoryStream
    try {
        $stream.Write($Bytes, 0, 8)
        $position = 8
        while ($position + 12 -le $Bytes.Length) {
            $length = Get-UInt32BigEndian -Bytes $Bytes -Offset $position
            $type = [Text.Encoding]::ASCII.GetString($Bytes, $position + 4, 4)
            $chunkLength = 12L + $length
            $next = $position + $chunkLength
            if ($next -gt $Bytes.Length) { throw "손상된 PNG 청크: $type" }
            if ($BlockedPngChunks -notcontains $type) {
                $stream.Write($Bytes, $position, [int]$chunkLength)
            }
            $position = [int]$next
            if ($type -eq 'IEND') { break }
        }
        [IO.File]::WriteAllBytes($Destination, $stream.ToArray())
    }
    finally {
        $stream.Dispose()
    }
}

function Get-JpegMetadata {
    param([byte[]]$Bytes)
    $found = New-Object System.Collections.Generic.List[string]
    $position = 2
    while ($position -lt $Bytes.Length) {
        if ($Bytes[$position] -ne 0xFF) { throw "손상된 JPEG 마커 위치: $position" }
        while ($position -lt $Bytes.Length -and $Bytes[$position] -eq 0xFF) { $position++ }
        if ($position -ge $Bytes.Length) { break }
        $marker = [int]$Bytes[$position]
        $position++
        if ($marker -eq 0xDA -or $marker -eq 0xD9) { break }
        if ($marker -eq 0x01 -or ($marker -ge 0xD0 -and $marker -le 0xD7)) { continue }
        if ($position + 2 -gt $Bytes.Length) { throw '손상된 JPEG 세그먼트 길이' }
        $length = [int]$Bytes[$position] * 256 + [int]$Bytes[$position + 1]
        if ($length -lt 2 -or $position + $length -gt $Bytes.Length) { throw '손상된 JPEG 세그먼트' }
        if ($BlockedJpegMarkers.ContainsKey($marker)) { $found.Add($BlockedJpegMarkers[$marker]) }
        $position += $length
    }
    return $found.ToArray()
}

function Assert-JpegOrientationSafe {
    param([string]$Path)
    Add-Type -AssemblyName System.Drawing
    $image = [Drawing.Image]::FromFile($Path)
    try {
        $orientation = $image.PropertyItems | Where-Object { $_.Id -eq 0x0112 } | Select-Object -First 1
        if ($null -ne $orientation -and $orientation.Value.Length -ge 2) {
            $value = [BitConverter]::ToUInt16($orientation.Value, 0)
            if ($value -ne 1) {
                throw "JPEG 방향값이 $value 입니다. 픽셀 방향을 먼저 정상화한 뒤 다시 실행하세요."
            }
        }
    }
    finally {
        $image.Dispose()
    }
}

function Write-CleanJpeg {
    param([byte[]]$Bytes, [string]$Destination)
    $stream = New-Object IO.MemoryStream
    try {
        $stream.Write($Bytes, 0, 2)
        $position = 2
        while ($position -lt $Bytes.Length) {
            $segmentStart = $position
            if ($Bytes[$position] -ne 0xFF) { throw "손상된 JPEG 마커 위치: $position" }
            while ($position -lt $Bytes.Length -and $Bytes[$position] -eq 0xFF) { $position++ }
            if ($position -ge $Bytes.Length) { break }
            $marker = [int]$Bytes[$position]
            $position++
            if ($marker -eq 0xDA -or $marker -eq 0xD9) {
                $stream.Write($Bytes, $segmentStart, $Bytes.Length - $segmentStart)
                break
            }
            if ($marker -eq 0x01 -or ($marker -ge 0xD0 -and $marker -le 0xD7)) {
                $stream.Write($Bytes, $segmentStart, $position - $segmentStart)
                continue
            }
            if ($position + 2 -gt $Bytes.Length) { throw '손상된 JPEG 세그먼트 길이' }
            $length = [int]$Bytes[$position] * 256 + [int]$Bytes[$position + 1]
            if ($length -lt 2 -or $position + $length -gt $Bytes.Length) { throw '손상된 JPEG 세그먼트' }
            $segmentLength = $position + $length - $segmentStart
            if (-not $BlockedJpegMarkers.ContainsKey($marker)) {
                $stream.Write($Bytes, $segmentStart, $segmentLength)
            }
            $position += $length
        }
        [IO.File]::WriteAllBytes($Destination, $stream.ToArray())
    }
    finally {
        $stream.Dispose()
    }
}

function Get-PayloadHash {
    param([byte[]]$Bytes, [string]$Kind)
    $stream = New-Object IO.MemoryStream
    try {
        if ($Kind -eq 'PNG') {
            $position = 8
            while ($position + 12 -le $Bytes.Length) {
                $length = Get-UInt32BigEndian -Bytes $Bytes -Offset $position
                $type = [Text.Encoding]::ASCII.GetString($Bytes, $position + 4, 4)
                if ($type -eq 'IDAT') { $stream.Write($Bytes, $position + 8, [int]$length) }
                $position = [int]($position + 12L + $length)
                if ($type -eq 'IEND') { break }
            }
        }
        else {
            $position = 2
            while ($position -lt $Bytes.Length) {
                $segmentStart = $position
                while ($position -lt $Bytes.Length -and $Bytes[$position] -eq 0xFF) { $position++ }
                if ($position -ge $Bytes.Length) { break }
                $marker = [int]$Bytes[$position]
                $position++
                if ($marker -eq 0xDA) {
                    $stream.Write($Bytes, $segmentStart, $Bytes.Length - $segmentStart)
                    break
                }
                if ($marker -eq 0xD9) { break }
                if ($marker -eq 0x01 -or ($marker -ge 0xD0 -and $marker -le 0xD7)) { continue }
                $length = [int]$Bytes[$position] * 256 + [int]$Bytes[$position + 1]
                $position += $length
            }
        }
        $sha = [Security.Cryptography.SHA256]::Create()
        try {
            return ([BitConverter]::ToString($sha.ComputeHash($stream.ToArray()))).Replace('-', '').ToLowerInvariant()
        }
        finally {
            $sha.Dispose()
        }
    }
    finally {
        $stream.Dispose()
    }
}

$resolvedInput = (Resolve-Path -LiteralPath $InputPath).Path
$inputBytes = [IO.File]::ReadAllBytes($resolvedInput)
$kind = Get-ImageKind -Bytes $inputBytes
$inputMetadata = @(if ($kind -eq 'PNG') { Get-PngMetadata -Bytes $inputBytes } else { Get-JpegMetadata -Bytes $inputBytes })

if ($VerifyOnly) {
    if ($inputMetadata.Count -gt 0) {
        throw "메타데이터 검사 실패: $($inputMetadata -join ', ')"
    }
    Write-Output "PASS: $resolvedInput ($kind)"
    exit 0
}

$fullOutput = [IO.Path]::GetFullPath($OutputPath)
if ($resolvedInput -eq $fullOutput) { throw '원본을 덮어쓸 수 없습니다. 다른 출력 경로를 사용하세요.' }
if (Test-Path -LiteralPath $fullOutput) { throw '출력 파일이 이미 존재합니다. 버전이 붙은 새 파일명을 사용하세요.' }
$outputDirectory = [IO.Path]::GetDirectoryName($fullOutput)
if (-not (Test-Path -LiteralPath $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

$inputPayloadHash = Get-PayloadHash -Bytes $inputBytes -Kind $kind
if ($kind -eq 'PNG') {
    Write-CleanPng -Bytes $inputBytes -Destination $fullOutput
}
else {
    Assert-JpegOrientationSafe -Path $resolvedInput
    Write-CleanJpeg -Bytes $inputBytes -Destination $fullOutput
}

$outputBytes = [IO.File]::ReadAllBytes($fullOutput)
$outputKind = Get-ImageKind -Bytes $outputBytes
$outputMetadata = @(if ($outputKind -eq 'PNG') { Get-PngMetadata -Bytes $outputBytes } else { Get-JpegMetadata -Bytes $outputBytes })
if ($outputMetadata.Count -gt 0) { throw "메타데이터 제거 실패: $($outputMetadata -join ', ')" }
$outputPayloadHash = Get-PayloadHash -Bytes $outputBytes -Kind $outputKind
if ($inputPayloadHash -ne $outputPayloadHash) { throw '이미지 페이로드가 변경되었습니다.' }

Write-Output "CLEAN: $fullOutput"
Write-Output "REMOVED: $($inputMetadata -join ', ')"
Write-Output "PAYLOAD_SHA256: $outputPayloadHash"
