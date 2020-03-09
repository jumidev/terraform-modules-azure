
apt update -y 
apt install -y xfsprogs

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

