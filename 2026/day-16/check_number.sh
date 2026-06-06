#!/bin/bash

if [ "$NUM" -gt 0 ]; then 
	echo "Positive Number"

elif [ "$NUM" -lt 0 ]; then 
	echo "Negative Number" 
else 
	echo "Zero" 
fi
