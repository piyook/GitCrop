# Git Crop Bash Script

Git Crop is a simple bash script that allows you to safely delete all branches in a git repository with a single command matching a given pattern.

This script is easier and safer than using the Git command below:

```bash
git branch -D $(git branch --list 'pattern/*')
```

## Usage

To use Git Crop, simply run the script in a Git repo with the pattern you want to match as an argument. For example:

```bash
GitCrop 'feature/*'
```

This will delete all branches in the current Git repo that match the pattern "feature/\*" first listing them and checking you want them deleted before deleting them.

## Installation

To install Git Crop, simply copy the script to a directory on your PATH and make it executable.

### Linux / Mac / WSL:

1. Copy the file to a desired location:

```bash
cp GitCrop.sh /usr/local/bin
```

2. Make it executable:

```bash
chmod +x /usr/local/bin/GitCrop.sh
```

3. Add the following line to your .bash_aliases file:

```bash
alias GitCrop='/usr/local/bin/GitCrop.sh'
```

4. Check it works:

```bash
source ~/.bashrc

GitCrop
```

### Windows Powershell:

If using WSL then add as above for Linux and then to make this execute in Powershell:

1. Copy the GitCrop.bat batch file to any suitable location specified in your PATH E.g: C:\Windows

```PowerShell
Move-Item GitCrop.bat C:\Windows
```

2. Check it works:

```PowerShell
GitCrop
```

### Note for Git Bash on Windows:

1. Copy the GitCrop.sh file to any suitable location

```bash
cp GitCrop.bat ~/Scripts
```

2. Make it executable:

```bash
chmod +x ~/Scripts/GitCrop.sh
```

3. Add the following line to your .bash_aliases file:

```bash
alias GitCrop='~/Scripts/GitCrop.sh'
```

## License

This script is released under the [MIT License](https://opensource.org/licenses/MIT).
