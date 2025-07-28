.PHONY: all
all: render

.PHONY: .venv
.venv:
	if [ ! -e .venv ]; then uv venv; fi
	uv pip install -r requirements-dev.txt

.PHONY: render
render: .venv
	if ! uv run cruft diff -c HEAD -e; then \
		uv run cruft update --skip-apply-ask --allow-untracked-files; \
	fi
