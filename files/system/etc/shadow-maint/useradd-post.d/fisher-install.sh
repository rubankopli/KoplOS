#!/bin/bash

# Install the 'fisher' plugin manager
fish --command="curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
# Have fisher install all plugins defined in the fish_plugins file
fish --command="fisher update"
