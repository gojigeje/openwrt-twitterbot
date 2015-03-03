#!/bin/bash
#
# nama plugin : subscene
# deksripsi   : plugin untuk memposting judul dan gambar film populer di subscene.com
#               dipilih secara acak salah satu dari 3 judul di homepage subscene.com
# 
# cara pakai  : twit_subscene
#

# aksi_array+=("twit_subscene")

twit_subscene_main() {

  echo "[subscene] ambil halaman.."

  # ambil halaman
  curl --cacert "$certificate" -A "$ua" -s "http://subscene.com" > "temp/subscene.tmp"

  # filter movie-url, menghasilkan 3 grup movie
  cat "temp/subscene.tmp" | sed -n 107,280p | grep "/subtitles/\|img\|[0-9] downloads\|[0-9] subtitles" | sed -e 's/^[ \t]*//' > "temp/subscene.grup"

  # extract salah 1 grup
  acak=$((RANDOM%3))
  echo "[subscene] extract data.. (grup $acak)"

  if [[ $acak == "0" ]]; then
    # pilih grup 1
    mlink=$(sed -n 1,8p "temp/subscene.grup" | sed -n 1p | grep -o -E "href=[\"'](.*)[\"']" | cut -d '"' -f2)
    mimg=$(sed -n 1,8p "temp/subscene.grup" | sed -n 2p | grep -o -E "src=[\"'](.*)[\"']" | cut -d '"' -f2)
    mimgname=$(echo "$mlink" | cut -d "/" -f3)
    mtitle=$(sed -n 1,8p "temp/subscene.grup" | sed -n 3p | sed 's|<[^>]*>||g')
    mdownload=$(sed -n 1,8p "temp/subscene.grup" | sed -n 7p)
    msubs=$(sed -n 1,8p "temp/subscene.grup" | sed -n 8p)
  elif [[ $acak == "1" ]]; then
    # pilih grup 2
    mlink=$(sed -n 9,16p "temp/subscene.grup" | sed -n 1p | grep -o -E "href=[\"'](.*)[\"']" | cut -d '"' -f2)
    mimg=$(sed -n 9,16p "temp/subscene.grup" | sed -n 2p | grep -o -E "src=[\"'](.*)[\"']" | cut -d '"' -f2)
    mimgname=$(echo "$mlink" | cut -d "/" -f3)
    mtitle=$(sed -n 9,16p "temp/subscene.grup" | sed -n 3p | sed 's|<[^>]*>||g')
    mdownload=$(sed -n 9,16p "temp/subscene.grup" | sed -n 7p)
    msubs=$(sed -n 9,16p "temp/subscene.grup" | sed -n 8p)
  else
    # pilih grup 3
    mlink=$(sed -n 17,24p "temp/subscene.grup" | sed -n 1p | grep -o -E "href=[\"'](.*)[\"']" | cut -d '"' -f2)
    mimg=$(sed -n 17,24p "temp/subscene.grup" | sed -n 2p | grep -o -E "src=[\"'](.*)[\"']" | cut -d '"' -f2)
    mimgname=$(echo "$mlink" | cut -d "/" -f3)
    mtitle=$(sed -n 17,24p "temp/subscene.grup" | sed -n 3p | sed 's|<[^>]*>||g')
    mdownload=$(sed -n 17,24p "temp/subscene.grup" | sed -n 7p)
    msubs=$(sed -n 17,24p "temp/subscene.grup" | sed -n 8p)
  fi

  if [[ "$mlink" == "" || "$mimg" == "" || "$mtitle" == "" || "$mdownload" == "" || "$msubs" == "" ]]; then
    echo "[subscene] ERROR, ada data yang kosong.. :("
    exit
  else

    # download img
    echo "[subscene] download poster img.."
    curl --cacert "$certificate" -A "$ua" -s "$mimg" -o "temp/subscene.$mimgname.jpg"

    echo "[subscene] Popular Movie:"
    echo "$mtitle"
    echo "$mdownload"
    echo "$msubs"
    echo "http://subscene.com$mlink"

    echo "[subscene] Popular Movie:" > "temp/subscene.twit"
    echo "$mtitle" >> "temp/subscene.twit"
    echo "$mdownload" >> "temp/subscene.twit"
    echo "$msubs" >> "temp/subscene.twit"
    echo "http://subscene.com$mlink" >> "temp/subscene.twit"

  fi

  # tweet
  twit -s "`cat temp/subscene.twit`" -i "temp/subscene.$mimgname.jpg"
  
  # cleanup
  rm temp/subscene*

  exit

}