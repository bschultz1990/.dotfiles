# Installation

## Bash
**Place the following inside your system's ~/.bashrc file:
```bash
# Bash Scripts
# Bash Scripts
if [ -d ~/bash_scripts ]; then
    for file in ~/bash_scripts/*; do
        . $file
    done
fi
```

- Copy the `bash_scripts` folder from this repository to your HOME directory: `~/`
- Reload your shell
