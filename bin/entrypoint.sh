#!/bin/sh
set -e

USER=root
if [ -n "$UID" ] && [ "$UID" -gt "100" ]; then
	USER=chocolatey
	GROUP=chocolatey

	if [ -z "$GID" ] || [ "$GID" -lt "101" ]; then
		GID=$UID		
	fi
	groupadd -g $GID $GROUP

	if [ "$UID" -lt "1000" ]; then
		useradd -r -N -g $GID -s /bin/sh -u $UID $USER > /dev/null 2>&1
	else
		useradd -M -N -e '' -g $GID -s /bin/sh -u $UID $USER > /dev/null 2>&1
	fi
fi

command="/usr/bin/choco $@"
su -c "$command" $USER
