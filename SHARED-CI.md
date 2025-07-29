# Shared CI setup for Konflux Task repos

Some of the CI scripts and workflows in this repo come from the [task-repo-boilerplate]
template repo.

All the files that come from the template repo have a `<TEMPLATED FILE!>` comment
near the top to help identify them.

## Updating the shared CI

Use [`cruft`][cruft] to update the shared CI files to the latest template:

```bash
cruft update --skip-apply-ask --allow-untracked-files
```

TODO: add a github action that checks for updates and sends PRs.

## Making changes

You can edit the shared CI files if necessary, but please consider sending PRs
for the upstream [task-repo-boilerplate] templates to reduce drift and so that
others can benefit from the changes as well.

`cruft` *will* try to respect your custom patches during the update process, but
as you make more local changes you increase the chance of merge conflicts.

## CI checks

### Trusted Artifacts

- script: [`hack/generate-ta-tasks.sh`](hack/generate-ta-tasks.sh)
  - Generates Trusted Artifacts variants of Tasks. See below for more details.
- workflow: [`.github/workflows/check-ta.yaml`](.github/workflows/check-ta.yaml)
  - Checks that the Trusted Artifacts variants are up to date with their base Tasks.

With Trusted Artifacts (TA), Tasks share files via the use of archives stored in
an image repository and not using attached storage (PersistentVolumeClaims). This
has performance and usability benefits. For more details, see
[ADR36](https://konflux-ci.dev/architecture/ADR/0036-trusted-artifacts.html).

When authoring a Task that needs to share or use files from another Task, the
task author can opt to include the Trusted Artifact variant, by convention in
the `${task_name}-oci-ta` directory. This is necessary for the Task to be usable
in Pipelines that make use of Trusted Artifacts.

To author a Trusted Artifacts variant of a Task, create the `${task_name}-oci-ta`
directory, define a [`recipe.yaml`][recipe.yaml] inside the directory and generate
the TA variant using the [`hack/generate-ta-tasks.sh`](hack/generate-ta-tasks.sh)
script. See the [trusted-artifacts generator] README for more details.

[task-repo-boilerplate]: https://github.com/chmeliik/task-repo-boilerplate
[cruft]: https://cruft.github.io/cruft
[recipe.yaml]: https://github.com/konflux-ci/build-definitions/tree/main/task-generator/trusted-artifacts#configuration-in-recipeyaml
[trusted-artifacts generator]: https://github.com/konflux-ci/build-definitions/tree/main/task-generator/trusted-artifacts
