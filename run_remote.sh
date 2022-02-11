#!/bin/bash

set -ex

host=$1

ssh-copy-id $host
scp ~/.ssh/id_rsa* $host:.ssh
ssh $host "mkdir -p .local/share/online-judge-tools"
scp ~/.local/share/online-judge-tools/cookie.jar $host:.local/share/online-judge-tools/

scp remote_su.sh $host:
ssh -t $host "sudo ./remote_su.sh"
ssh $host "rm remote_su.sh"

scp remote.sh $host:
ssh $host "./remote.sh"
ssh $host "rm remote.sh"
