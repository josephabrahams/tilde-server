apache2:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: apache2
    - watch:
      - apache_module: apache_cgi_enable
      - apache_module: apache_include_enable
      - apache_module: apache_rewrite_enable
      - apache_module: apache_userdir_enable
      - file: /etc/apache2/sites-available/000-default.conf

apache_cgi_enable:
  apache_module.enable:
    - name: cgid

apache_include_enable:
  apache_module.enable:
    - name: include

apache_rewrite_enable:
  apache_module.enable:
    - name: rewrite

apache_userdir_enable:
  apache_module.enable:
    - name: userdir

/etc/apache2/sites-available/000-default.conf:
  file.managed:
    - source: salt://apache/000-default.conf

