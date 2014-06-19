#!/bin/bash

aksi_array+=("twit_uptime")

# main method
twit_uptime_main() {
  prefix_array=(
      "[my uptime]"
      "[system uptime]"
      "[uptime]"
      "I've been up for"
      "System up for"
      "Server up for"
    )

  prefix_num=${#prefix_array[*]}
  prefix=${prefix_array[$((RANDOM%prefix_num))]}
  
  uptime=$(uptime)
  uptime=${uptime/#*up}

  # set tweet_status
  tweet_status="$prefix$uptime #OpenWRT"
}
