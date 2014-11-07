######
# curl -Lso /var/lib/boot2docker/bootlocal.sh j.mp/bootlocal && chmod +x /var/lib/boot2docker/bootlocal.sh
#######

#################
# set your custom network here:
#################
B2D_NETWORK=172.19.0.1

# stops all container and docker itself
docker stop -t 1 $(docker ps -q)
/etc/init.d/docker stop

#################
# install bridge-utils extension into tinycore
#################
[ -f /var/lib/boot2docker/bridge-utils.tcz ] || curl -Lo /var/lib/boot2docker/bridge-utils.tcz  ftp://ftp.nl.netbsd.org/vol/2/metalab/distributions/tinycorelinux/4.x/x86/tcz/bridge-utils.tcz
# tce-load should'nt bee run as sudo
su docker sh -c 'tce-load -i /var/lib/boot2docker/bridge-utils.tcz'

#################
# creates bridge0
#################
ifconfig bridge0 >/dev/null 2>&1  && (ifconfig bridge0 down && brctl delbr bridge0)
brctl addbr bridge0
ifconfig bridge0 $B2D_NETWORK netmask 255.255.255.0


#################
# disable dns for ssh
#################
# sudo sh -c 'sed  -i \"/UseDNS/ s/.*/UseDNS no/ \" /var/lib/boot2docker/ssh/sshd_config '

################
# install nsenter
###############
# ln -s /var/lib/boot2docker/nsenter /usr/local/bin/nsenter

cat > /var/lib/boot2docker/profile <<"EOF"
EXTRA_ARGS="-b=bridge0"
DOCKER_HOST="-H unix:// -H tcp://0.0.0.0:2375"
EOF

/etc/init.d/docker restart
