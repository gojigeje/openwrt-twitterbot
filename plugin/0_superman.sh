#!/bin/bash

# aksi_array+=("twit_superman")

playlist="http://www.youtube.com/playlist?list=PLMf7VY8La5RFIeOyIZ5IOm68WVb7c2dyT"
linkFile="temp/superman_link"

getlinks() {
  echo "> Downloading playlist.."
  curl -s "$playlist" > /tmp/playlist
  cat /tmp/playlist | grep 'pl-video-thumbnail' | grep -v 'Private\|Pribadi' | grep -o '<a .*href=.*>' | sed -e 's/<a /\n<a /g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d' | cut -d '&' -f1 | cut -d '=' -f2 > /tmp/playlist.baru
}

compare() {
  echo "> Getting new video links.."
  grep -Fxvf "$cache_folder/playlist.lama" "/tmp/playlist.baru" > "$linkFile"
}

download() {
  link=$(cat $linkFile | wc -l)
  max=$(( $link + 1 ))
  num=1

  if [[ $link -gt 0 ]]; then
    echo "> $link new video links found!"
  else
    echo "> No new video links.."
    exit 1
  fi

  while [[ $num -lt $max ]]; do
    line="`sed -n "$num"p $linkFile`"

    echo "> Downloading: $line"
    echo -ne "\e[96m"

    youtube-dl -f '18/43/5/36' -o "$save_folder/%(title)s.%(ext)s" "$line"

    echo -ne "\e[39m"
    let num++;
  done
}

updateplaylist() {
  rm "$cache_folder/playlist.lama.bak"
  mv "$cache_folder/playlist.lama" "$cache_folder/playlist.lama.bak"
  cp "/tmp/playlist.baru" "$cache_folder/playlist.lama"
  rm "$linkFile"
}



# main method
twit_superman_main() {
  # set tweet_status
  tweet_status="Today stats: $((RANDOM%300+100)) new followers, $((RANDOM%100)) unfollowers and followed $((RANDOM%100)) people via Unfollowers.com/?s=gojigeje"

  cekonline

  if [[ $isonline -gt 0 ]]; then
    getlinks
    compare
    download
    updateplaylist > /dev/null 2>&1
  else
    echo ":( Offline"
    exit 1
  fi
}
