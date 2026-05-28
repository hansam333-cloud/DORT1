# Customer Response Example

## Input Summary

```text
Customer message:
183cm 82kg인데 쿨링 머슬 반팔티 L 입으면 너무 붙을까요?

Product name: [피지컬핏] 쿨링 머슬 반팔티
Available sizes: M, L, XL
Product fit: Semi-muscle fit
Model fit info:
183cm / 78kg / L 착용. 평소 상의 105. 어깨와 가슴은 여유 있게 맞고 팔 라인은 자연스럽게 잡히는 DORT 추천핏.

Customer info:
Height: 183cm
Weight: 82kg
Usual top size: Unknown
Body type: likely athletic or average-athletic
Preferred fit: worried about tightness
```

## Output

# Customer Response Result

## Reply Intent

Size recommendation and fit anxiety reduction.

## Customer Concern Summary

The customer is similar to the model but slightly heavier and is worried that L may feel too tight.

## Recommended Response

```text
고객님 체형 기준으로는 L도 착용 가능하지만, 너무 붙는 느낌이 걱정되시면 XL을 더 추천드립니다.

해당 상품은 과하게 조이는 머슬핏보다는 어깨와 팔 라인은 자연스럽게 살리고, 몸통은 부해 보이지 않게 잡는 세미 피지컬핏에 가깝습니다.

183cm / 78kg 모델은 L 착용 시 어깨와 가슴은 여유 있게 맞고 팔 라인이 자연스럽게 잡히는 핏이었습니다. 고객님은 모델보다 체중이 조금 더 있으셔서, 정핏에 가깝게 입고 싶으시면 L, 데일리하게 여유 있는 느낌을 원하시면 XL을 추천드립니다.
```

## Short Version

```text
고객님 체형 기준으로 L도 가능하지만, 너무 붙는 느낌이 걱정되시면 XL을 추천드립니다. 정핏에 가까운 피지컬핏은 L, 데일리하게 여유 있는 핏은 XL이 좋습니다.
```

## Detailed Version

```text
고객님 체형 기준으로는 L과 XL 모두 가능성이 있습니다.

L은 어깨와 팔 라인이 더 자연스럽게 살아나는 정핏에 가까운 피지컬핏으로 보시면 되고, XL은 몸통과 팔 쪽에 조금 더 여유가 생겨 데일리하게 입기 편한 핏입니다.

이 상품은 과하게 조이는 머슬핏이 아니라 상체 라인은 살리고 전체 실루엣은 깔끔하게 정리하는 세미 피지컬핏이라, 붙는 느낌이 부담스러우신 편이면 XL 쪽이 더 만족도가 높을 수 있습니다.
```

## Internal Note

Recommend XL if customer expresses tightness anxiety. Recommend L only if customer wants a more defined upper-body fit.

## Follow-Up Question

```text
평소 상의를 105로 입으시는지, 110에 가깝게 입으시는지만 알려주시면 더 정확히 추천드릴 수 있습니다.
```

## Risk Flag

```text
Medium. Customer is between sizes and has tightness anxiety.
```

