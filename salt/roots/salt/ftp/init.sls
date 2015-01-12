vsftpd:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: vsftpd
    - watch:
      - file: /etc/vsftpd.conf

/etc/vsftpd.conf:
  file.managed:
    - source: salt://ftp/vsftpd.conf

