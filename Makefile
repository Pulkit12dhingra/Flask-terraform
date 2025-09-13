PY?= python
TEST_DIR := test

.PHONY: help install lint test coverage run ci

help:
	@echo "make install   - install project + dev deps"
	@echo "make lint      - run pylint"
	@echo "make test      - run unittest discovery"

install:
	$(PY) -m pip install --upgrade pip
	$(PY) -m pip install -r requirements.txt
	$(PY) -m pip install pylint coverage


lint:
	$(PY) $(TEST_DIR)/lint_gate.py

test:
	$(PY) -m unittest test.test_app

ci: install lint test