#!/bin/bash

aksi_array+=("twit_1cak")

wancak_random() {
  # ambil random link
  link=$(curl --cacert "\"$certificate\"" -Is "http://1cak.com/shuffle" | grep Location | cut -d " " -f2)
  url="http://1cak.com$link"
  imgname=$(echo "$link" | tr -d '\r' | sed 's/\///')
  urlproksi=$(echo "http://proksi.ml/1cak.com$link" | tr -d '\r')
  echo "url       : $url"
  echo "urlproksi : $urlproksi"

  # download halaman
  wget --referer="http://www.google.com" --user-agent="$ua" --header="Accept:text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" --header="Accept-Language: en-us,en;q=0.5" --header="Accept-Encoding: gzip,deflate"--header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" --header="Keep-Alive: 300" --no-cache "$urlproksi" -qO "temp/1cak.tmp"

  # extract gambar, cek unsafe
  # http://stackoverflow.com/questions/20152170
  img=$(cat "temp/1cak.tmp" | grep "onmouseover" | grep "title" | grep "cdn" | grep -o -E "src=[\"'](.*)[\"'] " | cut -d "'" -f2)
  unsafe=$(cat "temp/1cak.tmp" | grep "images/unsave.jpg" | wc -l)

  if [[ $unsafe -gt 0 ]]; then
    echo "unsafe?   : $unsafe. Gambar unsafe, ga jadi posting.."
    twit -s "le gue mau posting gambar dari 1cak, tapi ternyata gambarnya unsafe,, ga jadi deh.."
  else
    echo "unsafe?   : $unsafe. Gambar safe, lanjut posting.."
    imgurl="http:/$img"
    imgurlproksi="http://proksi.ml$img"
    echo "imgurl    : $imgurl"

    # extract title
    judul=$(cat "temp/1cak.tmp" | grep "onmouseover" | grep "title" | grep "cdn" | sed 's|</b>|-|g' | sed 's|<[^>]*>||g' | sed -e 's/^[ \t]*//' | sed 's/"//g' | php-cli -R 'echo html_entity_decode($argn);')
    echo "judul     : $judul"

    # download image
    echo "dl image  : $imgurlproksi > temp/1cak.$imgname.jpg"
    curl -s "$imgurlproksi" -o "temp/1cak.$imgname.jpg"

    # curl --referer "http://www.google.com" -A "$ua" -H "Accept:text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" -H "Accept-Language: en-us,en;q=0.5" -H "Accept-Encoding: gzip,deflate" -H "Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" -H "Keep-Alive: 300" "$imgurl" -o "temp/1cak.$imgname.jpg"
    # wget --referer="http://www.google.com" --user-agent="$ua" --header="Accept:text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" --header="Accept-Language: en-us,en;q=0.5" --header="Accept-Encoding: gzip,deflate"--header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" --header="Keep-Alive: 300" --no-cache "$imgurl" -qO "temp/1cak.$imgname.jpg"

    # tweet
    twit -s "[1cak] $judul ~ $url" -i "temp/1cak.$imgname.jpg"
  fi
  echo ""
}

# wancak_search () {
  
# }

# main method
twit_1cak_main() {

  if [[ -z "$1" ]]; then
    echo "Tanpa parameter, random posting.."
    wancak_random
  else
    echo ""
  fi

  # cleanup
  rm temp/1cak.*
  exit

}
