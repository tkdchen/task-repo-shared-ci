.PHONY: all
all: update

.PHONY: .venv
.venv:
	if [ ! -e .venv ]; then uv venv; fi
	uv pip install -r requirements-dev.txt

.PHONY: update
update: .venv
	if [ -e .cruft.json ]; then rm .cruft.json; fi
	uv run cruft link . --no-input
	uv run cruft update --skip-apply-ask --allow-untracked-files

.PHONY: recreate
recreate: .venv
	uv run cruft create . --no-input --overwrite-if-exists
