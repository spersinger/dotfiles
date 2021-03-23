#!/bin/bash
mpc | awk -F "[()]" '{ for (i=2; i<NF; i+=2) print $i }' | grep "\w*[0-9]\w*" -o | sed '$!d'
