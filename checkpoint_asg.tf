# Deploy CP Geo Cluster for TGW cloudformation template
# https://sc1.checkpoint.com/documents/IaaS/WebAdminGuides/EN/CP_CloudGuard_for_AWS_Transit_Gateway_High_Availability/Content/Topics/Terms.htm?tocpath=_____4
resource "aws_cloudformation_stack" "checkpoint_asg_cloudformation_stack" {
  name = "${var.project_name}-ASG"

  parameters = {
CloudWatch		= false
ELBClients		= "0.0.0.0/0"
ELBPort			= "8080"
ELBType			= "none"
EnableInstanceConnect	= false
EnableVolumeEncryption	= false
GatewayBootstrapScript	= ""
GatewaysSubnets		= "${aws_subnet.sn_ingress_gwlbe_a.id},${aws_subnet.sn_ingress_gwlbe_b.id}"
VPC			= aws_vpc.vpc_ingress.id
VolumeSize		= 100
AllowUploadDownload	= true	
ManagementServer        = "${var.project_name}-management-server"
ConfigurationTemplate	= "${var.project_name}-ASG-configuration"
ControlGatewayOverPrivateOrPublicAddress	= "private"
GatewayName	 = "${var.project_name}-asg-gw"
GatewayInstanceType     = var.geocluster_gateway_size
GatewayVersion          = "${var.cpversion}-BYOL"
GatewaysMaxSize	= 1
GatewaysMinSize	= 1
Shell	= "/bin/bash"
KeyName                 = aws_key_pair.key_TPOT.key_name
GatewayPasswordHash     = var.password_hash
Shell                   = "/bin/bash"
GatewaySICKey	    = var.sickey
}

  template_url        = "https://cgi-cfts.s3.amazonaws.com/autoscale/autoscale.yaml"
  capabilities        = ["CAPABILITY_IAM"]
  disable_rollback    = true
  timeout_in_minutes  = 50
}
