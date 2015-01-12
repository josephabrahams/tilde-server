{% for user, args in pillar.get('users', {}).items() %}
{{ user }}:
  group.present:
    - gid: {{ args['gid'] }}

  user.present:
    - fullname: {{ args['fullname'] }}
    - uid: {{ args['uid'] }}
    - gid: {{ args['gid'] }}
    - home: {{ args['home'] }}
    - shell: {{ args['shell'] }}
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
      - file: /etc/skel/public_html/homework

  {% if 'keys' in args %}
  ssh_auth.present:
    - user: {{ user }}
    - names: {{ args['keys'] }}
  {% endif %}

{% endfor %}

