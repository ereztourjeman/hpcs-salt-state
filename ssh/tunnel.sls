{% macro tunnel(user, jump_host, local_port, dest_addr, dest_port, bind_addr='localhost', ssh_key=None) -%}
ssh_tunnel_{{ local_port }}_{{ dest_addr }}_{{ dest_port }}:
  cmd.run:
    - name: 'dtach -n /var/run/ssh.tunnel.{{ local_port }}.{{ dest_addr }}.{{ dest_port }} ssh -N -f -L {{ bind_addr }}:{{ local_port }}:{{ dest_addr }}:{{ dest_port }} {% if ssh_key %} -i {{ ssh_key }} {% endif %} {{ user }}@{{ jump_host }}'
    - unless: netstat -plunt | grep {{ local_port }}
    - require:
      - pkg: ssh
      {% if ssh_key %}- file: {{ ssh_key }} {%- endif %}

{% if ssh_key -%}
{{ ssh_key }}:
  file.exists:
    - name: {{ ssh_key }}
{%- endif %}
{%- endmacro %}
