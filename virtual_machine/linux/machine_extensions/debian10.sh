
# daily autoremove
cd /etc/cron.daily

cat > apt-autoremove <<- EOF
#!/bin/bash

apt autoremove -y

EOF
sudo  chmod +x apt-autoremove

cd -

# initial apt update
apt update -y