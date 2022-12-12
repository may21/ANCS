rmmod vhost_net
rmmod vhost
modprobe macvtap

cd modules
cd vhost
make clean; make && insmod vhost.ko
cd ..
cd vhost_net
make clean; make && insmod vhost_net.ko
cd ../..

lsmod | grep vhost
