"""
Configuration for Project 2 — A/B Testing
"""

# ─── DATA SOURCE ─────────────────────────────────────────────────────────────
USE_SYNTHETIC = True
INPUT_FILE = None
# If you have your own CSV: set USE_SYNTHETIC=False and INPUT_FILE="data/my_ab_test.csv"
# Columns expected: variant ("A"/"B"), converted (0/1)

# ─── SYNTHETIC DATA PARAMETERS ───────────────────────────────────────────────
N_USERS_PER_VARIANT = 5000
CONVERSION_RATE_A = 0.12   # control: 12% baseline
CONVERSION_RATE_B = 0.14   # variant: 14% (about a 17% relative lift)
RANDOM_SEED = 42

# ─── ANALYSIS PARAMETERS ─────────────────────────────────────────────────────
ALPHA = 0.05               # significance level
MIN_DETECTABLE_EFFECT = 0.02  # smallest lift we care about (absolute), e.g. 2 pp

# ─── FILE PATHS ──────────────────────────────────────────────────────────────
RAW_DATA_PATH = "data/raw_data.csv"
CLEAN_DATA_PATH = "data/clean_data.csv"
OUTPUT_DIR = "outputs"
