# docker

# if /data is set up, use that for docker stuff
if [ -d /data ] ; then
    mkdir /data/docker || true
    ln -s /data/docker /var/lib/docker
fi


cd /tmp

curl -fsSL get.docker.com -o get-docker.sh 
apt update -y && sh get-docker.sh

# lock packages at current version, upgrading seems to break things
# https://github.com/docker/for-linux/issues/709#issuecomment-506982588
echo "docker-ce hold"     | dpkg --set-selections
echo "docker-ce-cli hold" | dpkg --set-selections
echo "containerd.io hold" | dpkg --set-selections

apt install -y docker-compose 

cd /etc/cron.daily

cat > docker-prune <<- EOF
#!/bin/bash

docker container prune -f
docker volume prune -f

EOF
sudo  chmod +x docker-prune


cd - 