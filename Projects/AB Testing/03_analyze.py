"""
03_analyze.py — Run the A/B test analysis.

We use a two-proportion z-test (the standard for conversion-rate A/B tests).
We also compute:
  - Absolute lift (B - A in percentage points)
  - Relative lift ((B-A)/A as a percentage)
  - 95% confidence interval for the difference
  - Required sample size to detect the configured MIN_DETECTABLE_EFFECT
"""

import sys
import json
import pandas as pd
import numpy as np
from pathlib import Path
from statsmodels.stats.proportion import (
    proportions_ztest, confint_proportions_2indep
)
from statsmodels.stats.power import NormalIndPower
from statsmodels.stats.proportion import proportion_effectsize

sys.path.insert(0, str(Path(__file__).parent))
import config


def main():
    df = pd.read_csv(config.CLEAN_DATA_PATH)

    grp = df.groupby("variant")["converted"].agg(["sum", "count"])
    conv_a, n_a = int(grp.loc["A", "sum"]), int(grp.loc["A", "count"])
    conv_b, n_b = int(grp.loc["B", "sum"]), int(grp.loc["B", "count"])

    rate_a = conv_a / n_a
    rate_b = conv_b / n_b
    abs_lift = rate_b - rate_a
    rel_lift = abs_lift / rate_a if rate_a else 0.0

    # Two-proportion z-test
    z_stat, p_value = proportions_ztest([conv_b, conv_a], [n_b, n_a])

    # 95% CI for the difference (B - A)
    ci_low, ci_high = confint_proportions_2indep(
        conv_b, n_b, conv_a, n_a, alpha=config.ALPHA
    )

    # Required sample size to detect MIN_DETECTABLE_EFFECT with 80% power
    es = proportion_effectsize(rate_a + config.MIN_DETECTABLE_EFFECT, rate_a)
    analysis = NormalIndPower()
    required_n = analysis.solve_power(
        effect_size=es, alpha=config.ALPHA, power=0.80, alternative="two-sided"
    )

    results = {
        "alpha": config.ALPHA,
        "variant_A": {
            "n": n_a, "conversions": conv_a, "rate": rate_a,
        },
        "variant_B": {
            "n": n_b, "conversions": conv_b, "rate": rate_b,
        },
        "absolute_lift": abs_lift,
        "relative_lift": rel_lift,
        "z_statistic": float(z_stat),
        "p_value": float(p_value),
        "significant": bool(p_value < config.ALPHA),
        "ci_95_low": float(ci_low),
        "ci_95_high": float(ci_high),
        "required_n_per_variant_for_mde": int(np.ceil(required_n)),
        "min_detectable_effect": config.MIN_DETECTABLE_EFFECT,
    }

    print("\n" + "=" * 60)
    print("A/B TEST RESULTS")
    print("=" * 60)
    print(f"\nVariant A (control): {conv_a:,} / {n_a:,} converted "
          f"= {rate_a:.2%}")
    print(f"Variant B (variant): {conv_b:,} / {n_b:,} converted "
          f"= {rate_b:.2%}")
    print(f"\nAbsolute lift: {abs_lift:+.2%}")
    print(f"Relative lift: {rel_lift:+.2%}")
    print(f"95% CI for lift: [{ci_low:+.2%}, {ci_high:+.2%}]")
    print(f"\nz = {z_stat:.4f},  p = {p_value:.6f}")
    print(f"Significant at alpha={config.ALPHA}? "
          f"{'YES — variant B wins' if p_value < config.ALPHA and abs_lift > 0 else 'NO — cannot conclude'}")
    print(f"\nFor reference: to detect a {config.MIN_DETECTABLE_EFFECT:+.0%} lift "
          f"with 80% power, you'd need ≈ {int(np.ceil(required_n)):,} users per variant.")
    print()

    Path(config.OUTPUT_DIR).mkdir(exist_ok=True)
    with open(Path(config.OUTPUT_DIR) / "results.json", "w") as f:
        json.dump(results, f, indent=2)
    print(f"Saved → {config.OUTPUT_DIR}/results.json")


if __name__ == "__main__":
    main()
