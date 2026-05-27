"""run_all.py — run the full pipeline end-to-end."""

import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).parent
SCRIPTS = ["01_get_data.py", "02_clean_prepare.py", "03_analyze.py", "04_present.py"]


def main():
    for s in SCRIPTS:
        print(f"\n{'=' * 60}\nRunning {s}\n{'=' * 60}")
        result = subprocess.run([sys.executable, str(HERE / s)], cwd=HERE)
        if result.returncode != 0:
            print(f"\n{s} failed with exit code {result.returncode}")
            sys.exit(result.returncode)
    print("\nAll steps complete. See outputs/ folder.")


if __name__ == "__main__":
    main()
