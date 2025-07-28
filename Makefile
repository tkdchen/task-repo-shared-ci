.PHONY: all
all: update

.PHONY: .venv
.venv:
	if [ ! -e .venv ]; then uv venv; fi
	uv pip install -r requirements-dev.txt

.PHONY: update
update: .venv
	if ! uv run cruft diff -c HEAD -e; then \
		uv run cruft update --skip-apply-ask --allow-untracked-files && \
		git add .cruft.json; \
	fi

.PHONY: recreate
recreate: .venv
	if ! uv run cruft diff -c HEAD -e; then \
		uv run cruft create . --no-input --overwrite-if-exists; \
	fi
