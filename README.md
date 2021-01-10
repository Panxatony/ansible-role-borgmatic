borgmatic_client
=========

Ansible role to install and configure the borgmatic backup tool

This role installs and configures [borgmatic](https://torsion.org/borgmatic/), a configuration-based backup software built around [borgbackup](https://www.borgbackup.org/). With this role, you can:

- Install both borg and borgmatic
- Set the borgmatic configuration file
- Schedule backups with systemd timers on Linux and cron on other systems

Note that the role installs borgmatic from pip (Python 3) regardless of distro. It will also install pip3 if it is not present. The borgmatic install is a user install only available to root, so there are no conflicts with system libraries.

Requirements
------------

This role requires `become` privileges.

This role has been tested on the following systems:

- Ubuntu 18.04 LTS and newer (only LTS versions are tested)
- Debian 9 (Stretch) and newer
- CentOS 7 and newer
- Fedora 32 and newer
- ArchLinux
- OpenSUSE Leap 15.2 and newer
- FreeBSD 11 and newer

**Note that CentOS/RedHat distributions require the EPEL to be installed/enabled.**

Other distributions might also work, but are not officially supported.

This role will run with both python2 and 3.


Role Variables
--------------

See `defaults/main.yml` for more information about these vars

- borgmatic_config_dir, borgmatic_sshkey_dir: Directories for the borgmatic config file and ssh key respectively. The SSH key is used to connect to repos on remote hosts
- borgmatic_encryption_mode: The [encryption mode](https://borgbackup.readthedocs.io/en/stable/usage/init.html#encryption-modes) to use when initializing new repositories
- borgmatic_config: The borgmatic config file, as a YAML dictionary
- borgmatic_backup_now: Run the backup task at the end of this role
- borgmatic_schedule_linux/freebsd: The schedule for the timed backup task. Uses systemd date notation on Linux and cron notation on FreeBSD
- borgmatic_required_systemd_units: List of systemd units that the backup tasks depends on. Useful if i.e a repository is on a mounted filesystem

Dependencies
------------

None

Example Playbook
----------------

```
- hosts: all
  roles:
    - role: borgmatic_client
      vars:
        borgmatic_config:
          location:
            repositories:
            - /var/borgmatic_example
            source_directories:
            - /etc
            - /home
          storage:
            encryption_passphrase: borgmatic_example
            # !WARNING! If you want to change the SSH command, make sure to include the path to
            # the borgmatic SSH key as shown below, else creating backups on remote hosts might fail
            ssh_command: 'ssh -i {{ borgmatic_config_dir }}/id_rsa'
          retention:
            keep_daily: 7
            keep_weekly: 4
            keep_monthly: 6
        borgmatic_backup_now: yes
      become: yes
```

License
-------

GNU GPL 3 or later

Author Information
------------------

This role is mirrored on GitHub for convenience and integration into ansible-galaxy. If you'd like to contribute or have an issue to file, then please do so on the [official Gitea instance](https://git.arios.me/ansible_roles/borgmatic_client).

