#!/bin/bash

demo_local() {
    local NAME="LocalUser"
    echo "Inside Function: $NAME"
}

demo_global() {
    GLOBAL_NAME="GlobalUser"
}

demo_local
echo "Outside Function: $NAME"

demo_global
echo "Global Variable: $GLOBAL_NAME"