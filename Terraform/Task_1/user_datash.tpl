#!/bin/bash
yum -y update
yum -y install httpd


cat <<EOF > /var/www/html/index.html
<html>
<h2>Build by Terraform <font color="red"> v0.12</font><h2><br>
Owner ${f_name
} ${l_name
} <br>

</html>
EOF

sudo service httpd start
chkconfig httpd on
