# Automating-RDS-deployment-on-AWS-using-Terraform

Prerequisites
To follow this guide you need to have the following.

The latest Terraform binary is installed and configured in your system.

AWS CLI installed and configured with a Valid AWS account with permission to deploy RDS instances.

If you using an ec2 instance for provisioning, ensure you have a valid IAM role attached to the instance with RDS provisioning permissions.

Terraform RDS Workflow

The following image shows the RDS provisioning workflow using Terraform.

![terraform-aws-rds](https://github.com/Mamiololo01/Automating-RDS-deployment-on-AWS-using-Terraform/assets/67044030/4878023f-ec64-435f-97a9-0f56c613a56c)

Here is the workflow explanation.

Terraform code is developed, tested, and pushed to GitHub

Pull the terraform code to the workstation or server where you have the terraform and AWS CLI configured. Ideally, this would be an agent of a CI server like Jenkins

Execute the terraform RDS script by passing the variables required for RDS provisioning.

RDS gets provisioned and the password for RDS will be automatically created and stored in the AWS secrets manager. You can also use direct passwords instead of secret manager. However, it is not recommended to keep secrets in terraform code.

Once the RDS instance is provisioned the RDS endpoint, address, and secret manager secret arn get added to the terraform output. With the secret arn, applications can retrieve the DB username and password from the secrets manager.

If you use s3 as a remote state, the state file gets stored in s3 or else the state gets stored locally. It is not recommended to use the local state in real projects.

RDS terraform code is part of the terraform AWS repository. Clone it to your workstation to follow the guide


Provisioning RDS Using Terraform

Follow the steps given in this section to provision an RDS instance.

Note: For this demo, we will be using the MySQL RDS instance that is publicly accessible over port 3306. If you deploying it in project environemnt, modify the paramters to restrict access to only required IP ranges.

I assume terraform-aws folder as the root folder for the entire guide.

Step 1: Modify the RDS variables

Open the rds.tfvars file present in the vars/dev folder. Change these variables according to your requirements. The following are the variables present.

Primarily you need to change the variables marked in bold.

Replace subnet_ids with your subnet ids.

If you want to manage the RDS secret using AWS secrets manager, ensure you set set_secret_manager_password = true and set_db_password = false. The condition is handled inside the RDS module code.

Change the cidr_block to the CIDR range from which access is required to RDS.

Replace db_engine with the required DB engineer. RDS supports Aurora, MariaDB, PostgreSQL, Oracle, and Microsoft SQL Server.

Other variables are self-explanatory and change


Step 2: Initialize terraform

Once the variables are modified as per your requirements, go to the terminal and cd into environments/dev/rds directory.

cd environments/dev/rds

Inside the rds folder, you can find the main.tf file where it calls the rds module present in the modules directory as shown below.

Initialize Terraform using the following command

terraform init

This command initializes terraform. Make sure to run the init command inside the environments/dev/rds directory.

Step 3: To verify the configurations, run terraform plan with the variable file.

terraform plan  -var-file=../../../vars/dev/rds.tfvars

This command displays the plan which is going to execute.

Step 4: Apply the terraform configurations.

After verifying, apply the configurations using the command given below.

terraform apply -var-file=../../../vars/dev/rds.tfvars --auto-approve

This command applies the changes to start the provisioning using the variables given in the rds.tfvars file. The --auto-approve flag automatically approves the provisioning without manual confirmation.

Step 5: Validate provisioned RDS instances

Once the terraform is executed, you can validate the RDS instance by getting the RDS DNS endpoint, address, and secret arn using the following command.

terraform output

Also, use the AWS console and verify all the RDS instance details.

Try accessing the database using the username, password, and RDS endpoint as host. You can use MySQL client or MySQL workbench utility.

If you have enabled secret management using secrets manager, you can retrieve the secret from the AWS console.

Step 5: To clean up the setup, execute the following command.

terraform destroy -var-file=../../../vars/dev/rds.tfvars --auto-approve
