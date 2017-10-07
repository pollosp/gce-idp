local k = import "../../ksonnet-lib/ksonnet.beta.2/k.libsonnet";
local deployment = k.apps.v1beta1.deployment;
local service = k.core.v1.service;
local servicePort = k.core.v1.service.mixin.spec.portsType;
local container = deployment.mixin.spec.template.spec.containersType;
local containerPort = container.portsType;

// Create ghost container with container port 80 open.
local version = "1.12.1-alpine";
local port = std.parseInt(std.extVar('port'));
local replicas = std.parseInt(std.extVar('replicas'));
local enviroment = std.extVar('enviroment');

local ghostContainer =
  container.new("ghost", "ghost:"+version) +
  container.ports(containerPort.newNamed("http", port))+
(if enviroment == "prod" then
container.env([
    container.envType.new("VAR1", "prod")])
else container.env([
    container.envType.new("VAR1", "staging")]));



// Create default Deployment object from ghost container.
local ghostDeployment = deployment.new("ghost", replicas, ghostContainer, {app:  "ghost"})+
deployment.mixin.metadata.namespace('default');

local ghostService =
  local ghostServicePort = servicePort.port(80) + servicePort.targetPort(port) + servicePort.protocol("TCP");
  service.new("my-ghost", {app: "ghost"}, ghostServicePort) +
  service.mixin.spec.type("LoadBalancer") +
  service.mixin.metadata.labels({app: "ghost"});

k.core.v1.list.new([
  ghostDeployment,
  ghostService
])
