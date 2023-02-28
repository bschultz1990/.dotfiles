# Bash and ZSH Scripting

## Restart Your Session
`exec name_of_shell`

## Get the name of your shell
echo $0

## Check If An App Exists or Command Exists
```bash
if type "apphere" &> /dev/null; then
# run stuff here
fi
```

## Check if a file or directory exists
```bash
if [ -e /path/to/file/or/directory ]; then
	# file exists!
fi
```
