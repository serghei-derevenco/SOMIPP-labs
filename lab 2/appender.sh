#!/bin/bash
SOURCE_PATH=$1
DESTINATION_PATH=$2
nasm -f bin -o file.bin $SOURCE_PATH
cp -v "file.bin" "$DESTINATION_PATH"
FILE_SIZE=$((1474560-$(wc -c "$DESTINATION_PATH" | awk '{print $1}')))

truncate -s +$FILE_SIZE $DESTINATION_PATH
