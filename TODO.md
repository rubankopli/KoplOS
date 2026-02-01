# TODO
1. Figure out setting fish as default shell?
2. Figure out fish plugins?
    - Maybe make a custom 'fish' module?
    - Could just use a script directly for now
3. rclone setup
4. Add versioning info for releases
    - Append version to generated .iso image


## Major
- Figure out config strategy?
    > Make/use "KoplOS-Configs" repo for default chezmoi config? Users can change it later?
        >> Or perhaps have this selected at install time somehow?
- Set up `eget` service to do updates every boot?

## Modules
- Included
    - `yafti`
    - `default-flatpaks`
        - Finish adding flatpaks
        - Might be better to do this through yafti?
    - `os-release`
        - Need to update some of the fields set by Bazzite, create a logo, etc.
    - `soar`
- Custom
    - Set up [custom module repository](https://blue-build.org/how-to/module-repository/) for eget
    - `fish` custom module & custom module repository?
    - 'rclone' module/module repository?
    - 'espanso' module/module repository?

## Packages
- `floorp` system package
- `bitwarden` rpm (use eget for system integration)
- Add `fnm` (fast node manager)
- `snapclient` (requires build from source OR brew)
    > Probably want to set the config in /etc/default/snapclient as well?
- `Tomb`

## Scripts/etc
- `cope` perl script CLI colorizer?
- `ANSI` package through `BPM`

## Configs
- Add some default configs to /etc/ maybe?
- Espanso packages

## Documentation
- Update README.md
