#!/bin/bash

#居中显示
function a57-show-line-center(){
	length=${#1}	#获取字符串长度
	count=$[($shellwidth-$length)/2]	#空格数
	for((i=1;i<=count;i++)); do
		printf " "
	done
	printf "$1"
}

#左对齐
function a57-show-line-left(){
	count=$[$shellwidth/4]	#空格数
	for((i=1;i<=count;i++)); do
		printf " "
	done
	printf "$1"
}

#欢迎界面
function a57-welcome(){
	tput clear
	fname="books.db"
	if [ ! -e "$fname" ]; then
		touch "$fname"	#如果文件books.db不存在，则创建该文件
		# echo "a40-00001%computer science%tony%#computer%in%%" >> "$fname"
		# echo "a40-00002%network science%bob%#network%in%%" >> "$fname"
		# echo "a40-00004%php%mary%#php%in%%" >> "$fname"
		echo "a57-00001%Pyhton Flask%a57-jane%#Python%in%%" >> "$fname"
		echo "a57-00002%Network Crawler%a57-jack%#Python%in%%" >> "$fname"
		echo "a57-00003%PHP%a57-lucy%PHP%in%%" >> "$fname"
		echo "a57-00004%C programming language%a57-mike%#C%in%%" >> "$fname"
		echo "a57-00005%Network Engineering and Administration%a57-tony%#Network%in%%" >> "$fname"
		echo "a57-00006%Data Structure%a57-myuser%#Network%in%%" >> "$fname"
	fi
	shellwidth=$(stty size | awk '{print $2}')	#获取终端宽度
	echo -n -e "\n\n\n\n\n\033[33m"
	a57-show-line-center "Personal Library Management System"
	echo -n -e "\n\n\033[0m"
	a57-show-line-center "Version 0.1"
	echo -n -e "\n\n\033[32m"
	a57-show-line-center "a57@jxnu.edu.cn"
	echo -n -e "\n\n\033[0m"
	time=$(date +"%Y-%m-%d")
	a57-show-line-center "$time"
	echo -n -e "\n\n\n\n\n\n\033[36m"
	a57-show-line-center "Please ENTER to continue..."
	read en
	a57-main-menu
}
function a57-main-menu(){	#主菜单
	printf "\033c"
	shellwidth=$(stty size | awk '{print $2}')
	echo -n -e "\n\n\033[33m"
	a57-show-line-center "Main Menu"
	echo -n -e "\n\n\033[0m"
	a57-show-line-left "1: Show books"
	printf "\n\n"
	a57-show-line-left "2: Find books"
	printf "\n\n"
	a57-show-line-left "3: Add books"
	printf "\n\n"
	a57-show-line-left "4: Edit infomation of books"
	printf "\n\n"
	a57-show-line-left "5: Check out books"
	printf "\n\n"
	a57-show-line-left "6: Check in books"
	printf "\n\n"
	a57-show-line-left "7: Delete books"
	printf "\n\n"
	a57-show-line-left "q: Exit"
	echo -n -e "\n\n\033[36m"
	a57-show-line-center "Please enter your choice[1-7 or q]: "
	read cho
	case "$cho" in
		1)
		a57-show-books-menu ;;
		2)
		a57-find-books ;;
		3)
		a57-add-books ;;
		4)
		a57-edit-books ;;
		5)
		a57-check-out-books ;;
		6)
		a57-check-in-books ;;
		7)
		a57-delete-books ;;
		q)
		printf "\033c"
		exit ;;	#输入"q"，退出
		*)
		printf "\n"
		a57-show-line-center "Error, please enter again..."
		read en
		a57-main-menu ;;
	esac
}
function a57-show-books-menu(){	#Show books菜单
	printf "\033c"
	shellwidth=$(stty size | awk '{print $2}')
	echo -n -e "\n\n\n\n\n\033[33m"
	a57-show-line-center "Show books"
	echo -n -e "\n\n\033[0m"
	a57-show-line-left "1: Sort by ID"
	printf "\n\n"
	a57-show-line-left "2: Sort by Title"
	printf "\n\n"
	a57-show-line-left "3: Sort by Author"
	printf "\n\n"
	a57-show-line-left "q: Return Main Menu"
	echo -n -e "\n\n\n\n\n\033[36m"
	a57-show-line-center "Enter your choice[1-3 or q]: "
	read cho
	case "$cho" in
		1)
		a57-show-books 1 ;;	#按第1个字段即ID排序
		2)
		a57-show-books 2 ;;	#按第2个字段即Title排序
		3)
		a57-show-books 3 ;;	#按第3个字段即Author排序
		q)
		a57-main-menu ;;
		*)
		printf "\n"
		a57-show-line-center "Error, please enter again..."
		read en
		a57-show-books-menu ;;
	esac
}
function a57-show-books(){	#显示图书信息
	shellwidth=$(stty size | awk '{print $2}')
	count=$[$shellwidth/8]	#空格数
	echo -n -e "\033[0m"
	sort -t "%" -k "$1" "$fname" | awk -F "%" -v count="$count" '{
		for(i=1;i<=count;i++){
			printf(" ")
		}
		print "      ID: "$1
		for(i=1;i<=count;i++){
			printf(" ")
		}
		print "   Title: "$2
		for(i=1;i<=count;i++){
			printf(" ")
		}
		print "  Author: "$3
		for(i=1;i<=count;i++){
			printf(" ")
		}
		print "    Tags: "$4
		for(i=1;i<=count;i++){
			printf(" ")
		}
		print "  Status: "$5
		if($6!=""){
			for(i=1;i<=count;i++){
				printf(" ")
			}
			print "Borrower: "$6
		}
		if($7!=""){
			for(i=1;i<=count;i++){
				printf(" ")
			}
			print " outTime: "$7
		}
		printf "\n"
	}' | less
	a57-show-books-menu	#返回Show books菜单
}
#!/bin/bash
function a57-find-books(){	#Find books界面
	printf "\033c"
	shellwidth=$(stty size | awk '{print $2}')
	echo -n -e "\n\n\n\n\033[33m"
	a57-show-line-center "Find books"
	echo -n -e "\n\n\033[35m"
	a57-show-line-left "      ID: "
	printf "\n\n"
	a57-show-line-left "   Title: "
	printf "\n\n"
	a57-show-line-left "  Author: "
	printf "\n\n"
	a57-show-line-left "    Tags: "
	printf "\n\n"
	a57-show-line-left "  in/out: "
	printf "\n\n"
	a57-show-line-left "Borrower: "
	x=$[$shellwidth/4+11]	#用于光标定位的横坐标
	echo -n -e "\033[0m\033[7;"$x"H"
	read ID
	echo -n -e "\033[9;"$x"H"
	read Title
	echo -n -e "\033[11;"$x"H"
	read Author
	echo -n -e "\033[13;"$x"H"
	read Tags
	echo -n -e "\033[15;"$x"H"
	read Status
	echo -n -e "\033[17;"$x"H"
	read Borrower
	echo -n -e "\n\n\033[36m"
	a57-show-line-center "Are you sure? [y(es)/n(o)/c(ancel)]: "
	read s
	if [ -z "$s" ]; then
		s="y"	#默认"y"
	fi
	case "$s" in
		y|yes)
		a57-find-books-db "$ID" "$Title" "$Author" "$Tags" "$Status" "$Borrower" ;;
		n|no)
		a57-find-books ;;
		c|cancel)
		a57-main-menu ;;
		*)
		printf "\n"
		a57-show-line-center "Error, please enter again..."
		read en
		a57-find-books ;;
	esac
}
function a57-find-books-db(){	#查找图书信息
	shellwidth=$(stty size | awk '{print $2}')
	count=$[$shellwidth/8]	#空格数
	echo -n -e "\033[0m"
	#进行模糊查找
	awk -F "%" -v count="$count" '$1~/'"$1"'/&&$2~/'"$2"'/&&$3~/'"$3"'/&&$4~/'"$4"'/&&$5~/'"$5"'/&&$6~/'"$6"'/{
		for(i=1;i<=count;i++){
			printf(" ")
		}
		print "      ID: "$1
		for(i=1;i<=count;i++){
			printf(" ")
		}
		print "   Title: "$2
		for(i=1;i<=count;i++){
			printf(" ")
		}
		print "  Author: "$3
		for(i=1;i<=count;i++){
			printf(" ")
		}
		print "    Tags: "$4
		for(i=1;i<=count;i++){
			printf(" ")
		}
		print "  Status: "$5
		if($6!=""){
			for(i=1;i<=count;i++){
				printf(" ")
			}
			print "Borrower: "$6
		}
		if($7!=""){
			for(i=1;i<=count;i++){
				printf(" ")
			}
			print " outTime: "$7
		}
		printf "\n"
	}' "$fname" | less
	echo -e "\033[36m"
	a57-show-line-center "Any book to find? [y/n]: "
	read s
	if [ -z "$s" ]; then
		s="y"	#默认"y"
	fi
	case "$s" in
		y)
		a57-find-books ;;
		*)
		a57-main-menu ;;
	esac
}
#!/bin/bash
function a57-add-books(){	#Add books界面
	printf "\033c"
	shellwidth=$(stty size | awk '{print $2}')
	echo -n -e "\n\n\n\n\n\033[33m"
	a57-show-line-center "Add books"
	echo -n -e "\n\n\033[35m"
	a57-show-line-left "      ID: "
	printf "\n\n"
	a57-show-line-left "   Title: "
	printf "\n\n"
	a57-show-line-left "  Author: "
	printf "\n\n"
	a57-show-line-left "    Tags: "
	x=$[$shellwidth/4+11]	#用于光标定位的横坐标
	line=$(awk 'END{print NR}' "$fname")
	for((i=1;i<=line+1;i++)); do	#查找可用ID
		length=${#i}
		ID="$i"
		for((j=1;j<=5-length;j++)); do
			ID="0$ID"
		done
		ID="a57-$ID"
		if [ $(awk -F "%" -v ID="$ID" '$1==ID{print $1}' "$fname") ]; then
			continue 1	#停止本次循环，开始下一次循环
		else
			break 1	#结束循环
		fi
	done
	echo -e "\033[0m\033[8;"$x"H""$ID"
	echo -n -e "\033[10;"$x"H"
	read Title
	echo -n -e "\033[12;"$x"H"
	read Author
	echo -n -e "\033[14;"$x"H"
	read Tags
	echo -n -e "\n\n\n\n\033[36m"
	a57-show-line-center "Are you sure? [y(es)/n(o)/c(ancel)]: "
	read s
	if [ -z "$s" ]; then
		s="y"	#默认"y"
	fi
	case "$s" in
		y|yes)
		a57-judgment-add-legality "$ID" "$Title" "$Author" "$Tags" ;;
		n|no)
		a57-add-books ;;
		c|cancel)
		a57-main-menu ;;
		*)
		printf "\n"
		a57-show-line-center "Error, please enter again..."
		read en
		a57-add-books ;;
	esac
}
function a57-judgment-add-legality(){	#添加图书信息
	if [ -z "$2" ]; then	#Title为空
		printf "\n"
		a57-show-line-center "The Title cannot be empty, please enter again..."
		read en
		a57-add-books
	elif [ -z "$3" ]; then	#Author为空
		printf "\n"
		a57-show-line-center "The Author cannot be empty, please enter again..."
		read en
		a57-add-books
	elif [ -z "$4" ]; then	#Tags为空
		printf "\n"
		a57-show-line-center "The Tags cannot be empty, please enter again..."
		read en
		a57-add-books
	fi
	echo "$1%$2%$3%$4%in%%" >> "$fname"	#追加写入图书信息
	sort -t "%" -k 1 "$fname" -o "$fname"	#将图书信息按ID排序
	printf "\n"
	a57-show-line-center "Success, any book to add? [y/n]: "
	read s
	if [ -z "$s" ]; then
		s="y"	#默认"y"
	fi
	case "$s" in
		y)
		a57-add-books ;;
		*)
		a57-main-menu ;;
	esac
}
#!/bin/bash
function a57-edit-books(){	#Edit infomation of books界面
	printf "\033c"
	shellwidth=$(stty size | awk '{print $2}')
	echo -n -e "\n\n\n\033[33m"
	a57-show-line-center "Edit infomation of books"
	echo -n -e "\n\n\033[35m"
	a57-show-line-left "      ID: "
	printf "\n\n"
	a57-show-line-left "   Title: "
	printf "\n\n"
	a57-show-line-left "  Author: "
	printf "\n\n"
	a57-show-line-left "    Tags: "
	printf "\n\n"
	a57-show-line-left "  in/out: "
	printf "\n\n"
	a57-show-line-left "Borrower: "
	printf "\n\n"
	a57-show-line-left " outTime: "
	x=$[$shellwidth/4+11]	#用于光标定位的横坐标
	echo -n -e "\033[0m\033[6;"$x"H"
	read ID
	length=${#ID}
	if((length==0)); then	#未输入ID
		echo -n -e "\033[36m\033[20;0H"
		a57-show-line-center "Are you sure? [y(es)/n(o)/c(ancel)]: "
		read s
		if [ -z "$s" ]; then
			s="y"	#默认"y"
		fi
		case "$s" in
			n|no)
			a57-edit-books ;;
			c|cancel)
			a57-main-menu ;;
			*)
			printf "\n"
			a57-show-line-center "Error, please enter again..."
			read en
			a57-edit-books ;;
		esac
	else
		for((i=1;i<=5-length;i++)); do
			ID="0$ID"
		done
		ID="a57-$ID"
		if [ $(awk -F "%" -v ID="$ID" '$1==ID{print $1}' "$fname") ]; then	#图书存在
			echo -n -e "\033[0m\033[6;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{print $1}' "$fname"
			echo -n -e "\033[0m\033[8;"$x"H"
			Title=$(awk -F "%" -v ID="$ID" '$1==ID{printf $2}' "$fname")
			echo -n -e "$Title\033[34m ==> \033[0m"
			echo -n -e "\033[0m\033[10;"$x"H"
			Author=$(awk -F "%" -v ID="$ID" '$1==ID{printf $3}' "$fname")
			echo -n -e "$Author\033[34m ==> \033[0m"
			echo -n -e "\033[0m\033[12;"$x"H"
			Tags=$(awk -F "%" -v ID="$ID" '$1==ID{printf $4}' "$fname")
			echo -n -e "$Tags\033[34m ==> \033[0m"
			echo -n -e "\033[0m\033[14;"$x"H"
			Status=$(awk -F "%" -v ID="$ID" '$1==ID{printf $5}' "$fname")
			echo -n -e "$Status\033[34m ==> \033[0m"
			echo -n -e "\033[0m\033[16;"$x"H"
			Borrower=$(awk -F "%" -v ID="$ID" '$1==ID{printf $6}' "$fname")
			echo -n -e "$Borrower\033[34m ==> \033[0m"
			echo -n -e "\033[0m\033[18;"$x"H"
			outTime=$(awk -F "%" -v ID="$ID" '$1==ID{printf $7}' "$fname")
			echo -n -e "$outTime\033[34m ==> \033[0m"
			echo -n -e "\033[8;"$[$x+${#Title}+5]"H"
			read Title
			echo -n -e "\033[10;"$[$x+${#Author}+5]"H"
			read Author
			echo -n -e "\033[12;"$[$x+${#Tags}+5]"H"
			read Tags
			echo -n -e "\033[14;"$[$x+${#Status}+5]"H"
			read Status
			echo -n -e "\033[16;"$[$x+${#Borrower}+5]"H"
			read Borrower
			echo -n -e "\033[18;"$[$x+${#outTime}+5]"H"
			read outTime
			echo -n -e "\n\033[36m"
			a57-show-line-center "Are you sure? [y(es)/n(o)/c(ancel)]: "
			read s
			if [ -z "$s" ]; then
				s="y"	#默认"y"
			fi
			case "$s" in
				y|yes)
				a57-edit-books-db "$ID" "$Title" "$Author" "$Tags" "$Status" "$Borrower" "$outTime" ;;
				n|no)
				a57-edit-books ;;
				c|cancel)
				a57-main-menu ;;
				*)
				printf "\n"
				a57-show-line-center "Error, please enter again..."
				read en
				a57-edit-books ;;
			esac
		else	#图书不存在
			echo -n -e "\033[36m\033[21;0H"
			a57-show-line-center "This book does not exist, please enter again..."
			read en
			a57-edit-books
		fi
	fi
}
function a57-edit-books-db(){	#修改图书信息
	# $1:ID, $2:Title, $3:Author, $4:Tags; $5:Status, $6:Borrower, $7:outTime
	if [ $(awk -F "%" -v ID="$1" '$1==ID{print $5}' "$fname") = "in" ] && [ -z "$5" ]; then
		#Status为"in"且不更改
		if [ -n "$6" ]; then
			printf "\n"
			a57-show-line-center "The Borrower must be empty, please enter again..."
			read en
			a57-edit-books
		elif [ -n "$7" ]; then
			printf "\n"
			a57-show-line-center "The outTime must be empty, please enter again..."
			read en
			a57-edit-books
		fi
		Borrower=""
		outTime=""
	elif [ $(awk -F "%" -v ID="$1" '$1==ID{print $5}' "$fname") = "in" ] && [ "$5" = "out" ]; then
		#Status从"in"更改为"out"
		if [ -z "$6" ]; then
			printf "\n"
			a57-show-line-center "The Borrower cannot be empty, please enter again..."
			read en
			a57-edit-books
		fi
		Borrower="$6"
		if [ -z "$7" ]; then
			outTime=$(date +"%Y-%m-%d")	#系统时间
		else
			outTime="$7"
		fi
	elif [ $(awk -F "%" -v ID="$1" '$1==ID{print $5}' "$fname") = "out" ] && [ -z "$5" ]; then
		#Status为"out"且不更改
		if [ -z $(awk -F "%" -v ID="$1" '$1==ID{print $6}' "$fname") ] && [ -z "$6" ]; then
			printf "\n"
			a57-show-line-center "The Borrower cannot be empty, please enter again..."
			read en
			a57-edit-books
		fi
		Borrower="$6"
		if [ -z $(awk -F "%" -v ID="$1" '$1==ID{print $7}' "$fname") ] && [ -z "$7" ]; then
			printf "\n"
			a57-show-line-center "The outTime cannot be empty, please enter again..."
			read en
			a57-edit-books
		fi
		outTime="$7"
	elif [ $(awk -F "%" -v ID="$1" '$1==ID{print $5}' "$fname") = "out" ] && [ "$5" = "in" ]; then
		#Status从"out"更改为"in"
		printf "\n"
		a57-show-line-center "Borrower and outTime will be empty, save the changes? [y/n]: "
		read s
		if [ -z "$s" ]; then
			s="y"	#默认"y"
		fi
		case "$s" in
			y)
			Borrower=""
			outTime="" ;;
			*)
			a57-edit-books ;;
		esac
	fi
	if [ -n "$2" ]; then
		#更改Title
		old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
		new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($2,"'"$2"'",$2);print $0}' "$fname")
		sed -i 's/'"$old"'/'"$new"'/' "$fname"
	fi
	if [ -n "$3" ]; then
		#更改Author
		old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
		new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($3,"'"$3"'",$3);print $0}' "$fname")
		sed -i 's/'"$old"'/'"$new"'/' "$fname"
	fi
	if [ -n "$4" ]; then
		#更改Tags
		old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
		new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($4,"'"$4"'",$4);print $0}' "$fname")
		sed -i 's/'"$old"'/'"$new"'/' "$fname"
	fi
	if [ -n "$5" ]; then
		#更改Status
		old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
		new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($5,"'"$5"'",$5);print $0}' "$fname")
		sed -i 's/'"$old"'/'"$new"'/' "$fname"
	fi
	#更改Borrower
	old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
	new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($6,"'"$Borrower"'",$6);print $0}' "$fname")
	sed -i 's/'"$old"'/'"$new"'/' "$fname"
	#更改outTime
	old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
	new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($7,"'"$outTime"'",$7);print $0}' "$fname")
	sed -i 's/'"$old"'/'"$new"'/' "$fname"
	echo -n -e "\033[22;0H"
	for((i=1;i<=shellwidth;i++)); do
		printf " "
	done
	echo -n -e "\033[22;0H"
	a57-show-line-center "Success, any more books to edit? [y/n]: "
	read s
	if [ -z "$s" ]; then
		s="y"	#默认"y"
	fi
	case "$s" in
		y)
		a57-edit-books ;;
		*)
		a57-main-menu ;;
	esac
}
#!/bin/bash
function a57-check-out-books(){	#Check out books界面
	printf "\033c"
	shellwidth=$(stty size | awk '{print $2}')
	echo -n -e "\n\n\n\033[33m"
	a57-show-line-center "Check out books"
	echo -n -e "\n\n\033[35m"
	a57-show-line-left "      ID: "
	printf "\n\n"
	a57-show-line-left "   Title: "
	printf "\n\n"
	a57-show-line-left "  Author: "
	printf "\n\n"
	a57-show-line-left "    Tags: "
	printf "\n\n"
	a57-show-line-left "  in/out: "
	printf "\n\n"
	a57-show-line-left "Borrower: "
	printf "\n\n"
	a57-show-line-left " outTime: "
	x=$[$shellwidth/4+11]	#用于光标定位的横坐标
	echo -n -e "\033[0m\033[6;"$x"H"
	read ID
	length=${#ID}
	if((length==0)); then	#未输入ID
		echo -n -e "\033[36m\033[20;0H"
		a57-show-line-center "Are you sure? [y(es)/n(o)/c(ancel)]: "
		read s
		if [ -z "$s" ]; then
			s="y"	#默认"y"
		fi
		case "$s" in
			n|no)
			a57-check-out-books ;;
			c|cancel)
			a57-main-menu ;;
			*)
			printf "\n"
			a57-show-line-center "Error, please enter again..."
			read en
			a57-check-out-books ;;
		esac
	else
		for((i=1;i<=5-length;i++)); do
			ID="0$ID"
		done
		ID="a57-$ID"
		if [ $(awk -F "%" -v ID="$ID" '$1==ID{print $1}' "$fname") ]; then	#图书存在
			if [ $(awk -F "%" -v ID="$ID" '$1==ID{print $5}' "$fname") = "out" ]; then
				#图书Status为"out"
				echo -n -e "\033[36m\033[21;0H"
				a57-show-line-center "This book's status is \"out\", please enter again..."
				read en
				a57-check-out-books
			fi
			echo -n -e "\033[0m\033[6;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{print $1}' "$fname"
			echo -n -e "\033[8;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $2}' "$fname"
			echo -n -e "\033[10;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $3}' "$fname"
			echo -n -e "\033[12;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $4}' "$fname"
			echo -n -e "\033[14;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $5}' "$fname"
			echo -n -e "\033[16;"$x"H"
			read Borrower
			echo -n -e "\033[36m\033[20;0H"
			a57-show-line-center "Are you sure? [y(es)/n(o)/c(ancel)]: "
			read s
			if [ -z "$s" ]; then
				s="y"	#默认"y"
			fi
			case "$s" in
				y|yes)
				a57-check-out-books-db "$ID" "$Borrower" ;;
				n|no)
				a57-check-out-books ;;
				c|cancel)
				a57-main-menu ;;
				*)
				printf "\n"
				a57-show-line-center "Error, please enter again..."
				read en
				a57-check-out-books ;;
			esac
		else	#图书不存在
			echo -n -e "\033[36m\033[21;0H"
			a57-show-line-center "This book does not exist, please enter again..."
			read en
			a57-check-out-books
		fi
	fi
}
function a57-check-out-books-db(){	#修改借出图书的信息
	if [ -z "$2" ]; then	#Borrower为空
		printf "\n"
		a57-show-line-center "The Borrower cannot be empty, please enter again..."
		read en
		a57-check-out-books
	fi
	outTime=$(date +"%Y-%m-%d")	#系统时间
	old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
	new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($5,"out",$5);print $0}' "$fname")
	sed -i 's/'"$old"'/'"$new"'/' "$fname"
	old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
	new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($6,"'"$2"'",$6);print $0}' "$fname")
	sed -i 's/'"$old"'/'"$new"'/' "$fname"
	old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
	new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($7,"'"$outTime"'",$7);print $0}' "$fname")
	sed -i 's/'"$old"'/'"$new"'/' "$fname"
	echo -n -e "\033[34m\033[14;"$x"Hout"
	echo -n -e "\033[18;"$x"H"
	awk -F "%" -v ID="$ID" '$1==ID{printf $7}' "$fname"
	echo -n -e "\033[36m\033[22;0H"
	a57-show-line-center "Success, any more books to check out? [y/n]: "
	read s
	if [ -z "$s" ]; then
		s="y"	#默认"y"
	fi
	case "$s" in
		y)
		a57-check-out-books ;;
		*)
		a57-main-menu ;;
	esac
}
#!/bin/bash
function a57-check-in-books(){	#Check out books界面
	printf "\033c"
	shellwidth=$(stty size | awk '{print $2}')
	echo -n -e "\n\n\n\033[33m"
	a57-show-line-center "Check in books"
	echo -n -e "\n\n\033[35m"
	a57-show-line-left "      ID: "
	printf "\n\n"
	a57-show-line-left "   Title: "
	printf "\n\n"
	a57-show-line-left "  Author: "
	printf "\n\n"
	a57-show-line-left "    Tags: "
	printf "\n\n"
	a57-show-line-left "  in/out: "
	printf "\n\n"
	a57-show-line-left "Borrower: "
	printf "\n\n"
	a57-show-line-left " outTime: "
	x=$[$shellwidth/4+11]	#用于光标定位的横坐标
	echo -n -e "\033[0m\033[6;"$x"H"
	read ID
	length=${#ID}
	if((length==0)); then	#未输入ID
		echo -n -e "\033[36m\033[20;0H"
		a57-show-line-center "Are you sure? [y(es)/n(o)/c(ancel)]: "
		read s
		if [ -z "$s" ]; then
			s="y"	#默认"y"
		fi
		case "$s" in
			n|no)
			a57-check-in-books ;;
			c|cancel)
			a57-main-menu ;;
			*)
			printf "\n"
			a57-show-line-center "Error, please enter again..."
			read en
			a57-check-in-books ;;
		esac
	else
		for((i=1;i<=5-length;i++)); do
			ID="0$ID"
		done
		ID="a57-$ID"
		if [ $(awk -F "%" -v ID="$ID" '$1==ID{print $1}' "$fname") ]; then	#图书存在
			if [ $(awk -F "%" -v ID="$ID" '$1==ID{print $5}' "$fname") = "in" ]; then
				#图书Status为"in"
				echo -n -e "\033[36m\033[21;0H"
				a57-show-line-center "This book's status is \"in\", please enter again..."
				read en
				a57-check-in-books
			fi
			echo -n -e "\033[0m\033[6;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{print $1}' "$fname"
			echo -n -e "\033[8;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $2}' "$fname"
			echo -n -e "\033[10;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $3}' "$fname"
			echo -n -e "\033[12;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $4}' "$fname"
			echo -n -e "\033[14;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $5}' "$fname"
			echo -n -e "\033[16;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $6}' "$fname"
			echo -n -e "\033[18;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $7}' "$fname"
			echo -n -e "\n\n\033[36m"
			a57-show-line-center "Are you sure? [y(es)/n(o)/c(ancel)]: "
			read s
			if [ -z "$s" ]; then
				s="y"	#默认"y"
			fi
			case "$s" in
				y|yes)
				a57-check-in-books-db "$ID" ;;
				n|no)
				a57-check-in-books ;;
				c|cancel)
				a57-main-menu ;;
				*)
				printf "\n"
				a57-show-line-center "Error, please enter again..."
				read en
				a57-check-in-books ;;
			esac
		else	#图书不存在
			echo -n -e "\033[36m\033[21;0H"
			a57-show-line-center "This book does not exist, please enter again..."
			read en
			a57-check-in-books
		fi
	fi
}
function a57-check-in-books-db(){	#修改归还图书的信息
	old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
	new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($5,"in",$5);print $0}' "$fname")
	sed -i 's/'"$old"'/'"$new"'/' "$fname"
	old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
	new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($6,"",$6);print $0}' "$fname")
	sed -i 's/'"$old"'/'"$new"'/' "$fname"
	old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
	new=$(awk -F "%" -v OFS="%" -v ID="$1" '$1==ID{sub($7,"",$7);print $0}' "$fname")
	sed -i 's/'"$old"'/'"$new"'/' "$fname"
	echo -n -e "\033[34m\033[14;"$x"Hin "
	echo -n -e "\033[16;"$x"H"
	for((i=1;i<=shellwidth-x;i++)); do
		printf " "
	done
	echo -n -e "\033[18;"$x"H"
	for((i=1;i<=shellwidth-x;i++)); do
		printf " "
	done
	echo -n -e "\033[36m\033[22;0H"
	a57-show-line-center "Success, any more books to check in? [y/n]: "
	read s
	if [ -z "$s" ]; then
		s="y"	#默认"y"
	fi
	case "$s" in
		y)
		a57-check-in-books ;;
		*)
		a57-main-menu ;;
	esac
}
#!/bin/bash
function a57-delete-books(){	#Delete books界面
	printf "\033c"
	shellwidth=$(stty size | awk '{print $2}')
	echo -n -e "\n\n\n\033[33m"
	a57-show-line-center "Delete books"
	echo -n -e "\n\n\033[35m"
	a57-show-line-left "      ID: "
	printf "\n\n"
	a57-show-line-left "   Title: "
	printf "\n\n"
	a57-show-line-left "  Author: "
	printf "\n\n"
	a57-show-line-left "    Tags: "
	printf "\n\n"
	a57-show-line-left "  in/out: "
	printf "\n\n"
	a57-show-line-left "Borrower: "
	printf "\n\n"
	a57-show-line-left " outTime: "
	x=$[$shellwidth/4+11]
	echo -n -e "\033[0m\033[6;"$x"H"
	read ID
	length=${#ID}
	if((length==0)); then	#未输入ID
		echo -n -e "\033[36m\033[20;0H"
		a57-show-line-center "Are you sure to delete the book? [y(es)/n(o)/c(ancel)]: "
		read s
		if [ -z "$s" ]; then
			s="y"	#默认"y"
		fi
		case "$s" in
			n|no)
			a57-delete-books ;;
			c|cancel)
			a57-main-menu ;;
			*)
			printf "\n"
			a57-show-line-center "Error, please enter again..."
			read en
			a57-delete-books ;;
		esac
	else
		for((i=1;i<=5-length;i++)); do
			ID="0$ID"
		done
		ID="a57-$ID"
		if [ $(awk -F "%" -v ID="$ID" '$1==ID{print $1}' "$fname") ]; then	#图书存在
			echo -n -e "\033[0m\033[6;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{print $1}' "$fname"
			echo -n -e "\033[8;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $2}' "$fname"
			echo -n -e "\033[10;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $3}' "$fname"
			echo -n -e "\033[12;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $4}' "$fname"
			echo -n -e "\033[14;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $5}' "$fname"
			echo -n -e "\033[16;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $6}' "$fname"
			echo -n -e "\033[18;"$x"H"
			awk -F "%" -v ID="$ID" '$1==ID{printf $7}' "$fname"
			echo -n -e "\n\n\033[36m"
			a57-show-line-center "Are you sure to delete the book? [y(es)/n(o)/c(ancel)]: "
			read s
			if [ -z "$s" ]; then
				s="y"	#默认"y"
			fi
			case "$s" in
				y|yes)
				a57-delete-books-db "$ID" ;;
				n|no)
				a57-delete-books ;;
				c|cancel)
				a57-main-menu ;;
				*)
				printf "\n"
				a57-show-line-center "Error, please enter again..."
				read en
				a57-delete-books ;;
			esac
		else	#图书不存在
			echo -n -e "\033[36m\033[21;0H"
			a57-show-line-center "This book does not exist, please enter again..."
			read en
			a57-delete-books
		fi
	fi
}
function a57-delete-books-db(){	#删除图书信息
	old=$(awk -F "%" -v ID="$1" '$1==ID{print $0}' "$fname")
	sed -i 's/'"$old"'//;/^$/d' "$fname"
	echo -n -e "\033[6;"$x"H"
	for((i=1;i<=shellwidth-x;i++)); do
		printf " "
	done
	echo -n -e "\033[8;"$x"H"
	for((i=1;i<=shellwidth-x;i++)); do
		printf " "
	done
	echo -n -e "\033[10;"$x"H"
	for((i=1;i<=shellwidth-x;i++)); do
		printf " "
	done
	echo -n -e "\033[12;"$x"H"
	for((i=1;i<=shellwidth-x;i++)); do
		printf " "
	done
	echo -n -e "\033[14;"$x"H"
	for((i=1;i<=shellwidth-x;i++)); do
		printf " "
	done
	echo -n -e "\033[16;"$x"H"
	for((i=1;i<=shellwidth-x;i++)); do
		printf " "
	done
	echo -n -e "\033[18;"$x"H"
	for((i=1;i<=shellwidth-x;i++)); do
		printf " "
	done
	echo -n -e "\033[36m\033[22;0H"
	a57-show-line-center "Success, any more books to delete? [y/n]: "
	read s
	if [ -z "$s" ]; then
		s="y"	#默认"y"
	fi
	case "$s" in
		y)
		a57-delete-books ;;
		*)
		a57-main-menu ;;
	esac
}

a57-welcome
