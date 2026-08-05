#!/bin/sh
set -e

default_host="$DEFAULTHOST"
agent_addr="${AGENTADDR:-:59114}"
keyboxd_addr="${KEYBOXDADDR:-:59115}"

cp -r bin/. /usr/local/bin/

cat > /usr/local/bin/gpg-tcp2socket-startup \
<<EOF
#!/bin/sh
set -e

export GPG_TCP2SOCKET_DEFAULT_HOST='$default_host'
[ -n '$agent_addr' ] && gpg-tcp2socket-nohup agent '$agent_addr'
[ -n '$keyboxd_addr' ] && gpg-tcp2socket-nohup keyboxd '$keyboxd_addr'
EOF

chmod +x /usr/local/bin/gpg-tcp2socket-startup
