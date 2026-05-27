"""
01_get_data.py — Simulate an A/B test or load real test results.

Outputs:
  - data/raw_data.csv  (variant, converted)
"""

import sys
import pandas as pd
import numpy as np
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import config


def simulate_ab_test() -> pd.DataFrame:
    """Simulate users coming through two variants with different conversion rates."""
    rng = np.random.default_rng(seed=config.RANDOM_SEED)
    n = config.N_USERS_PER_VARIANT

    users_a = pd.DataFrame({
        "variant": "A",
        "converted": rng.binomial(1, config.CONVERSION_RATE_A, size=n),
    })
    users_b = pd.DataFrame({
        "variant": "B",
        "converted": rng.binomial(1, config.CONVERSION_RATE_B, size=n),
    })

    df = pd.concat([users_a, users_b], ignore_index=True)
    df = df.sample(frac=1, random_state=config.RANDOM_SEED).reset_index(drop=True)
    print(f"  → simulated {len(df):,} users "
          f"({n:,} per variant)")
    return df


def load_user_file(path: str) -> pd.DataFrame:
    print(f"Loading user data from {path} ...")
    df = pd.read_csv(path)
    required = {"variant", "converted"}
    missing = required - set(df.columns)
    if missing:
        raise ValueError(f"Missing required columns: {missing}")
    df = df[["variant", "converted"]].dropna()
    df["converted"] = df["converted"].astype(int)
    print(f"  → loaded {len(df):,} rows")
    return df


def main():
    Path("data").mkdir(exist_ok=True)

    if config.INPUT_FILE:
        df = load_user_file(config.INPUT_FILE)
    elif config.USE_SYNTHETIC:
        df = simulate_ab_test()
    else:
        raise ValueError("Either set USE_SYNTHETIC=True or provide INPUT_FILE")

    df.to_csv(config.RAW_DATA_PATH, index=False)
    print(f"Saved → {config.RAW_DATA_PATH}")


if __name__ == "__main__":
    main()
