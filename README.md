# Engineering assignment - Automate EC2 and Docker

This project uses Terraform to initialise an Amazon linux 2 instance, install docker, and start an nginx server

Requires aws cli and terraform to run

## How to use: 

Run AWS configure to set up credentials:

```
aws configure
```

then check your plan using 

```
terraform plan
```

and create your insfrastructure using

```
terraform apply
```

## Discussion

I have opted to use terraform and a cloudinit script, as it was familiar patterns and technology to me, and this is a low-risk project with time constraints. If this were to be a production service, I would have used ansible to bake a custom AMI, as it is a more secure approach and would be easier to maintain. 

I would also use `aws-vault` to securely handle credential storage locally.

I have made a new VPC with a public subnet and allowed https traffic to the server (I assume this would be a webserver to serve web traffic). There is some associated risk here as the server is open to public traffic. If this instance were to be compromised, there are no associated IAM policies, so an attacker could install things on the instance but should not be able to assume a role to move out of the VPC into the wider account.

When building the scripts, I have opted for python as I'm familiar with it. I have imported libraries there which may pose some risk. Similarly, I am using the standard docker image, which poses a risk importing code from other sources.

