#!/bin/bash

aksi_array+=("twit_uptime")

# main method
twit_uptime_main() {
  if [[ -z "$1" ]]; then
    uptime_getrecord
    if [[ ! -z "$plugin_uptime_record" ]]; then
      longest="~ longest: $record ($record_date)"
    fi

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
    tweet_status="$prefix$uptime #OpenWRT $longest"
    echo "$tweet_status"
  else

    if [[ "$1" == "record" ]]; then
      uptime_record
      exit 1
    fi

  fi
}

uptime_record() {
  tgl=$(date +'%d-%m-%y')
  uptime=$(</proc/uptime)
  uptime=${uptime%%.*}
  # cek entri di config
  entri="plugin_uptime_record"
  entridate="plugin_uptime_date"

  if [[ -z "$plugin_uptime_record" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      echo "entri ada tapi kosong, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$uptime'"/g' "plugin/plugin.conf"
      sed -i 's/'$entridate'*.*/'$entridate'="'$tgl'"/g' "plugin/plugin.conf"
    else
      echo "entri ga ada, insert"
      echo "$entri=\"$uptime\"" >> "plugin/plugin.conf"
      echo "$entridate=\"$tgl\"" >> "plugin/plugin.conf"
    fi
  else
    if [[ "$plugin_uptime_record" -lt "$uptime" ]]; then
      echo "record lebih kecil, update record ($uptime, $tgl)"
      sed -i 's/'$entri'*.*/'$entri'="'$uptime'"/g' "plugin/plugin.conf"
      sed -i 's/'$entridate'*.*/'$entridate'="'$tgl'"/g' "plugin/plugin.conf"
    else
      echo "record lebih besar, record tetap"
    fi

  fi
}

uptime_getrecord() {
  if [[ ! -z "$plugin_uptime_record" ]]; then
    # uptime=$(</proc/uptime)
    # uptime=${uptime%%.*}
    uptime="$plugin_uptime_record"
    seconds=$(( uptime%60 ))
    minutes=$(( uptime/60%60 ))
    hours=$(( uptime/60/60%24 ))
    days=$(( uptime/60/60/24 ))
    if [[ "$days" -gt "1" ]]; then
      plural="s"
    else
      plural=""
    fi

    record="$days day$plural, $hours:$minutes"
    record_date="$plugin_uptime_date"
  fi
}

