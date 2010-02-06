#!/bin/bash

# set default values for variables
RSRC=$1
LOCAL=$2
: ${RSRC:="/var/www"}
: ${LOCAL:="/disk2/backup/remote/hot"}

NOW=$1
: ${NOW:=$(date +"%m-%d-%Y")}

