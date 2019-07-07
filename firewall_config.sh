# set firewall defaults
ufw default deny incoming
ufw default allow outgoing

# allow ssh
ufw allow ssh
ufw allow 2222/tcp

# allow web connections
ufw allow www

# allow ntp
ufw allow 123/tcp

# turn on firewall
ufw --force enable
