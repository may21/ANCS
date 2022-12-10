time=60
./interval.sh 0
./testReader 0
./wait_vm.sh

interval=0

for (( i=0 ; i<11; i++ ))
do
	if [ $i -eq 1 ]; then ./testReader 1
	fi
	echo $interval
	./interval.sh $interval
	interval=$(($interval + 500))
	sleep $time
done


./interval.sh 0
./testReader 0
