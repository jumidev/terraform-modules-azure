# debian / ubuntu
if  which apt ; then
    apt update -y 
    apt install -y xfsprogs
fi

# centos
if which yum ; then
    yum install -y xfsdump xfsprogs
fi


mkfs.xfs /dev/sdc || true  #mkfs.xfs on an existing partition will fail, so catch case here
mkdir /data || true

fstab="/dev/sdc /data xfs defaults 0 1"

# add mount line to fstab if it's not already there
cat /etc/fstab | grep "$fstab" || echo "$fstab" >> /etc/fstab

if mountpoint -q "/data" ; then
    echo "/data already mounted"
else
    mount /data 
fi

