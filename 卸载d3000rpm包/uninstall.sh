#!/bin/bash

for line in $(<soft.txt)
do rpm -e $line

done
