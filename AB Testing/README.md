# Project 2 — A/B Testing

**Question:** Does the new variant beat the control?

## What you'll learn

- How A/B tests are designed (sample size, power, randomization)
- The proportions z-test (for conversion-rate comparisons)
- How to calculate confidence intervals for a difference in conversion
- Why "peeking" inflates false positives
- Visualizing A/B results properly

## What this project does

1. Simulates a realistic A/B test on a website signup funnel (or loads your real test data)
2. Calculates conversion rates for control (A) and variant (B)
3. Runs a two-proportion z-test
4. Computes a 95% confidence interval for the lift
5. Produces a chart and a written report with a clear ship / don't-ship verdict

## How to run

```bash
pip install -r requirements.txt
python run_all.py
```

## Using your own data

Edit `config.py`:

```python
USE_SYNTHETIC = False
INPUT_FILE = "data/my_ab_test.csv"
```

Your CSV needs three columns: `variant` ("A" or "B"), `converted` (0 or 1), and optionally `timestamp`.

## Output

After running, check `outputs/`:
- `ab_results.png` — conversion rate comparison with confidence intervals
- `report.md` — written summary with ship / don't-ship verdict
