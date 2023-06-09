#!/bin/bash

server_name=$(hostname)

function continue_work() {
while
printf "Do you want to continue to the menu? <y/N>\n" really
read -r really
do
case $really in
	[yY][eE][sS]|[yY])
		menu
		;;
	[nN][oO]|[nN])
		echo "Ok.. See you.. Bye! =)"
		exit 1
		;;
	*)
		echo "Sorry i did'nt understand..."
		continue
		;;
esac
done		
}


function dotkilla() {
while
printf "Insert your Flipper SD in your computer.\n"
printf "Is your Flipper SD mounted? <y/N>\n" response
read -r response
do
case $response in
	[yY][eE][sS]|[yY])
		if df | grep -iw "Flipper SD" > /dev/null
		then
			printf "You want to clean all the \"._dotfiles\" created by plugging your SD into a macOS? <y/N>\n" rexponze
			read -r rexponze
				case $rexponze in
					[yY][eE][sS]|[yY])
    					echo "Cleaning dot_files into \"/Volumes/FLIPPER SD\" ..."
    					sudo dot_clean /Volumes/FLIPPER\ SD
    					echo "Well done!"
    					continue_work
    					;;
    				[nN][oO]|[nN])
						echo "Ok, maybe you choosed the wrong option!"
    					continue_work
    					;;
    			esac
		else
    		echo "Check double!! Maybe your SD is not well mounted in."
    		continue
		fi
		;;
	[nN][oO]|[nN])
		echo "Ok, so take it and mount it!"
    	continue_work
		;;
	[eE][xX][iI][tT])
		break
		exit 1
		;;
	[qQ][uU][iI][tT])
		break
		exit 1
		;;
	*)
    	echo "I didn't understand, I'm sorry, Try again..."
    	continue
		;;
esac
done
}


function eject_sd() {
while
printf "Do you want to eject your SD? <y/N>\n" ejecting
read -r ejecting
do
case $ejecting in
	[yY][eE][sS]|[yY])
		echo "Ejecting volume..."
		sudo diskutil eject /Volumes/FLIPPER\ SD
		echo "See yo soon!"
		continue_work
		;;
	[nN][oO]|[nN])
		echo "Ok..Thank you.."
		continue_work
		;;
	[eE][xX][iI][tT])
		exit 1
		;;
	[qQ][uU][iI][tT])
		exit 1
		;;
	*)
    	echo "I didn't understand, I'm sorry, Try again..."
    	continue
		;;
esac
done
}


function backup_sd() {
while
printf "Do you want to backup all datas of your FLIPPER SD? <y/N>\n" backsups
read -r backsups
do
case $backsups in
	[yY][eE][sS]|[yY])
		if [ -d "/Volumes/FLIPPER SD" ]; 
		then
    		rsync -avzh --progress /Volumes/FLIPPER\ SD/ ~/Flipper_Backup/
    		echo "Backup completed successfully! You can find it in ~/Flipper_Backup/"
      		continue_work
		else
    		echo "External disk named 'FLIPPER SD' not found."
    		continue_work
		fi
		;;
	[nN][oO]|[nN])
		echo "Ok..Thank you..."
		continue_work
		;;
esac
done
}


function menu() {
echo -e
echo -e 
printf '%b\n' "1) Dotfile Cleaner"
printf '%b\n' "2) FLIPPER SD Backup"
printf '%b\n' "3) Ejecting SD"
printf '%b\n' "quit/exit) Close the App"
echo -e
printf '%b\n' "Choose an option: "
        read a
        case $a in
	        1) dotkilla ; continue_work ;;
	        2) backup_sd ; continue_work ;;
	        3) eject_sd ; continue_work ;;
			[qQ][uU][iI][tT]) exit 0 ;;
			[eE][xX][iI][tT]) exit 0 ;;
			*) printf "Wrong option."; menu;;
        esac
}



function show_usage() {
   printf "Usage: $0 [option]\n"
   printf "\n"
   printf "Options:\n"
   printf " -m|--menu, Print the interactive menu\n"
   printf " -h|--help, Print help\n"
   printf " -q|--quit Exit the program\n"   
   printf " -e|--exit Exit the program\n"

return 0
}

while [ ! -z "$1" ]; do
   if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
      show_usage	  
   elif [[ "$1" == "--menu" ]] || [[ "$1" == "-m" ]]; then
      menu
   elif [[ "$1" == "-q" ]] || [[ "$1" == "--quit" ]]; then
   	  break
      exit 1
   elif [[ "$1" == "-e" ]] || [[ "$1" == "--exit" ]]; then
   	  break
      exit 1
   else
      echo "Incorrect input provided $1"
      show_usage
   fi
shift
done
