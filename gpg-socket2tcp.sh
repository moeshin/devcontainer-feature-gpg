#!/bin/sh

bind_ip=127.0.0.1
agent_socket_port=59114
keyboxd_socket_port=59115
agent_socket="$(gpgconf --list-dirs agent-extra-socket)" || exit 1
keyboxd_socket="$(gpgconf --list-dirs keyboxd-socket)" || exit 1

socat "TCP-LISTEN:$agent_socket_port,reuseaddr,fork,bind=$bind_ip" "UNIX-CONNECT:$agent_socket" &
socat "TCP-LISTEN:$keyboxd_socket_port,reuseaddr,fork,bind=$bind_ip" "UNIX-CONNECT:$keyboxd_socket" &

wait
