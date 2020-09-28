#!/bin/bash

export DISPLAY=${XVFB_DISPLAY:-:1}
export screen=${XVFB_SCREEN:-0}
export resolution=${XVFB_RESOLUTION:-1024x768x8}

source ./bootstrap.sh

CURRENT_UID=${uid:-9999}

echo "Current UID : $CURRENT_UID"
# Create user called "user" with selected UID
useradd --shell /bin/bash -u $CURRENT_UID -o -c "" -m user
# Set "HOME" ENV variable for user's home directory
export HOME=/home/user
export ENV WINEPREFIX /home/user/.wine
export ENV WINEARCH win32
 
# Execute process
exec gosu user "$@"

exit 0

