# ansible-role-jenkins-slave

A brief description of the role goes here.

# Requirements

None

# Role Variables

| variable | description | default |
|----------|-------------|---------|
| `jenkins_slave_user` | Jenkins user | `{{ __jenkins_slave_user }}` |
| `jenkins_slave_group` | Jenkins group | `{{ __jenkins_slave_group }}` |
| `jenkins_slave_home` | Jenkins home | `{{ __jenkins_slave_home }}` |
| `jenkins_slave_package` | package name | `{{ __jenkins_slave_package }}` |

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
