# thanks https://linuxize.com/post/how-to-add-swap-space-on-debian-9/

if [ ! -f $SWAP_FILE ] ; then
    fallocate -l $SWAP_SIZE $SWAP_FILE
    chmod 600 $SWAP_FILE
    mkswap $SWAP_FILE
fi

swapon --show | grep $SWAP_FILE || swapon $SWAP_FILE

fstab="$SWAP_FILE swap swap defaults 0 0"

# add mount line to fstab if it's not already there
cat /etc/fstab | grep "$fstab" || echo "$fstab" >> /etc/fstab