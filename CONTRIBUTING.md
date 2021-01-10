# Contributing to this role

This document contains the information you will need to contribute to this role.

---
**NOTE**

This role is hosted at https://git.arios.me/ansible_roles/borgmatic_client. If you are reading this on GitHub, please make sure to submit your contributions there
---

## Getting Started

Before you fork this repo, please note:

- This role uses [git-flow](https://github.com/nvie/gitflow) for its branching model, so make sure that you have it installed!
- Vagrant + Virtualbox are used for testing. Both should be in your distros repository (e.g. `sudo apt install vagrant virtualbox`) on Ubuntu
- ansible-lint for linting and other checks

## Contributing changes

To create a pull request, please follow the steps below:

1. Create a fork of this repo in the Gitea UI
2. Clone your fork to your dev machine
3. Run `git flow feature start <your-feature-name>` to create a new branch for the feature that you want to work
4. Develop your feature
5. Run ansible-lint on the role and fix any issues that pop up
6. Test your changes with the testing tools (see below). **This step is important!**
7. Once all tests have passed and you think your feature is ready, push the changes to your fork and open a pull request on this repository

## Testing your changes

You can test any changes that you've made with the `test.sh` script. This script will run the role on all of the supported operating systems using Vagrant and Virtualbox. Here are the basic steps to using it:

1. cd into the `tests/` folder
2. run `./test.sh` and wait for it to finish (can take 15-45 minutes).
3. The script will show you if any of the boxes have failed their tests. If so, you can diagnose them by running `vagrant ssh <box_name>`.
4. Once you have implemented a fix, you can test it against only one or several machines, run `vagrant up --provision <box_name1> <box_name2> ...`. If you want to start with a clean box, run `vagrant prune <box_name1>` first. Rinse and repeat until all boxed that had failed come out as successes.
5. Once everything seems to work again, run the `test.sh` script again to verify that you didn't accidentally break anything else.
