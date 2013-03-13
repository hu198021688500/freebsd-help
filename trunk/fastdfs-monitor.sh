#!/bin/bash
#
#---------------------FastDFS monitor------------------------
#------------------------------------------------------------
# This scripts use to monitor the fastdfs's status. with standard output.
# you can run it in this way to let it loop 3 times with 5 seconds break:
#		./fdfs_monitor.sh 5 3
#
# or just run it to loop for 10 years with 3 seconds break.
#		./fdfs_monitor.sh
#
#
#			    any bugs and suggestions, you can contact:
#								 Youn
#								 xy19900828@gmail.com
#-------------------------------------------------------------
#
tmp_file="$$"
fastdfs_file=/tmp/fastdfs.$tmp_file

#this is a function used frequently. to print lines.
print_lines() {
	for (( s=1; s< "$cols"; s++ ))
		do
			echo -n "-"
		done
	echo "-"
}

#define whether to loop forever or times given.
if [ "$1" == "" ];then
	looptime=315360000
	breaktime=3
else 
	breaktime=$1
	looptime=$2
fi

#this is a huge loop, until the end of the script.
for (( times=1; times<=$looptime; times++ ))
do

#get infomations from tracker. use fdfs_monitor /etc/fdfs/client.conf
fdfs_monitor /etc/fdfs/client.conf > $fastdfs_file 2>/dev/null

clear
#get the cols of current terminal. to suit any size of the windows.
cols=`tput cols`
halfcols=`echo "$cols/2 - 7" | bc`

#print informations on the middle of windows.
tput cup 0 $halfcols
echo "FastDFS Monitor"
echo
print_lines

echo

#print tracker server's information.
printf "%-10s : %-10s \n" "tracker server" "`grep "tracker server" $fastdfs_file | cut -d" " -f4`"

#get the group_number and print it.
group_number=`grep "group count" $fastdfs_file | cut -d" " -f3`
printf "%-10s : %-10s \n" "group count" "`echo -ne "\e[1;32m$group_number\e[0m"`"
echo
echo

#loop for group
for (( i=1; i<=$group_number; i++ ))
do
	
	#use blue to display.
	echo -e "\e[1;34m Group $i \e[0m"
	print_lines;
	
	#get the storage_number in current group.
	storage_number=`grep -A 8 "Group $i" $fastdfs_file|grep "storage server count"|cut -d" " -f5|sed -e 's/" "//g'`
	
	printf "%-15s | %-15s | %-10s | %-15s | %-15s | %-15s\n" "Name" "Address" "Port" "Disk Total" "Disk Free" "Status"
	grep -A `echo "14 + $storage_number * 59"|bc` "Group $i" $fastdfs_file > /tmp/fastdfs.$tmp_file.$i
	
	#loop for every storage
	for ((a=1; a<=$storage_number; a++))
	do
		storage_name="Storage $a"
		storage_ip=`grep -A 13 "Storage $a" /tmp/fastdfs.$tmp_file.$i | grep "ip_addr"| cut -d " " -f3`
		storage_port=`grep -A 13 "Storage $a" /tmp/fastdfs.$tmp_file.$i | grep "storage_port"| cut -d" " -f3`
        	storage_status=`grep -A 13 "Storage $a" /tmp/fastdfs.$tmp_file.$i |grep "ip_addr"| cut -d " " -f5`
        	storage_total=`grep -A 13 "Storage $a" /tmp/fastdfs.$tmp_file.$i |grep "total storage"| cut -d " " -f4-`
        	storage_free=`grep -A 13 "Storage $a" /tmp/fastdfs.$tmp_file.$i |grep "free storage"| cut -d " " -f4-`
		
		#use green to display ACTIVE, and red for others.
		if [ $storage_status == "ACTIVE" ]; then
			printf "%-15s | %-15s | %-10s | %-15s | %-15s | %-15s\n" "$storage_name" "$storage_ip" "$storage_port" "$storage_total" "$storage_free" "`echo -ne "\e[1;32m$storage_status \e[0m"`"
		else
			printf "%-15s | %-15s | %-10s | %-15s | %-15s | %-15s\n" "$storage_name" "$storage_ip" "$storage_port" "$storage_total" "$storage_free" "`echo -ne "\e[1;31m$storage_status \e[0m"`"
		fi
	done
	print_lines
done

#delete tmp file
rm $fastdfs_file
rm /tmp/fastdfs.$tmp_file.*

#the breaktime is here
sleep $breaktime
done

