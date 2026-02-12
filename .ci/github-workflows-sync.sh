#!/usr/bin/env sh
set -eu

find .github/workflows -name 'ci--*.yml' -type f -delete && \
find .ci -name github-ci.yml -type f -exec sh -c '
src="$1"

name=$(echo "$src" | sed "s|^\.ci/||; s|/github-ci.yml||; s|/|--|g")
dst=".github/workflows/ci--$name--github-ci.yml"

{
  echo "# GENERATED FROM $src — DO NOT EDIT"
  while IFS= read -r line; do
    case "$line" in
      *"uses: ./.ci/"*)
        ref=$(echo "$line" | sed "s|.*uses: \./\.ci/||; s|/github-ci.yml||; s|/|--|g")
        echo "    uses: ./.github/workflows/ci--$ref--github-ci.yml"
        ;;
      *)
        echo "$line"
        ;;
    esac
  done < "$src"
} > "$dst"
' _ {} \;
