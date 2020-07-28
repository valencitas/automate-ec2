Engineering assignment - Automate EC2 and Docker

This project uses Terraform to initialise an Amazon linux 2 instance, install docker, and start an nginx server

Requires aws cli and terraform to run

How to use: 

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

