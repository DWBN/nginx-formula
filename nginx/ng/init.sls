# nginx.ng
#
# Meta-state to fully install nginx.

include:
  - nginx.ng.config
  - nginx.ng.service
  - nginx.ng.vhosts
  - nginx.ng.proxy_config

extend:
  nginx_service:
    service:
      - watch:
        - file: nginx_config
        - file: proxy_conf
      - require:
        - file: nginx_config
        - file: proxy_conf
  nginx_config:
    file:
      - require:
        - pkg: nginx_install
