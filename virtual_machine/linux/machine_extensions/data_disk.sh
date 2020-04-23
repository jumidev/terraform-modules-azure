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
mkdir $DATA_DISK_MOUNTPOINT || true

fstab="/dev/sdc $DATA_DISK_MOUNTPOINT xfs defaults 0 1"

# add mount line to fstab if it's not already there
cat /etc/fstab | grep "$fstab" || echo "$fstab" >> /etc/fstab

if mountpoint -q "$DATA_DISK_MOUNTPOINT" ; then
    echo "$DATA_DISK_MOUNTPOINT already mounted"
else
    mount $DATA_DISK_MOUNTPOINT 
fi

# auto grow filesystem on boot
echo "@reboot root /usr/sbin/xfs_growfs $DATA_DISK_MOUNTPOINT" > /etc/cron.d/xfs-growfs-data
chmod +x /etc/cron.d/xfs-growfs-data