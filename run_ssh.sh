#!/bin/bash

user="root"
server="machine2"
script="fdisk.sh"

ssh $user@$server  'bash -s' < $script
