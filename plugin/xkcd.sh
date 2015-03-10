#!/bin/bash
#
# nama plugin : xkcd
# deksripsi   : plugin untuk mengambil dan memposting gambar komik dari xkcd.com
# 
# cara pakai  : twit_xkcd
#

aksi_array+=("twit_xkcd")

xkcd_getid() {
  touch "temp/xkcd_posted_id"
  echo -n "[xkcd] get comic id: "
  cid=$(curl -si http://c.xkcd.com/random/comic/ | grep Location | cut -d " " -f2 | sed 's/[^0-9]//g')
  echo "$cid"

  xkcd_cekid
}

xkcd_cekid() {
  echo -n "[xkcd] sudah pernah dipost? "
  if grep -q "$cid" "temp/xkcd_posted_id" ; then
    echo "sudah, pilih lagi"
    xkcd_getid
  else
    echo "belum, lanjut"
    xkcd_getcomic
  fi
}

xkcd_getcomic() {
  echo "[xkcd] getcomic.. http://xkcd.com/$cid/"
  curl -s "http://xkcd.com/$cid/" > "temp/xkcd.temp"

  judul=$(cat "temp/xkcd.temp" | grep ctitle | sed 's/<[^>]\+>//g')
  imgurl=$(cat "temp/xkcd.temp" | grep hotlinking | sed 's/^.*: //g')
  echo "[xkcd] judul  : $judul"
  echo "[xkcd] imgurl : $imgurl"

  echo -n "[xkcd] download comic.. "    
  curl -s "$imgurl" -o "temp/xkcd.$cid.jpg"
  
  if [[ -f "temp/xkcd.$cid.jpg" ]]; then
    echo "ok"
    # masukin id ke db
    echo "$cid" >> "temp/xkcd_posted_id"
  else
    echo "gagal"
    echo "[xkcd] exit :("
  fi
}

twit_xkcd_main() {
  getJam
  echo "[xkcd] [$getjam]"
  xkcd_getid

  echo "[xkcd] twit.."
  twit -s "[xkcd] $judul ~ http://xkcd.com/$cid/" -i "temp/xkcd.$cid.jpg"

  # cleanup
  rm temp/xkcd.*
  exit
}
