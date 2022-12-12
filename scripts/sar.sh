period=$(($1+1))

echo $period 

./wait_vm.sh
timeout $period sar -n DEV 1 | grep enp1s0f1

