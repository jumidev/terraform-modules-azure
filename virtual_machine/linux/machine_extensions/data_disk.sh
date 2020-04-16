# debian / ubuntu
if  which apt ; then
    apt update -y 
    apt install -y xfsprogs
fi

# centos
if which yum ; then
    yum install -y xfsdump xfsprogs
fi

mountpoint=/data

mkfs.xfs /dev/sdc || true  #mkfs.xfs on an existing partition will fail, so catch case here
mkdir $mountpoint || true

fstab="/dev/sdc $mountpoint xfs defaults 0 1"

# add mount line to fstab if it's not already there
cat /etc/fstab | grep "$fstab" || echo "$fstab" >> /etc/fstab

if mountpoint -q "$mountpoint" ; then
    echo "$mountpoint already mounted"
else
    mount $mountpoint 
fi

# auto grow filesystem on boot
echo "@reboot root /usr/sbin/xfs_growfs $mountpoint" > /etc/cron.d/xfs-growfs-data
chmod +x /etc/cron.d/xfs-growfs-data