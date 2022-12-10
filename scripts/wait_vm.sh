
echo 0 > nfs/sign.txt
echo "Waiting...$(date +%m-%d-%H-%M-%S)"
while true; do
	#var="$(cat sign.txt)"
	if [ $(cat nfs/sign.txt) -eq 1 ]; then
	#if [ $var -eq 1 ]; then
		echo "JOB START!!"
		#echo 0 > sign.txt
		break;
	fi	
	sleep 0.01
done

