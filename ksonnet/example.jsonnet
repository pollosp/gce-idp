//https://www.youtube.com/watch?v=i5PVp92tAmE&t=873s

local k = import "../../ksonnet-lib/ksonnet.beta.2/k.libsonnet";
local deployment = k.apps.v1beta1.deployment;
local container = deployment.mixin.spec.template.spec.containersType;
local containerPort = container.portsType;

// Create nginx container with container port 80 open.
local version = 5+5;
local sum = function (a,b) a+b;
local var1_value=std.extVar('var1_value');
//local var1_value='XXX';

local nginxContainer =
  container.new("nginx", "nginx:"+sum(version,4)) +
  container.ports(containerPort.newNamed("http", 80))+
(if version == 10 then
container.env([
    container.envType.new("VAR1", "wwww"),
    container.envType.new("VAR2", var1_value)])
else container.env([
    container.envType.new("VAR1", var1_value),
    container.envType.new("VAR2", "GATO")]));



// Create default Deployment object from nginx container.
deployment.new("nginx", 10, nginxContainer, {app:  "nginx"})+
deployment.mixin.metadata.namespace('Ardilla')
