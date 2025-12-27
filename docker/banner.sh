#!/bin/bash
# docker/banner.sh

cat <<'EOF'
##########################################################
               _ __ __              __          _ __    __
  ____  ____  (_) // / ____ _      / /_  __  __(_) /___/ /
 / __ \/ __ \/ / // /_/ __ `/_____/ __ \/ / / / / / __  / 
/ /_/ / /_/ / /__  __/ /_/ /_____/ /_/ / /_/ / / / /_/ /  
\____/ .___/_/  /_/  \__,_/     /_.___/\__,_/_/_/\__,_/   
    /_/                                                   
by Timax (dancesWithMachines)
----------------------------------------------------------
This container runs in privileged mode!
All operations in this container are performed as root!
Hosts' /dev is mounted at /dev for loop devices to appear
----------------------------------------------------------
How to:
* Run `./prepare.sh` to apply env fixes
* Run `sudo ./build.sh` to start building the OPI4a image
##########################################################
EOF
