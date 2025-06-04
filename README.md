![GitHub Release](https://img.shields.io/github/v/release/piyook/gitcrop)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# Gitcrop Branch Batch Deletion Command Line Utility for Git Repositories :scissors:

Lets face it - old redundant branches can quickly start to get out of hand and clog up your local repo. :face_with_spiral_eyes:

Tidying up a local repo by deleting branches one by one can be a real pain and using the usual Git command can mean accidentally deleting the wrong branch or deleting a branch you don't want to delete. :cursing_face:

Git Crop is a simple bash script that allows you to safely delete all branches matching a given pattern in a LOCAL git repository with a single command.

The search pattern automatically excludes protected branches such as the default ('main' or 'master') branch and any 'develop' branches to prevent deleting them by accident. Other protected branches patterns can be added into the EXCEPTIONS variable command in the script.

This script is easier and safer than using the usual Git command below:

```bash
git branch -D $(git branch --list 'pattern/*')
```

## Usage

To use Git Crop, simply run the script in a Git repo with the pattern you want to match as an argument. For example:

```bash
gitcrop feature/
```

This will delete all branches in the current Git repo that match the pattern "feature/" first listing them and checking you want them deleted before deleting them.

Example - to delete ALL branches except 'main' or 'develop' use . to match all branches :bomb: :bomb: :boom:

```bash
gitcrop --nuke

WARNING: The following branches will be PERMANENTLY deleted:
  chore/apply_patch-2
  chore/pr-21
Are you sure? (y/n)
```

## Options

- use '--help' or '-h' to display a help message
- use '--nuke' to delete ALL local branches except 'main' or 'develop'
- use '--merged' or '-m' to only delete branches MERGED into main (or master) branch matching the supplied pattern

<i>Note: branches that are newly created from the main branch with no new commits that match the search pattern will also be deleted since they are fully merged by default.</i>

E.g

```bash
gitcrop feature/ --merged
```

will only delete branches merged into main (or are identical) that match the pattern 'feature/'

## Installation

To install Git Crop, simply copy the script to a directory on your PATH and make it executable.

### Linux / Mac / WSL:

1. Run the setup script:

```bash
bash setup_linux.sh
```

2. Check it works:

```bash
source ~/.bashrc

gitcrop --help
```

### Windows Powershell:

Setup using WSL with your distro of choice as above for Linux and then:

1. Use Powershell to copy the gitcrop.bat batch file to any suitable location specified in your PATH E.g: C:\Windows

```PowerShell
Move-Item gitcrop.bat C:\Windows
```

2. Check it works:

```PowerShell
gitcrop --help
```

### Note for Git Bash on Windows:

1. Run the setup script:

```bash
bash setup_gitbash.sh
```

This creates a Scripts directory in the user's home directory (if one doesn't already exist) and copies the gitcrop.sh script into it, makes it executable and adds an alias for easy access.

2. Check it works:

```bash
source ~/.bashrc

gitcrop --help
```

## License

This script is released under the [MIT License](https://opensource.org/licenses/MIT).
