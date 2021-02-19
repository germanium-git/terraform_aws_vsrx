# terraform_aws_vsrx
Automated deployment of vSRX firewall in HA setup on AWS.

## Deployment scenario description

## Steps to reproduce



### SRX initial config
The EC2 instances of vSRX appliances are configured with the template [vsrx.tmpl](modules/jnpr_aws_ec2/vsrx.tmpl). The valid template structure has to begin with hash and the keyword junos-config.

```sh
#junos-config
"add valid config there"
```



