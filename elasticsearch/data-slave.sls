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
  - elasticsearch

/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source: salt://elasticsearch/elasticsearch.yml
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - context: {
      master: false,
      data: true,
      refresh: 5s }
    - require:
      - pkg: elasticsearch

