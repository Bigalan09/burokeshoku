#!/bin/sh

set -eu

fake_bin=$(mktemp -d)

cleanup() {
  rm -rf "$fake_bin"
}

trap cleanup EXIT

for cmd in git grep sed tr rm mktemp; do
  ln -s "$(command -v "$cmd")" "$fake_bin/$cmd"
done

PATH="$fake_bin:/usr/bin:/bin" sh scripts/validate-static-site.sh
PATH="$fake_bin:/usr/bin:/bin" sh scripts/validate-github-pages-workflows.sh
