#!/bin/bash
# -------------------------------------------------------------------------

# change directory to script's directory
# cd /root/script/twit
cd /home/goji/git/openwrt-twitterbot

setup() {
  hari=$(date +%u)
  tanggal=$(date +%d)
  bulan=$(date +%m)
  tahun=$(date +%Y)
  jam=$(date +%H)
  aksi_array=()

  # load plugin
  for f in plugin/*; do
     . $f
     # echo "$f"
  done

  if [[ -z "$1" ]]; then
    aksi_num=${#aksi_array[*]}
    aksi=${aksi_array[$((RANDOM%aksi_num))]}
    # make sure aksi not same like before
    if [[ -f "temp/$aksi.last" ]]; then
      setup
    else
      rm temp/*.last
      touch "temp/$aksi.last"
    fi
  else
    aksi="$1"
    if [[ "$aksi_nolog" != "1" ]]; then
      rm temp/*.last
      touch "temp/$aksi.last"
    fi
  fi
}
getJam() {
  # getjam=$(date +'%H:%M:%S')
  getjam=$(date +'%H:%M')
}
cekonline() {
  if ! eval "ping -c 1 8.8.4.4 -w 2 > /dev/null 2>&1"; then
    echo "ERROR: Nggak online!"
    exit 1
  fi
}

post_tweet() {
  if [[ ! -z "$tweet_status" ]]; then
    getJam
    echo "[ttytter][$getjam] : $tweet_status"
    echo "$tweet_status" | ttytter -status=-
    cekposting
  else
    echo "ERROR_STATUS_KOSONG: $aksi"
  fi
}

cekonline
if [[ -z "$1" ]]; then
  setup
  "$aksi"_main
  post_tweet

  # once more when action is greeting
  if [[ $aksi = "twit_greeting" ]]; then
    setup
    "$aksi"_main
    post_tweet  
  fi

else
  setup "$1"
  "$aksi"_main "${@:2}"
  post_tweet
fi
