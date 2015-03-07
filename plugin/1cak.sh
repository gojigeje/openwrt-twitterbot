#!/bin/bash
#
# nama plugin : 1cak
# deksripsi   : plugin untuk mengambil dan memposting gambar meme dari 1cak.com
# 
# cara pakai  : twit_1cak "keyword"
#
#               bila keyword tidak diisi, akan posting meme random
#               bila keyword diisi, akan mencari 6 meme dengan keyword tsb dan 
#               memposting salah satu diantaranya
#

aksi_array+=("twit_1cak")

wancak_random() {
  # ambil random link
  link=$(curl --cacert "\"$certificate\"" -Is "http://1cak.com/shuffle" | grep Location | cut -d " " -f2)
  url="http://1cak.com$link"
  urlproksi=$(echo "http://proksi.ml/1cak.com$link" | tr -d '\r')

  wancak_tweet "$urlproksi"
}

wancak_search () {
  keyword="$1"
  urlsearch="http://proksi.ml/1cak.com/search-0-$1"
  
  echo "keyword     : $1"
  echo "urlsearch   : $urlsearch"
  # download halaman 1st
  wget --referer="http://www.google.com" --user-agent="$ua" --header="Accept:text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" --header="Accept-Language: en-us,en;q=0.5" --header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" --header="Keep-Alive: 300" --no-cache "$urlsearch" -qO "temp/1cak.search.tmp"
  # extract url posting 1st
  cat "temp/1cak.search.tmp" | grep "title" | grep "cdn" | grep -o -E "href=[\"'](.*)[\"'] " | cut -d "'" -f2 | sed 's/\///' >> "temp/1cak.search.urls.tmp"

  # ada hasil?
  hasil=$(cat "temp/1cak.search.tmp" | grep "img/error.png" | grep "No more posts to show" | wc -l)
  if [[ $hasil -gt 0 ]]; then
    echo "hasil       : nggak ada hasil"
    echo "[twit]      : hasyemm.. le gue kagak bisa nemu meme tentang $1 di 1cak.. ga lengkap nih..!!"
    twit -s "hasyemm.. le gue kagak bisa nemu meme tentang $1 di 1cak.. ga lengkap nih..!!"
    echo ""
    exit
  fi

  # extract link 2nd
  urlnext=$(cat "temp/1cak.search.tmp" | grep "next_page_link" | grep -o -E "href=[\"'](.*)[\"'] " | cut -d "'" -f2 | sed 's/\///')
  urlsearch="http://proksi.ml/$urlnext"
  echo "urlnext     : $urlsearch"
  # download halaman 2nd
  rm "temp/1cak.search.tmp"
  wget --referer="http://www.google.com" --user-agent="$ua" --header="Accept:text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" --header="Accept-Language: en-us,en;q=0.5" --header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" --header="Keep-Alive: 300" --no-cache "$urlsearch" -qO "temp/1cak.search.tmp"
  # extract url posting 2nd
  cat "temp/1cak.search.tmp" | grep "title" | grep "cdn" | grep -o -E "href=[\"'](.*)[\"'] " | cut -d "'" -f2 | sed 's/\///' >> "temp/1cak.search.urls.tmp"

  # # extract link 3rd
  # urlnext=$(cat "temp/1cak.search.tmp" | grep "next_page_link" | grep -o -E "href=[\"'](.*)[\"'] " | cut -d "'" -f2 | sed 's/\///')
  # urlsearch="http://proksi.ml/$urlnext"
  # echo "urlnext   : $urlsearch"
  # # download halaman 3rd
  # rm "temp/1cak.search.tmp"
  # wget --referer="http://www.google.com" --user-agent="$ua" --header="Accept:text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" --header="Accept-Language: en-us,en;q=0.5" --header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" --header="Keep-Alive: 300" --no-cache "$urlsearch" -qO "temp/1cak.search.tmp"
  # # extract url posting 3rd
  # cat "temp/1cak.search.tmp" | grep "title" | grep "cdn" | grep -o -E "href=[\"'](.*)[\"'] " | cut -d "'" -f2 | sed 's/\///' >> "temp/1cak.search.urls.tmp"

  echo "hasil       :"
  cat "temp/1cak.search.urls.tmp"
  url=$(sort -R "temp/1cak.search.urls.tmp" | head -n 1)
  urlproksi="http://proksi.ml/$url"

  wancak_tweet "$urlproksi"
}

wancak_tweet() { # params: urlproksi
  echo "url         : $url"
  echo "urlproksi   : $urlproksi"

  # download halaman
  wget --referer="http://www.google.com" --user-agent="$ua" --header="Accept:text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" --header="Accept-Language: en-us,en;q=0.5" --header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" --header="Keep-Alive: 300" --no-cache "$urlproksi" -qO "temp/1cak.tmp"

  # extract gambar, cek unsafe
  # http://stackoverflow.com/questions/20152170
  img=$(cat "temp/1cak.tmp" | grep "onmouseover" | grep "title" | grep "cdn" | grep -o -E "src=[\"'](.*)[\"'] " | cut -d "'" -f2)
  unsafe=$(cat "temp/1cak.tmp" | grep "images/unsave.jpg" | wc -l)

  if [[ $unsafe -gt 0 ]]; then
    echo "unsafe?     : $unsafe. Gambar unsafe, ga jadi posting.."
    twit -s "le gue mau posting meme dari 1cak, tapi ternyata gambarnya NSFW,, ga jadi deh.."
  else
    echo "unsafe?     : $unsafe. Gambar safe, lanjut posting.."
    imgurl="http:/$img"
    imgurlproksi="http://proksi.ml$img"
    echo "imgurl      : $imgurl"

    # extract title
    judul=$(cat "temp/1cak.tmp" | grep "onmouseover" | grep "title" | grep "cdn" | sed 's|</b>|-|g' | sed 's|<[^>]*>||g' | sed -e 's/^[ \t]*//' | sed 's/"//g' | php-cli -R 'echo html_entity_decode($argn);')
    echo "judul       : $judul"

    # download image
    imgname=$(echo "$url" | grep -o '[^\/]*$' | tr -d '\r')  # http://stackoverflow.com/a/22727242
    echo "dl image    : $imgurlproksi > temp/1cak.$imgname.jpg"
    curl -s "$imgurlproksi" -o "temp/1cak.$imgname.jpg"

    # curl --referer "http://www.google.com" -A "$ua" -H "Accept:text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" -H "Accept-Language: en-us,en;q=0.5" -H "Accept-Encoding: gzip,deflate" -H "Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" -H "Keep-Alive: 300" "$imgurl" -o "temp/1cak.$imgname.jpg"
    # wget --referer="http://www.google.com" --user-agent="$ua" --header="Accept:text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5" --header="Accept-Language: en-us,en;q=0.5" --header="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" --header="Keep-Alive: 300" --no-cache "$imgurl" -qO "temp/1cak.$imgname.jpg"

    echo "[twit]      : posting.."
    # tweet
    twit -s "[1cak] $judul ~ $url" -i "temp/1cak.$imgname.jpg"
  fi
  echo ""
}

# main method
twit_1cak_main() {

  if [[ -z "$1" ]]; then
    echo "Tanpa parameter, random posting.."
    wancak_random
  else
    wancak_search "$1"
  fi

  # cleanup
  rm temp/1cak.*
  exit

}
