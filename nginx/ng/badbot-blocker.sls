include:
  - nginx.ng.service

/etc/nginx/conf.d/blacklist.conf
  file.managed:
    - source: https://raw.githubusercontent.com/mariusv/nginx-badbot-blocker/master/blacklist.conf
    - user: root
    - group: root
    - mode: 644
    - source_hash: md5=79A84C2F50FC0CB3AD29A15343178804
    - watch_in:
      - service: nginx_service
