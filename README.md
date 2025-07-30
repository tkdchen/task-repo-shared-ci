# 🏗️ Boilerplate for Konflux Task repos

This repo provides the shared scripts and CI workflows crucial for developing
Konflux Tasks.

To include the shared CI in your repo, see the [onboarding](#onboarding) steps.

For further post-onboarding information, see the [SHARED-CI.md](./SHARED-CI.md)
doc in this repo or the copy brought in by the onboarding process to your own repo.

## 🚀 Onboarding

Pre-requisites:

- Install [`cruft`][cruft]

Process:

1. Check that the onboarding process will not destroy your local changes

   ```bash
   git status --short .github/ hack/ SHARED-CI.md
   ```

   This command will print all the files the process could affect.
   Commit any changes that you don't want to lose.

2. Run the `cruft create` command

   ```bash
   cruft create https://github.com/chmeliik/task-repo-boilerplate --no-input --overwrite-if-exists
   ```

3. Restore the files that got deleted in the process

   ```bash
   git diff --diff-filter=D --name-only -- .github/ hack/ | xargs git checkout --
   ```

4. Commit the files brought in from the template repo

   ```bash
   git add .github/ hack/ SHARED-CI.md
   git commit
   ```

[cruft]: https://cruft.github.io/cruft
