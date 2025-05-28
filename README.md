# Git Crop Bash Script

Git Crop is a simple bash script that allows you to safely delete all branches in a LOCAL git repository with a single command matching a given pattern.  
The search pattern automatically excludes the 'main' branch to prevent deleting it by accident. Other protected branches patterns can be added into the 'grep -v' command in the script.

This script is easier and safer than using the Git command below:

```bash
git branch -D $(git branch --list 'pattern/*')
```

## Usage

To use Git Crop, simply run the script in a Git repo with the pattern you want to match as an argument. For example:

```bash
gitcrop 'feature/*'
```

This will delete all branches in the current Git repo that match the pattern "feature/\*" first listing them and checking you want them deleted before deleting them.

## Installation

To install Git Crop, simply copy the script to a directory on your PATH and make it executable.

### Linux / Mac / WSL:

1. Copy the file to a desired location:

```bash
cp gitcrop.sh /usr/local/bin
```

2. Make it executable:

```bash
chmod +x /usr/local/bin/gitcrop.sh
```

3. Add the following line to your .bash_aliases file:

```bash
alias gitcrop='/usr/local/bin/gitcrop.sh'
```

4. Check it works:

```bash
source ~/.bashrc

gitcrop
```

### Windows Powershell:

If using WSL then add as above for Linux and then to make this execute in Powershell:

1. Copy the gitcrop.bat batch file to any suitable location specified in your PATH E.g: C:\Windows

```PowerShell
Move-Item gitcrop.bat C:\Windows
```

2. Check it works:

```PowerShell
gitcrop
```

### Note for Git Bash on Windows:

1. Copy the gitcrop.sh file to any suitable location

```bash
cp gitcrop.bat ~/Scripts
```

2. Make it executable:

```bash
chmod +x ~/Scripts/gitcrop.sh
```

3. Add the following line to your .bash_aliases file:

```bash
alias gitcrop='~/Scripts/gitcrop.sh'
```

## License

This script is released under the [MIT License](https://opensource.org/licenses/MIT).
