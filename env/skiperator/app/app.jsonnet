local argokit = import '../../../argokit/v2/jsonnet/argokit.libsonnet';
local app = argokit.appAndObjects.application; 

app.new('go-webserver','go-http-server',8080)