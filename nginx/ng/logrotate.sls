{% from 'nginx/ng/map.jinja' import nginx, sls_block with context %}
nginx_logrotate:
  file.managed:
    - name: /etc/logrotate.d/nginx
    - source: salt://nginx/ng/files/logrotate/nginx
    - template: jinja
    - context:
        config: {{ nginx.server.config|json() }}
