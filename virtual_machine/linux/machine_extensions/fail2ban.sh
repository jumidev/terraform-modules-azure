
mkdir -p /etc/fail2ban || true 

cd /etc/fail2ban 

cat > jail.local <<- EOF
[ssh]
enabled = true
port    = ssh
filter  = sshd
logpath  = /var/log/auth.log
maxretry = 5
mode = aggressive
blocktype = DROP

[sshlongterm]
port      = ssh
logpath  = /var/log/auth.log
banaction = iptables-multiport
maxretry  = 35
findtime  = 259200
bantime   = 608400
enabled   = true
filter    = sshd

EOF

fail2ban-client --version || (
    apt update -y
    apt install -y fail2ban

    systemctl enable fail2ban
)
systemctl restart fail2ban