#!/bin/bash
yum -y update
yum -y install httpd

myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
cat <<EOF > /var/www/html/index.html
<html>
<h2>Build by Terraform with new text</h2>
<br>
Owher: ${f_name} ${l_name}<br><br>

%{ for name in names ~}
    Hello to ${name} from ${f_name} ${l_name}<br>
%{ endfor ~}

</html>
EOF

sudo service httpd start
chkconfig httpd on