
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
