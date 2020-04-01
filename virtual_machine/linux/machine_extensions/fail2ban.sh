
mkdir -p /etc/fail2ban/jail.d || true 

fail2ban-client --version || (
    apt update -y
    apt install -y fail2ban

    systemctl enable fail2ban
)

cat > /etc/fail2ban/jail.d/defaults-debian.conf <<- EOF
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
blocktype = DROP

EOF

systemctl restart fail2ban