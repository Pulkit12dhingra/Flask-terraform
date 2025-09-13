# test/lint_gate.py
import io
import sys
import pathlib
from pylint.lint import Run
from pylint.reporters.text import TextReporter


def get_python_files(root: str = "."):
    """Recursively collect all .py files under root (excluding venv/test lint script)."""
    files = []
    for path in pathlib.Path(root).rglob("*.py"):
        if "venv" in path.parts or path.name == "lint_gate.py":
            continue
        files.append(str(path))
    return files


def main():
    py_files = get_python_files(".")
    if not py_files:
        print("No Python files found to lint.")
        sys.exit(0)

    # Capture pylint output
    stream = io.StringIO()
    reporter = TextReporter(stream)

    # In Pylint >=3.0, just call Run without do_exit
    result = Run(py_files + ["--exit-zero"], reporter=reporter)

    # Print full pylint report
    report_text = stream.getvalue()
    if report_text:
        print(report_text)

    # Global score
    score = getattr(result.linter.stats, "global_note", None)
    if score is None:
        print("Could not determine pylint score — failing.")
        sys.exit(1)

    print(f"\nPylint score: {score:.2f}/10")

    # Strict gate: fail if score < 7.0
    if score < 7.0:
        print("Lint score below 7.0 — failing the workflow.")
        sys.exit(1)


if __name__ == "__main__":
    main()
