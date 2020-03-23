# docker

if mountpoint -q "/data" ; then
    echo "/data directory mounted, using for docker"
    mkdir /data/docker || true
    if [ ! -L /var/lib/docker ] ; then
        ln -s /data/docker /var/lib/docker
    fi
fi

docker --version || (
    cd /tmp

    curl -fsSL get.docker.com -o get-docker.sh 
    apt update -y && sh get-docker.sh

    # lock packages at current version, upgrading seems to break things
    # https://github.com/docker/for-linux/issues/709#issuecomment-506982588
    echo "docker-ce hold"     | dpkg --set-selections
    echo "docker-ce-cli hold" | dpkg --set-selections
    echo "containerd.io hold" | dpkg --set-selections
)

docker-compose --version || apt install -y docker-compose 

# See https://stackoverflow.com/questions/51222996/docker-login-fails-on-a-server-with-no-x11-installed
which gpg2 || (
    apt install -y gnupg2 pass 
    gpg2 --full-generate-key
)

cd /etc/cron.daily

cat > docker-prune <<- EOF
#!/bin/bash

docker container prune -f
docker volume prune -f

EOF
sudo  chmod +x docker-prune


cd - 