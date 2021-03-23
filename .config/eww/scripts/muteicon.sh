#!/bin/bash

pamixer --get-mute | grep "false" -q && printf "墳" || printf "婢"
