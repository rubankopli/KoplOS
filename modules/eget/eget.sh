#!/usr/bin/env bash
set -euo pipefail

echo "HEY!"

# TODO: Use the configuration file we copy over to /etc/eget/eget.toml (or just use the one in 'system' so we don't have to wait on the 'files' module!)
# TODO: Can use the 'EGET_CONFIG' environment variable to set the config file used

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

get_json_array PACKAGE_LIST 'try .["install-packages"][]' "$1"
for PACKAGE in "${PACKAGE_LIST[@]}"; do
    echo "Installing package from: $PACKAGE"
    # eget $PACKAGE # TODO: Need to get the eget install set up before uncommenting this
done
