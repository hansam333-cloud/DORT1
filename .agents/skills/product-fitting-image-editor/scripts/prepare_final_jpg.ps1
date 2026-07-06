[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$InputPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath,

    [ValidateRange(1, 100)]
    [int]$Quality = 95,

    [ValidateRange(1, 65535)]
    [int]$Width,

    [ValidateRange(1, 65535)]
    [int]$Height
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$resolvedInput = (Resolve-Path -LiteralPath $InputPath).Path
$fullOutput = [IO.Path]::GetFullPath($OutputPath)
if ($resolvedInput -eq $fullOutput) { throw 'Input and output paths must differ.' }
if (Test-Path -LiteralPath $fullOutput) { throw 'Output already exists. Use a versioned filename.' }
if ([IO.Path]::GetExtension($fullOutput).ToLowerInvariant() -notin @('.jpg', '.jpeg')) {
    throw 'Output must use a .jpg or .jpeg extension.'
}
if (($PSBoundParameters.ContainsKey('Width')) -xor ($PSBoundParameters.ContainsKey('Height'))) {
    throw 'Provide both Width and Height, or omit both to preserve source dimensions.'
}

$outputDirectory = [IO.Path]::GetDirectoryName($fullOutput)
if (-not (Test-Path -LiteralPath $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

Add-Type -AssemblyName System.Drawing
$source = [Drawing.Image]::FromFile($resolvedInput)
try {
    $targetWidth = if ($PSBoundParameters.ContainsKey('Width')) { $Width } else { $source.Width }
    $targetHeight = if ($PSBoundParameters.ContainsKey('Height')) { $Height } else { $source.Height }
    $bitmap = [Drawing.Bitmap]::new($targetWidth, $targetHeight, [Drawing.Imaging.PixelFormat]::Format24bppRgb)
    try {
        $dpiX = if ($source.HorizontalResolution -gt 0) { $source.HorizontalResolution } else { 72 }
        $dpiY = if ($source.VerticalResolution -gt 0) { $source.VerticalResolution } else { 72 }
        $bitmap.SetResolution($dpiX, $dpiY)
        $graphics = [Drawing.Graphics]::FromImage($bitmap)
        try {
            $graphics.Clear([Drawing.Color]::White)
            $graphics.CompositingMode = [Drawing.Drawing2D.CompositingMode]::SourceCopy
            $graphics.CompositingQuality = [Drawing.Drawing2D.CompositingQuality]::HighQuality
            $graphics.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $graphics.SmoothingMode = [Drawing.Drawing2D.SmoothingMode]::HighQuality
            $graphics.PixelOffsetMode = [Drawing.Drawing2D.PixelOffsetMode]::HighQuality
            $graphics.DrawImage($source, 0, 0, $targetWidth, $targetHeight)
        }
        finally {
            $graphics.Dispose()
        }

        $jpegCodec = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
            Where-Object { $_.MimeType -eq 'image/jpeg' } |
            Select-Object -First 1
        if ($null -eq $jpegCodec) { throw 'JPEG encoder is unavailable.' }
        $encoderParameters = [Drawing.Imaging.EncoderParameters]::new(1)
        try {
            $encoderParameters.Param[0] = [Drawing.Imaging.EncoderParameter]::new(
                [Drawing.Imaging.Encoder]::Quality,
                [long]$Quality
            )
            $bitmap.Save($fullOutput, $jpegCodec, $encoderParameters)
        }
        finally {
            $encoderParameters.Dispose()
        }
    }
    finally {
        $bitmap.Dispose()
    }
}
finally {
    $source.Dispose()
}

$result = [Drawing.Image]::FromFile($fullOutput)
try {
    if ($result.Width -ne $targetWidth -or $result.Height -ne $targetHeight) {
        throw 'JPEG dimension verification failed.'
    }
}
finally {
    $result.Dispose()
}

Write-Output "JPEG: $fullOutput"
Write-Output "QUALITY: $Quality"
Write-Output "SIZE: ${targetWidth}x${targetHeight}"
