#!/bin/bash
set -o errexit -o nounset -o pipefail

files_in_danger=$(
    # print the files/directories at the first level of {{cookiecutter.repo_root}}
    # (just the names, i.e. print as if they were in the root directory)
    find '{{cookiecutter.repo_root}}' -mindepth 1 -maxdepth 1 -printf '%f\0' |
        # check status of files/directories generated from template
        xargs -0 git status --porcelain --
)

if [[ -n "$files_in_danger" ]]; then
    echo "Refusing to proceed, could overwrite/delete the following files:"
    # shellcheck disable=SC2001
    sed 's/^/  /' <<< "${files_in_danger}"
    exit 1
fi >&2

# re-generate from template
uv run cruft create . --no-input --overwrite-if-exists

# restore deleted files if they were not from template
git diff --diff-filter=D --name-only | while read -r deleted_file; do
    if ! git show HEAD:"${deleted_file}" | grep -q "^#.*<TEMPLATED FILE!>"; then
        printf '%s\0' "$deleted_file"
    fi
done | xargs -0 git checkout

# stage templated files
find '{{cookiecutter.repo_root}}' -mindepth 1 -maxdepth 1 -printf '%f\0' |
    xargs -0 git add
