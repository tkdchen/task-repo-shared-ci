.PHONY: all
all: selfupdate

.PHONY: .venv
.venv:
	if [ ! -e .venv ]; then uv venv; fi
	uv pip install -r requirements-dev.txt

.PHONY: selfupdate
selfupdate: .venv
	hack/selfupdate.sh
