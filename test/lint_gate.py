# test/lint_gate.py
import sys
import re
import pathlib
import subprocess

THRESHOLD = 7.0

EXCLUDE_DIRS = {"venv", ".venv", "__pycache__", "build", "dist"}

def get_python_files(root="."):
    files = []
    for path in pathlib.Path(root).rglob("*.py"):
        # skip excluded dirs and this script itself
        if any(part in EXCLUDE_DIRS for part in path.parts):
            continue
        if path.name == "lint_gate.py":
            continue
        files.append(str(path))
    return files

def main():
    py_files = get_python_files(".")
    if not py_files:
        print("No Python files found to lint.")
        sys.exit(0)

    cmd = [sys.executable, "-m", "pylint", "--exit-zero", "--score=yes"] + py_files
    print("Running:", " ".join(cmd))

    # Run pylint and capture output
    proc = subprocess.run(cmd, capture_output=True, text=True)
    # Print pylint’s full output to CI logs
    if proc.stdout:
        print(proc.stdout)
    if proc.stderr:
        print(proc.stderr, file=sys.stderr)

    # Parse the global score: "Your code has been rated at X.XX/10"
    m = re.search(r"rated at\s+(-?\d+(?:\.\d+)?)/10", proc.stdout or "")
    if not m:
        print("Could not determine pylint score — failing.")
        sys.exit(1)

    score = float(m.group(1))
    print(f"Pylint score: {score:.2f}/10")

    if score < THRESHOLD:
        print(f"Lint score below {THRESHOLD} — failing the workflow.")
        sys.exit(1)

if __name__ == "__main__":
    main()
