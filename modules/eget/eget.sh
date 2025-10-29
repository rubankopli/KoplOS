#!/usr/bin/env bash
set -euo pipefail

# # read a single variable from the configuration
# # `try` makes the command output 'null' if the key is not found, otherwise it will error out and the build will fail
# # the `.["var"]` syntax is optional and could be replaced with the less safe and more error-prone `.var` syntax
# VAR=$(echo "$1" | jq -r 'try .["var"]')
# echo "$VAR"

# # read an array from the configuration
# get_json_array ARRAY 'try .["array"][]' "$1"
# # loop over the array
# for THING in "${ARRAY[@]}"; do
#     echo "$THING"
# done

# TODO: Actually install eget itself, lmao

EGET_CONFIG=$(echo "$1" | jq -r 'try .["config-location"]')
export EGET_CONFIG
echo "Got provided eget config directory: $EGET_CONFIG"

echo "Installing eget"
curl -o eget.sh https://zyedidia.github.io/eget.sh
EXPECTED_CHECKSUM="$(echo "$1" | jq -r 'try .["install-script-checksum"]')  eget.sh"
ACTUAL_CHECKSUM=$(shasum --algorithm 256 eget.sh)
# Make sure the eget install script checksum checks out
if [[ "$EXPECTED_CHECKSUM" == "$ACTUAL_CHECKSUM" ]]; then
    bash eget.sh
else
    echo "The eget install script's checksum did not match the checksum we expected!"
    echo "Expected: $EXPECTED_CHECKSUM"
    echo "Actual:   $ACTUAL_CHECKSUM"
    exit 1
fi
# Run the install script
bash eget.sh
# Move the eget binary to a location on PATH
cp eget /usr/bin/

get_json_array PACKAGE_LIST 'try .["install-packages"][]' "$1"
for PACKAGE in "${PACKAGE_LIST[@]}"; do
    echo "Installing package from: $PACKAGE"
    # We override the config and install to '/usr/bin' because we cannot install to '/usr/local/bin'
    # because that directory will be later symlinked by rpm-ostree
    eget --to /usr/bin/ $PACKAGE
done

# TODO: Can do the following if the install list given is empty?
# eget --to /usr/bin --download-all
