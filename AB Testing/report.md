# A/B Test Report

## Results

| Variant | Users | Converted | Rate |
|---------|-------|-----------|------|
| A (control)   | 5000 | 577 | 11.54% |
| B (new version) | 5000 | 685 | 13.70% |

- Absolute lift: +2.16%
- Relative lift: +18.72%
- 95% confidence interval: [+0.86%, +3.46%]
- p-value: 0.001145

## Verdict

SHIP IT - B wins! It converts +2.16% more users (+18.7% relatively). This is statistically confirmed (p = 0.0011).

## How to read this

- Absolute lift = how many more percentage points B converts vs A
- Relative lift = how much better B is in % terms relative to A
- p-value below 0.05 = the difference is real, not random
- Confidence interval = the true lift is likely somewhere in this range
- If the confidence interval includes zero = result is not conclusive
