# nginx.ng.proxy
#
# Manages the main nginx server proxy configuration file.

{% from 'nginx/ng/map.jinja' import nginx, sls_block with context %}


proxy_conf:
  file.managed:
    {{ sls_block(nginx.proxy_opts) }}
    - name: /etc/nginx/proxy.conf
    - source: salt://nginx/ng/files/proxy.conf
    - template: jinja
    - context:
        config: {{ settings.config|json() }}
