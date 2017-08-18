# ansible-role-jenkins-slave

Installs and configures Jenkins slave node.

# Requirements

None

# Role Variables

| variable | description | default |
|----------|-------------|---------|
| `jenkins_slave_user` | Jenkins user | `{{ __jenkins_slave_user }}` |
| `jenkins_slave_group` | Jenkins group | `{{ __jenkins_slave_group }}` |
| `jenkins_slave_home` | Jenkins home | `{{ __jenkins_slave_home }}` |
| `jenkins_slave_package` | package name | `{{ __jenkins_slave_package }}` |
| `jenkins_slave_extra_packages` | list of extra packages to install, such as `rake`. you may install any packages using the variable, but the role does nothing more than installing them. | `[]` |
| `jenkins_slave_extra_npm_packages` | list of extra npm packages to install, such as `phantomjs`. you may install any packages using the variable, but the role does nothing more than installing them. | `[]` |
| `jenkins_slave_java_opts` | `JAVA_OPTS` to pass Jenkins | `["-Djava.awt.headless=true", "-Djenkins.install.runSetupWizard=false"]` |
| `jenkins_slave_authorized_keys` | ssh public key of the jenkins master | `""` |
| `jenkins_slave_ansible_vault_key` | ansible vault key | `""` |
| `jenkins_slave_master_ssh_private_key` |ssh private key of the jenkins master | ""
| `jenkins_slave_master_ssh_passphrase` | ssh passphrase of the jenkins master | ""
| `jenkins_slave_enable_debug` | enable debug log during play when `yes`. should not be `yes` in production because the role logs sensitive information including SSH private key | `no` |

### jenkins_slave_authorized_keys

`jenkins_slave_authorized_keys` is overwritten by the one generated from
`jenkins_slave_master_ssh_private_key` if
`jenkins_slave_master_ssh_private_key` is not empty.

## Debian

| Variable | Default |
|----------|---------|
| `__jenkins_slave_user` | `jenkins` |
| `__jenkins_slave_group` | `jenkins` |
| `__jenkins_slave_home` | `/var/lib/jenkins` |
| `__jenkins_slave_package` | `jenkins` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__jenkins_slave_user` | `jenkins` |
| `__jenkins_slave_group` | `jenkins` |
| `__jenkins_slave_home` | `/usr/local/jenkins` |
| `__jenkins_slave_package` | `jenkins` |

## RedHat

| Variable | Default |
|----------|---------|
| `__jenkins_slave_user` | `jenkins` |
| `__jenkins_slave_group` | `jenkins` |
| `__jenkins_slave_home` | `/var/lib/jenkins` |
| `__jenkins_slave_package` | `jenkins` |


# Dependencies

```yaml
dependencies:
  - { role: reallyenglish.java }
  - { role: reallyenglish.vagrant }
  - { role: reallyenglish.virtualbox }
  - { role: reallyenglish.ansible }
```

# Example Playbook

```yaml
- hosts: localhost
  vars_files:
    - jenkins_slave_master_ssh_private_key.yml
  pre_tasks:
    - yum:
        # XXX workaround bug 13669
        # https://bugs.centos.org/view.php?id=13669&nbn=1
        name: https://kojipkgs.fedoraproject.org//packages/http-parser/2.7.1/3.el7/x86_64/http-parser-2.7.1-3.el7.x86_64.rpm
        state: present
      when:
        - "ansible_distribution == 'CentOS'"
        - "ansible_distribution_version | version_compare('7.4', '<')"
  roles:
    - reallyenglish.redhat-repo
    - reallyenglish.apt-repo
    - reallyenglish.java
    - reallyenglish.vagrant
    - reallyenglish.virtualbox
    - reallyenglish.ansible
    - ansible-role-jenkins-slave
  vars:
    apt_repo_to_add:
      - ppa:webupd8team/java
    redhat_repo_extra_packages:
      - epel-release
    redhat_repo:
      epel:
        mirrorlist: "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-{{ ansible_distribution_major_version }}&arch={{ ansible_architecture }}"
        gpgcheck: yes
        enabled: yes
    jenkins_slave_extra_packages: "{% if ansible_os_family == 'FreeBSD' %}[ 'rubygem-rake', 'phantomjs' ]{% elif ansible_os_family == 'Debian' %}[ 'rake', 'phantomjs' ]{% elif ansible_os_family == 'RedHat' %}[ 'rubygem-rake' ]{% else %}[]{% endif %}"
    jenkins_slave_extra_npm_packages: "{% if ansible_os_family == 'RedHat' %}[ 'phantomjs' ]{% else %}[ 'jenkins' ]{% endif %}"
    jenkins_slave_master_ssh_passphrase: passphrase
    jenkins_slave_ansible_vault_key: "QriBECUJGKBq4a1fMTMClAqqqaGuH8DG6jujJllw"
```

# License

```
Copyright (c) 2017 mitsuruy,,, <mitsuruy@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

mitsuruy,,, <mitsuruy@reallyenglish.com>

This README was created by [qansible](https://github.com/trombik/qansible)
