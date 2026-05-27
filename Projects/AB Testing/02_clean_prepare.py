"""
02_clean_prepare.py — Validate the test data.

Steps:
  1. Ensure only A/B variants
  2. Check for sample ratio mismatch (SRM) — a sign of bug in randomization
  3. Drop any rows with invalid conversion values
"""

import sys
import pandas as pd
from pathlib import Path
from scipy import stats

sys.path.insert(0, str(Path(__file__).parent))
import config


def main():
    df = pd.read_csv(config.RAW_DATA_PATH)
    print(f"Loaded raw data: {len(df):,} rows")

    df = df[df["variant"].isin(["A", "B"])].copy()
    df = df[df["converted"].isin([0, 1])].copy()
    df = df.reset_index(drop=True)

    counts = df["variant"].value_counts().to_dict()
    print(f"Variant A: {counts.get('A', 0):,}")
    print(f"Variant B: {counts.get('B', 0):,}")

    # Sample Ratio Mismatch check
    # If randomization is 50/50, the split should be very close to 50/50.
    # A chi-square test against 50/50 expectation flags bugs.
    observed = [counts.get("A", 0), counts.get("B", 0)]
    expected = [sum(observed) / 2] * 2
    chi2, srm_p = stats.chisquare(observed, expected)
    if srm_p < 0.01:
        print(f"WARNING: Sample Ratio Mismatch suspected (p={srm_p:.4f}). "
              "Investigate randomization before trusting the results.")
    else:
        print(f"Sample Ratio Mismatch check: OK (p={srm_p:.4f})")

    df.to_csv(config.CLEAN_DATA_PATH, index=False)
    print(f"Saved → {config.CLEAN_DATA_PATH}")


if __name__ == "__main__":
    main()
