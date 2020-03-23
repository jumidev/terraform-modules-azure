# this script adds the handy ll alias globally to the OS

cd /bin

sudo cat > ll <<- EOF
#!/bin/bash
ls -alF "\$@"
EOF

sudo  chmod +x ll

cd -