
#rsync
which rsync || apt install -y rsync

#make
which make || apt install -y make

# add the handy ll alias globally to the OS
cat > /bin/ll <<- EOF
#!/bin/bash
ls -alF "\$@"
EOF

chmod +x /bin/ll

# default runlevel 3
systemctl set-default multi-user.target 

# handy script to check if a service exists
cat > /usr/bin/service_exists <<- EOF
#!/bin/bash

set -eu

SERVICE=\$1

ls /lib/systemd/system/*.service | grep \$SERVICE > /dev/null || (
    echo "FALSE"
    exit 1
)
echo "TRUE"
exit 0
EOF

chmod +x /usr/bin/service_exists
