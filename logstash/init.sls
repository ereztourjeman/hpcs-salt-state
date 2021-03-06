# Copyright 2012-2013 Hewlett-Packard Development Company, L.P.
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
include:
  - java
  - ssl

logstash:
  user.present:
    - home: /mnt/logstash
    - shell: /bin/bash
    - system: True
    - gid_from_name: True
    - groups:
      - ssl-cert
    - require:
      - group: logstash
      - group: ssl-cert
  group.present:
    - system: True

/mnt/logstash/logstash.jar:
  file.managed:
    - source: http://logstash.objects.dreamhost.com/release/logstash-1.1.12-flatjar.jar
    - source_hash: md5=fd793a685bc8e4d255fbce561574faef
    - user: logstash
    - group: logstash
    - require:
      - user: logstash
      - group: logstash
      - pkg: java

/var/log/logstash:
  file.directory:
    - user: logstash
    - group: logstash
    - require:
      - user: logstash
      - group: logstash

/etc/logstash:
  file.directory:
    - user: logstash
    - group: logstash
    - require:
      - user: logstash
      - group: logstash

/etc/logrotate.d/logstash:
  file.managed:
    - source: salt://logstash/logrotate.conf
