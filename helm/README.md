# dpg-server Helm Repo

### The helm chart to automate the deployment of dpgraham.com's back end go server

```
# notes for me:
# if I install with release name foo (helm install . foo)
{{ include "dpg-server.fullname" . }} # evaluates to foo-dpg-server (where "dpg-server" comes from the chart.yaml name)

{{- include "dpg-server.labels" . | nindent 4 }} # adds a bunch of labels like
#  app.kubernetes.io/instance=foo
#  app.kubernetes.io/managed-by=Helm
#  app.kubernetes.io/name=dpg-server
#  app.kubernetes.io/version=0.0.3
#  helm.sh/chart=dpg-server-0.0.3

```

