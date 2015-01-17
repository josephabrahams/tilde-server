{% for group, args in pillar.get('groups', {}).items() %}
{{ group }}:
  group.present:
    - name: {{ group }}
    {% if 'gid' in args %}
    - gid: {{ args['gid'] }}
    {% endif %}
{% endfor %}

# pillar example
#
# groups:
#   examplegroup:
#     gid: 2000
#

