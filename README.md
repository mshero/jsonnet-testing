# Jsonnet-Testing repository

Simple POC for jsonnet unit testing.

Requires `jsonnet`, `jsonnetfmt`, `jsonnet-lint`, `jb` and `make` tools.

## Files in this repository

- `Makefile` - build configuration for `make`
- `jsonnetfile.json` - dependency configuration for jsonnet bundler (`jb`)
- `lib/utils.libsonnet` - library that exposes a single utility method
- `lib/utils_test.jsonnet` - jsonnet file that defines the unit tests for the
utility method

## What to do?

Checkout the repository (`git clone`) and in the repository root run `make` and
see magic happening...

Feel free to modify files to introduce linter, formatting or test issues and
check the behavior.
