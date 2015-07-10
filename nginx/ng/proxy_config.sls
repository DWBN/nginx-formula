include:
  - nginx.ng.service


{% from 'nginx/ng/map.jinja' import nginx, sls_block with context %}


proxy_conf:
  file.managed:
    {{ sls_block(nginx.proxy.opts) }}
    - name: /etc/nginx/proxy.conf
    - source: salt://nginx/ng/files/proxy.conf
    - template: jinja
    - context:
        config: {{ nginx.proxy.config|json() }}
    - watch_in:
      - service: nginx_service

