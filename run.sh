#!/bin/bash

sed 's@DEVICE@'"$1"'@g' $2 > config.txt
./act config.txt > output.txt
