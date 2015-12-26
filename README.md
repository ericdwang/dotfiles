# Dotfiles

A collection of my dotfiles, serving mainly as a way for me to keep them clean
and document what everything does before I forget.

These files are intended to be used on a GNU/Linux operating system; no idea
if they'll work on OS X or with BusyBox.

## Installation
Just run the `install.sh` script from any directory. It'll create symbolic
links for all the dotfiles if they don't exist.

## Updating
Some files are copied directly from other repositories, so run `update.sh` to
update them.

I considered using git submodules for this, but since most of the time I only
need one file from each repository, cloning the entire repository seemed kind
of overkill. So instead the files are duplicated here, but they can be easily
updated via the script and still kept under version control.
