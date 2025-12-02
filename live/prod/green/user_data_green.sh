#!/bin/bash
# nginx is vailable in Amazon Linux Extra topic nginx1
amazon-linux-extras install nginx1 -y
mv /usr/share/nginx/html/index.html
/usr/share/nginx/html/index.html.orig
cat << HEREDOC > /usr/share/nginx/html/index.html
<html>
<head>
</head>
<body bgcolor="#98FB98">
<h1>Lab 3 - Blue/Green Deployment Use Case</h1>
<h2>This is our Green Environment</h2>
</body>
</html>
2025-26, Departament d'Arquitectura de Computadors i Sistemes Operatius CAOS / UAB 4/5
HEREDOC
# Turn on web server
chkconfig nginx on
service nginx start