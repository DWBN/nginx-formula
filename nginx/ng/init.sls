# nginx.ng
#
# Meta-state to fully install nginx.
{% set conf_dir = nginx.get('conf_dir', '/etc/nginx') -%}


include:
  - nginx.ng.config
  - nginx.ng.service
  - nginx.ng.vhosts
  - nginx.ng.certificates
  - nginx.ng.proxy_config

extend:
  nginx_service:
    service:
      - watch:
        - file: nginx_config
      - require:
        - file: nginx_config
  nginx_config:
    file:
      - require:
        - pkg: nginx_install

{% set home = nginx.get('home', '/var/www') -%}


{{ home }}:
  file:
    - directory
    - user: {{ nginx_map.default_user }}
    - group: {{ nginx_map.default_group }}
    - mode: 2775
    - makedirs: True
