# Initial AWS setup using Terraform

The purpose of this code is to take an AWS that has nothing setup and create the following resources:
- Create VPC with all necessary components such as EIP, subnets, security groups, etc
- Create three EC2 instances in each Availability Zone with Apache installed and the homepage saying "Hello world"
- ELB for the EC2 instances
- An Aurora MySQL instance with one reader and one writer

The code can be used to create resources as needed and provides a foundation to build off of based on your needs. It can also be used for a disaster recovery plan and be put into use in a backup region.
While a lot of variables are statically set that is not required and can be changes to suit your needs

There are future plans to be done to make this more modular.



##  ✨Running this locally: ✨
Installation Requirements:
- Git
- Terraform CLI
- An AWS account
- AWS AMI user terraform can use to make the necessary changes and updates

After cloning the repo run the following:
```sh
terraform init
```
Make any changes you'd like then run the following to execute a dry run
```sh
terraform plan
```

Finally apply the changes by running:
```sh
terraform apply
```

The Aurora instance will take the longest to finish. You should be able to check the resources being created in AWS.
