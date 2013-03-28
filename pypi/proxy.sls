include:
  - nginx

{% from "nginx/proxy.sls" import proxy %}

{{ proxy(site='pypi', server='127.0.0.1', port=pillar['pypi']['port'], http=True, https=False) }}
