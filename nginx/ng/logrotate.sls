nginx_logrotate:
  file.managed:
    - name: /etc/logrotate.d/nginx
    - source: salt://nginx/ng/files/logrotate/nginx