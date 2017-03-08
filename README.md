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
| `jenkins_slave_java_opts` | `JAVA_OPTS` to pass Jenkins | `["-Djava.awt.headless=true", "-Djenkins.install.runSetupWizard=false"]` |
| `jenkins_slave_authorized_keys` | ssh public key of the jenkins master | `""` |
| `jenkins_slave_ansible_vault_key` | ansible vault key | `""` |

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
  roles:
    - reallyenglish.java
    - reallyenglish.vagrant
    - reallyenglish.virtualbox
    - reallyenglish.ansible
    - ansible-role-jenkins-slave
  vars:
    jenkins_slave_authorized_keys: "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaT5IMLYf5ZxDgCOAVquYXlaPipWj1YNn99ReHwj8o11KHLQkUa1ESEX8hqzvV7LfYA+sDy5ImaQsqpBYuR/zqDjRQ/s7naVIiRhDjaWaX2EcOJSfzZCyl8RaTz2/bhp3ky6YQzePziKWNdsXQcustDNpyvImirtXHULz5AFjSvIyDE4KWaoYnrAH/CWxabrVrQ8vgC8mMgrODL0uplU5VyFPojFfZl5+q9JJLv4thwkfw/aYWjIcKm8VY6IWD7MqsVA5NFCK5yMhN+yPqN3IXXd8ZuYu2yEzQbxSFLoK6StjmsDPyCjwqjT1vJsIevM2Tf2cs/tWeMFt6ew11fgen test@example.com"
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
