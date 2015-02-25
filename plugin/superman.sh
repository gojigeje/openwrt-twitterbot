#!/bin/bash
#
# nama plugin : superman
# deksripsi   : twit link + gambar thumbnail video terbaru dari playlist youtube
# 
# cara pakai  : twit_superman
#
# keterangan  : dicontohkan playlist The Return of Superman
#               https://www.youtube.com/playlist?list=PLMf7VY8La5RFIeOyIZ5IOm68WVb7c2dyT
#

# aksi_array+=("twit_superman")

playlist="https://www.youtube.com/playlist?list=PLMf7VY8La5RFIeOyIZ5IOm68WVb7c2dyT"
linkFile="temp/superman.links"
touch "temp/superman.vid.new" "temp/superman.vid.old"

getlinks() {
  echo "> Refreshing playlist.. ($playlist)"
  curl --cacert "$certificate" -A "$ua" -s "$playlist" > "temp/superman.playlist"
  cat "temp/superman.playlist" | grep 'pl-video-thumbnail' | grep -v 'Private\|Pribadi' | grep -o '<a .*href=.*>' | sed -e 's/<a /\n<a /g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d' | cut -d '&' -f1 | cut -d '=' -f2 > "temp/superman.vid.new"
}

compare() {
  echo "> Getting new video links.."
  grep -Fvf "temp/superman.vid.old" "temp/superman.vid.new" > "$linkFile"
}

getinfo() {
  link=$(cat "$linkFile" | wc -l)
  max=$(( $link + 1 ))
  num=1

  if [[ $link -gt 0 ]]; then
    echo "> $link new video links found!"
  else
    echo "> No new video links.."
  fi

  while [[ $num -lt $max ]]; do

    cekonline

    line="`sed -n "$num"p $linkFile`"

    videolink="https://www.youtube.com/watch?v=$line"
    echo "> Getting video info[$num]: $videolink"

    curl --cacert "$certificate" -A "$ua" -s "$videolink" > "temp/superman.videopage"

    title=$(cat "temp/superman.videopage" | grep "twitter:title" | grep -o -E "content=[\"'](.*)[\"']" | cut -d "\"" -f2)
    image=$(cat "temp/superman.videopage" | grep "twitter:image" | grep -o -E "content=[\"'](.*)[\"']" | cut -d "\"" -f2)

    # dl thumbnail image
    curl --cacert "$certificate" -A "$ua" -s "$image" -o "temp/superman.thumbnail.$line.jpg"

    # last check
    if [[ -z "$title" || -z "$image" ]]; then
      echo "> Error getting video title or image..!"
      rm "temp/superman.videopage"
      exit
    else
      if [[ ! -f "temp/superman.thumbnail.$line.jpg" ]]; then
        echo "> Error downloading thumbnail image..!"
        exit
      else
        # everything seems ok :)
        echo "> title: $title"
        echo "> image: $image"
        echo "> [twit] [youtube-watch] $title..!! $videolink cc @gojigeje" -i "temp/superman.thumbnail.$line.jpg"
        twit -s "[youtube-watch] $title..!! $videolink cc @gojigeje" -i "temp/superman.thumbnail.$line.jpg"
      fi
    fi

    let num++;
  done

}

download() {
  link=$(cat $linkFile | wc -l)
  max=$(( $link + 1 ))
  num=1

  if [[ $link -gt 0 ]]; then
    echo "> $link new video links found!"
  else
    echo "> No new video links.."
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
  echo "> Cleaning up.."
  rm "temp/superman.playlist" "temp/superman.vid.old" 
  mv "temp/superman.vid.new" "temp/superman.vid.old"

  rm "$linkFile" "temp/superman.videopage"
  rm temp/superman.thumbnail.*
}

# main function
twit_superman_main() {

  getlinks
  compare
  getinfo
  updateplaylist
  echo ""
  
  exit
}
