#!/usr/bin/expect -f

set DOCKER_SERVICE_NAME [lindex $argv 0];
set DOCKER_SERVICE_USER [lindex $argv 1];
set INSTALL_DIR [lindex $argv 2];
set timeout 120

spawn ssh "$DOCKER_SERVICE_NAME" -l "$DOCKER_SERVICE_USER" -o StrictHostKeyChecking=no

expect "~#"
send "cd $INSTALL_DIR\n"
expect "script#"
send "sh install.sh\n"
expect "script#"

send "exit\n"