"""
04_present.py — Generate the A/B test chart and report.
"""

import sys
import json
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import config


def make_chart(r: dict, out_path: Path):
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(13, 5))

    # Panel 1: conversion rates with Wilson 95% CIs
    from statsmodels.stats.proportion import proportion_confint
    a_lo, a_hi = proportion_confint(r["variant_A"]["conversions"],
                                    r["variant_A"]["n"], method="wilson")
    b_lo, b_hi = proportion_confint(r["variant_B"]["conversions"],
                                    r["variant_B"]["n"], method="wilson")

    variants = ["A (control)", "B (variant)"]
    rates = [r["variant_A"]["rate"], r["variant_B"]["rate"]]
    errs = [[rates[0] - a_lo, rates[1] - b_lo],
            [a_hi - rates[0], b_hi - rates[1]]]
    colors = ["#0B2545", "#0E7C7B"]

    bars = ax1.bar(variants, rates, color=colors, alpha=0.85,
                   yerr=errs, capsize=10, error_kw={"linewidth": 1.5})
    for bar, rate in zip(bars, rates):
        ax1.text(bar.get_x() + bar.get_width() / 2,
                 bar.get_height() + 0.005,
                 f"{rate:.2%}", ha="center", fontsize=12, fontweight="bold")
    ax1.set_ylabel("Conversion rate")
    ax1.set_title("Conversion rate by variant (with 95% CI)")
    ax1.set_ylim(0, max(rates) * 1.4)
    ax1.grid(axis="y", alpha=0.3)

    # Panel 2: lift confidence interval
    ax2.axvline(0, color="#999", lw=1, ls="--")
    ax2.errorbar(r["absolute_lift"], 0,
                 xerr=[[r["absolute_lift"] - r["ci_95_low"]],
                       [r["ci_95_high"] - r["absolute_lift"]]],
                 fmt="o", color="#0E7C7B", markersize=12, capsize=10, lw=2)
    ax2.text(r["absolute_lift"], 0.1,
             f"  Lift: {r['absolute_lift']:+.2%}",
             fontsize=12, fontweight="bold", va="bottom")
    ax2.set_yticks([])
    ax2.set_xlabel("Absolute lift (B − A)")
    ax2.set_title(f"95% confidence interval for the lift\n"
                  f"p = {r['p_value']:.4g}")
    ax2.set_ylim(-0.5, 0.5)
    ax2.grid(axis="x", alpha=0.3)

    plt.tight_layout()
    plt.savefig(out_path, dpi=130, bbox_inches="tight")
    plt.close()
    print(f"Saved → {out_path}")


def write_report(r: dict, out_path: Path):
    a, b = r["variant_A"], r["variant_B"]

    if r["significant"] and r["absolute_lift"] > 0:
        verdict = ("✅ **SHIP variant B.** "
                   f"It outperforms the control by {r['absolute_lift']:+.2%} "
                   f"(relative lift {r['relative_lift']:+.1%}), "
                   f"and the result is statistically significant "
                   f"(p = {r['p_value']:.4g}).")
    elif r["significant"] and r["absolute_lift"] < 0:
        verdict = ("❌ **DO NOT SHIP variant B.** "
                   f"It underperforms the control by {abs(r['absolute_lift']):.2%}. "
                   f"This negative effect is statistically significant "
                   f"(p = {r['p_value']:.4g}).")
    else:
        verdict = (f"⚠️ **INCONCLUSIVE.** "
                   f"The observed lift of {r['absolute_lift']:+.2%} is not "
                   f"statistically significant (p = {r['p_value']:.4g} ≥ "
                   f"{r['alpha']}). You either need more data, "
                   f"or the variant truly is not better.")

    report = f"""# A/B Test Report

**Significance level (alpha):** {r['alpha']}

---

## Results

| Variant | Users | Conversions | Rate |
|---------|-------|-------------|------|
| A (control) | {a['n']:,} | {a['conversions']:,} | {a['rate']:.2%} |
| B (variant) | {b['n']:,} | {b['conversions']:,} | {b['rate']:.2%} |

- **Absolute lift:** {r['absolute_lift']:+.2%}
- **Relative lift:** {r['relative_lift']:+.2%}
- **95% CI for lift:** [{r['ci_95_low']:+.2%}, {r['ci_95_high']:+.2%}]
- **z-statistic:** {r['z_statistic']:.4f}
- **p-value:** {r['p_value']:.6f}

---

## Verdict

{verdict}

---

## Power analysis (for next time)

To reliably detect a **{r['min_detectable_effect']:+.0%}** lift with 80% statistical
power, you would need approximately **{r['required_n_per_variant_for_mde']:,} users
per variant**. Underpowered tests are why "no effect" results so often turn out to
be wrong: the data just wasn't enough to see the effect.

---

## How to read this

- The **p-value** is the probability of seeing a lift this large by chance if the variant truly had no effect.
- A **confidence interval that crosses zero** means you can't be sure whether the variant is genuinely better, worse, or the same.
- "Statistically significant" means *the effect is unlikely to be noise*. It does NOT mean the effect is large or business-meaningful. Always look at the lift itself too.

See `ab_results.png` for the visual.
"""
    out_path.write_text(report, encoding="utf-8")
    print(f"Saved → {out_path}")


def main():
    out_dir = Path(config.OUTPUT_DIR)
    out_dir.mkdir(exist_ok=True)

    with open(out_dir / "results.json") as f:
        results = json.load(f)

    make_chart(results, out_dir / "ab_results.png")
    write_report(results, out_dir / "report.md")
    print("\nDone. Open the outputs/ folder.")


if __name__ == "__main__":
    main()
