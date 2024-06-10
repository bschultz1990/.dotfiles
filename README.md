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


## PowerShell on Debian

Run the following code, or launch `powershell_install.sh` from this repository:

```bash
###################################
# Prerequisites

# Update the list of packages
sudo apt-get update

# Install pre-requisite packages.
sudo apt-get install -y wget

# Get the version of Debian
source /etc/os-release

# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/debian/$VERSION_ID/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Delete the Microsoft repository GPG keys file
rm packages-microsoft-prod.deb

# Update the list of packages after we added packages.microsoft.com
sudo apt-get update

###################################
# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh
```
