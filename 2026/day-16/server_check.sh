#!/bin/bash 

SERVICE="ssh" 

read -p "Do you want to check the status? (y/n): " CHOICE 

if [ "$CHOICE" = "y" ]; then 
	systemctl is-active --quiet $SERVICE 
	if [ $? -eq 0 ]; then 
		echo "$SERVICE is active" 
	else 
		echo "$SERVICE is not active" 
		fi 
	else echo "Skipped." 
fi
