#!/bin/bash
# Install Apache Web Server
yum install -y httpd
cat << HEREDOC > /var/www/html/index.html
<html>
<head>
</head>
<body bgcolor="#5DBCD2">
<h1>Lab 3 - Blue/Green Deployment Use Case</h1>
<h2>This is our Blue Environment</h2>
</body>
</html>
HEREDOC
# Turn on web server
chkconfig httpd on
service httpd start
