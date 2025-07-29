#!/bin/bash
set -o errexit -o nounset -o pipefail

files_in_danger=$(
    find '{{cookiecutter.repo_root}}' -type f | cut -d / -f 2- | xargs git status -s
)

if [[ -n "$files_in_danger" ]]; then
    echo "Refusing to proceed, could overwrite the following files:"
    # shellcheck disable=SC2001
    sed 's/^/  /' <<< "$files_in_danger"
    exit 1
fi >&2

find '{{cookiecutter.repo_root}}' -type f | while read -r actual_path; do
    copy_to=${actual_path#*/}
    mkdir -p "$(dirname "$copy_to")"
    cp --remove-destination "$actual_path" "$copy_to"
    git add "$copy_to"
done
