# nginx.ng
#
# Meta-state to fully install nginx.


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
