
[private]
default:
    @just --list


# Command: build
# Description: builds container/OS image directly from a recipe file
build RecipeFile='recipes/recipe.yaml':
    #!/usr/bin/env bash
    bluebuild build "{{RecipeFile}}"

# Command: generate
# Description: Generates a containerfile from a recipe file
generate OutputFile='containerfile' RecipeFile='recipes/recipe.yaml':
    #!/usr/bin/env bash
    bluebuild generate --output {{OutputFile}} {{RecipeFile}}

# Command: generate-iso
# Description: Generates a ISO image from a recipe file
generate-iso ISOName='KoplOS' RecipeFile='recipes/recipe.yaml':
    #!/usr/bin/env bash
    bluebuild generate-iso --iso-name {{ISOName}} recipe {{RecipeFile}}
    mv {{ISOName}} {{ISOName}}.iso

# Command: validate
# Description: Validates recipe files
validate RecipeFile='recipes/recipe.yaml':
    #!/usr/bin/env bash
    bluebuild validate --all-errors {{RecipeFile}}

# Command: run-docker
# Description: Uses a (previously built) koplos docker image to spin up a container and attaches to it
run-docker Tag='latest':
    #!/usr/bin/env bash
    docker run --rm -it localhost/koplos:{{Tag}} /bin/bash
