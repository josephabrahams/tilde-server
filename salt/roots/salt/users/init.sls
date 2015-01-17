{% for user, args in pillar.get('users', {}).items() %}
{{ user }}:
  group.present:
  {% if 'gid' in args %}
    - gid: {{ args['gid'] }}
  {% elif 'uid' in args  %}
    - gid: {{ args['uid'] }}
  {% endif %}

  user.present:
    {% if 'fullname' in args %}
    - fullname: {{ args['fullname'] }}
    {% endif %}
    {% if 'uid' in args %}
    - uid: {{ args['uid'] }}
    {% endif %}
    {% if 'gid' in args %}
    - gid: {{ args['gid'] }}
    {% else %}
    - gid_from_name: True
    {% endif %}
    {% if 'home' in args %}
    - home: {{ args['home'] }}
    {% else %}
    - home: /home/{{ user }}
    {% endif %}
    {% if 'shell' in args %}
    - shell: {{ args['shell'] }}
    {% endif %}
    {% if 'password' in args %}
    - password: {{ args['password'] }}
    {% endif %}
    {% if 'groups' in args %}
    - groups: {{ args['groups'] }}
    {% endif %}
    {% if 'optional_groups' in args %}
    - optional_groups: {{ args['optional_groups'] }}
    {% endif %}
    - require:
      - group: {{ user }}
      {% if 'groups' in args %}
      {% for group in args['groups'] %}
      - group: {{ group }}
      {% endfor %}
      {% endif %}
      - file: /etc/skel

  {% if 'keys' in args %}
  ssh_auth.present:
    - user: {{ user }}
    - names: {{ args['keys'] }}
    - require:
      - user: {{ user }}
  {% endif %}

{% endfor %}

# pillar example
#
# users:
#   jdoe:
#     fullname: John Doe
#     uid: 2001
#     gid: 2001
#     home: /home/jdoe
#     shell: /bin/bash
#     keys:
#       - ssh-rsa AAA...3bp john@doe.net
#     groups:
#       - examplegroup
#     optional_groups:
#       - adm
#       - sudo

