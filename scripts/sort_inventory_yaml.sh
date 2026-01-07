#!/usr/bin/env bash
set -euo pipefail # Exit on error, unset vars, or failed pipeline.

if ! command -v yq >/dev/null 2>&1; then # Ensure yq is available in PATH.
  echo "yq not found. Install mikefarah/yq v4 and retry." >&2 # Print error to stderr.
  exit 1 # Stop if yq is missing.
fi

inventory_dir="inventory" # Point to the inventory directory.

if [[ ! -d "${inventory_dir}" ]]; then # Verify inventory directory exists.
  echo "inventory directory not found at ${inventory_dir}" >&2 # Print error to stderr.
  exit 1 # Stop if inventory directory is missing.
fi

tmp_file="$(mktemp)" # Create a temporary file for safe in-place updates.
trap 'rm -f "${tmp_file}"' EXIT # Always remove the temp file on exit.

while IFS= read -r -d '' file; do # Iterate over inventory YAML files safely.
  yq eval -P 'sort_keys(..)' "${file}" > "${tmp_file}" # Sort keys and write to temp file.
  mv "${tmp_file}" "${file}" # Replace original file with sorted version.
done < <(find "${inventory_dir}" -type f \( -name '*.yml' -o -name '*.yaml' \) -print0) # Find all YAML files.

echo "Sorted keys in inventory YAML files." # Confirm completion.
