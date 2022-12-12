interval=$2
period=$1

echo $period 
echo $interval

iter=$(($period/$interval+1))

echo $iter
./wait_vm.sh
for (( i=0 ; i<iter; i++ ))
do
	#vnstat -i enp1s0f1 -tr $interval | grep kbit
	vnstat -i enp1s0f1 -tr $interval | grep tx &
	sleep 1 
	vnstat -i enp1s0f1 -tr $interval | grep tx &
	sleep 1
done

