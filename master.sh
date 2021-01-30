yum install vim mc -y
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum install ansible -y
\cp -r /vagrant/files/master/.ssh /root/
chmod -R 0600 /root/.ssh/