# Terraform Task 2 – Deploy Two EC2 Instances Across Two AWS Regions with Nginx

## Project Overview

This project demonstrates how to provision two Amazon EC2 instances in two different AWS regions using Terraform.

Nginx is automatically installed and configured on both instances using EC2 User Data.

The infrastructure is managed through Terraform, while AWS CLI is used for authentication and AWS resource verification.

## Architecture

| Component | Mumbai | Sydney |
|---|---|---|
| AWS Region | ap-south-1 | ap-southeast-2 |
| EC2 Instance | 1 | 1 |
| Instance Type | t3.micro | t3.micro |
| Operating System | Amazon Linux 2023 | Amazon Linux 2023 |
| Web Server | Nginx | Nginx |
| HTTP Port | 80 | 80 |

## Technologies Used

- AWS EC2
- AWS CLI
- Terraform
- Amazon Linux 2023
- Nginx
- Git and GitHub

## Project Structure

```text
terraform-two-region-ec2-nginx/
│
├── providers.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── user_data.sh
├── .gitignore
├── .terraform.lock.hcl
├── README.md
│
└── screenshots/
    ├── deployment-verification.png
    ├── ec2-mumbai.png
    ├── ec2-sydney.png
    ├── nginx-mumbai.png
    └── nginx-sydney.png
```

## Implementation Steps

### 1. AWS Authentication

Configured AWS CLI using an EC2 IAM role.

Verified authentication:

```bash
aws sts get-caller-identity
```

### 2. Terraform Providers

Configured two AWS providers:

- Default provider: Mumbai (ap-south-1)
- Aliased provider: Sydney (ap-southeast-2)

This allows Terraform to manage resources in both AWS regions from a single configuration.

### 3. EC2 Provisioning

Created two EC2 instances using Terraform.

Instance type: `t3.micro`

Operating system: Amazon Linux 2023.

### 4. Security Groups

Created separate security groups for both regions.

Inbound rule:

| Protocol | Port | Source |
|---|---|---|
| TCP | 80 | 0.0.0.0/0 |

### 5. Nginx Installation

Used `user_data.sh` to automate the installation and configuration of Nginx.

```bash
#!/bin/bash

dnf update -y
dnf install -y nginx

systemctl enable nginx
systemctl start nginx
```

A custom HTML page was configured to display the deployment region.

### 6. Terraform Deployment

Initialized Terraform:

```bash
terraform init
```

Formatted configuration:

```bash
terraform fmt
```

Validated configuration:

```bash
terraform validate
```

Generated execution plan:

```bash
terraform plan
```

Deployed infrastructure:

```bash
terraform apply
```

### 7. Deployment Verification

Verified both Nginx servers using curl.

Mumbai:

```bash
curl -I http://3.111.219.129
```

Sydney:

```bash
curl -I http://13.238.155.247
```

Both servers successfully returned:

```text
HTTP/1.1 200 OK
Server: nginx/1.30.6
Content-Type: text/html
```

## Deployment Outputs

| Region | Public IP | Nginx URL |
|---|---|---|
| Mumbai | 3.111.219.129 | http://3.111.219.129 |
| Sydney | 13.238.155.247 | http://13.238.155.247 |

## Terraform Output

```text
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
```

Resources create:

- 2 EC2 instances
- 2 Security Groups


## Screenshots

### Terraform Deployment
![Terraform Apply](Terraform%20Apply%20success.png)

### Mumbai EC2
![Mumbai EC2](Mumbai%20EC2%20instance%20in%20AWS%20console.png)

### Sydney EC2
![Sydney EC2](Sydney%20EC2%20instance%20in%20AWS%20console.png)

### Mumbai Nginx
![Mumbai Nginx](deployed%20Nginx%20servers_MUM.png)

### Sydney Nginx
![Sydney Nginx](deployed%20Nginx%20servers_SYD.png)


## Cleanup – Destroy AWS Resources

To avoid unnecessary AWS charges, destroy the infrastructure after completing the assessment and collecting screenshots.

```bash
terraform destroy
```

Confirm by entering:

```text
yes
```

Verify that the resources have been removed from both AWS regions.

## Learning Outcomes

- Understanding Terraform multi-region provider configuration.
- Provisioning AWS EC2 instances using Infrastructure as Code.
- Configuring AWS security groups.
- Automating software installation using EC2 User Data.
- Deploying Nginx web servers across multiple AWS regions.
- Verifying infrastructure using AWS CLI and Linux commands.
- Managing infrastructure lifecycle using Terraform.

## Author

Terraform Task 2 – Multi-Region EC2 and Nginx Deployment.


