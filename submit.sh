#! /bin/bash
REMOTE=puppet.local
DST=root@$REMOTE:/etc/puppet
rsync -azvr modules   $DST
rsync -azvr manifests $DST
rsync -azvr templates $DST
