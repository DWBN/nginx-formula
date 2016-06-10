# nginx.ng.vhosts
#
# Manages virtual hosts and their relationship to the nginx service.
{% set home = nginx.get('home', '/var/www') -%}

{% from 'nginx/ng/map.jinja' import nginx, sls_block with context %}
{% from 'nginx/ng/vhosts_config.sls' import vhost_states with context %}
{% from 'nginx/ng/service.sls' import service_function with context %}

{% macro file_requisites(states) %}
      {%- for state in states %}
      - file: {{ state }}
      {%- endfor -%}
{% endmacro %}

include:
  - nginx.ng.service
  - nginx.ng.vhosts_config

{% if vhost_states|length() > 0 %}
nginx_service_reload:
  service.{{ service_function }}:
    - name: {{ nginx.lookup.service }}
    - reload: True
    - use:
      - service: nginx_service
    - watch:
      {{ file_requisites(vhost_states) }}
    - require:
      {{ file_requisites(vhost_states) }}
      - service: nginx_service
{% endif %}


{{ home }}:
  file:
    - directory
    - user: {{ nginx_map.default_user }}
    - group: {{ nginx_map.default_group }}
    - mode: 2775
    - makedirs: True
