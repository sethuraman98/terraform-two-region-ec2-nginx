#!/bin/bash

dnf update -y
dnf install -y nginx

systemctl enable nginx
systemctl start nginx

cat > /usr/share/nginx/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>Terraform Nginx Deployment</title>
</head>
<body>
    <h1>Nginx Successfully Deployed!</h1>
    <h2>Region: ${region}</h2>
    <p>Provisioned using Terraform and AWS EC2.</p>
</body>
</html>
EOF
