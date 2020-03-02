
apt update -y 
apt install -y xfsprogs

mkfs.xfs /dev/sdc || true  #mkfs.xfs on an existing partition will fail, so catch case here
mkdir /data || true

fstab="/dev/sdc /data xfs defaults 0 1"

cat /etc/fstab | grep "$fstab" || echo "$fstab" >> /etc/fstab

mount /data