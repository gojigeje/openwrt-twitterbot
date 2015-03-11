#!/bin/bash
#

kissanime() {
  # link t.co
  tco="$1"
  kissurl=$(curl -sI "$tco" | grep -i location | tr -d '\r' | cut -d " " -f2)

  echo "[autoreply] [kissanime] link t.co      : $tco"
  echo "[autoreply] [kissanime] link kissanime : $kissurl"

  cLink=$(echo $kissurl | sed 's/http:\/\///g' | sed 's/\/$//g')
  cSitus=$(echo $cLink | cut -d "/" -f1)
  cAnime=$(echo $cLink | cut -d "/" -f2)
  cJudul=$(echo $cLink | cut -d "/" -f3)
  cEpisode=$(echo $cLink | cut -d "/" -f4)
  # echo "kissurl: $kissurl ~ cLink: $cLink ~ cSitus: $cSitus ~ cAnime: $cAnime ~ cJudul: $cJudul ~ cEpisode: $cEpisode"

  target="http://proksi.ml/kissanime.com/Anime/$cJudul"
  echo "[autoreply] [kissanime] link proksi    : $target"
  
  if [[ "$cSitus" = "kissanime.com" || "$cSitus" = "www.kissanime.com" ]]; then
    kissanime_curlpage
  else
    twit -r "$twit_id" -s "Maaf bos $comm_user, Kayaknya link $tco salah deh :( ~ Itu beneran link kissanime?"
    exit 1
  fi
}

kissanime_curlpage() {
  echo "[autoreply] [kissanime] download page.."
  curl -A "$ua" -s "$target" > "temp/kissanime.temp"

  judulAnime=$(cat "temp/kissanime.temp" | grep bigChar | head -n1 | sed 's/<[^>]\+>/ /g' | sed "s/[ \t]*//$g" | sed 's/ $//g')
  jumlLink=$(awk '/<table\>/{a=1;next}/<\/table\>/{a=0}a' "temp/kissanime.temp" | grep "<a *.href=" | wc -l)
  status=$(cat "temp/kissanime.temp" | grep "Status:" | cut -d ";" -f2 | sed 's|<[^>]*>||g')
  lastEps=$(awk '/<table\>/{a=1;next}/<\/table\>/{a=0}a' "temp/kissanime.temp" | grep "<a href=" | head -n1 | grep -o -E "title=[\"'](.*)[\"']" | cut -d "\"" -f2 | sed 's/.*Episode //g;s/[^0-9]//g;s/^0*//')
  thumbnail=$(cat "temp/kissanime.temp" | grep image_src | grep -o -E "href=[\"'](.*)[\"']" | cut -d "\"" -f2 | sed -s 's/^/http:\/\/proksi.ml/g')

  # echo "judulAnime: $judulAnime"
  # echo "jumlLink: $jumlLink"
  # echo "status: $status"
  # echo "lastEps: $lastEps"
  # echo "thumbnail: $thumbnail"

  echo "[kissanime] cc $comm_user" > "temp/kissanime.twit"
  echo "$judulAnime" >> "temp/kissanime.twit"
  echo "$status, $jumlLink files" >> "temp/kissanime.twit"
  echo "Terbaru: $lastEps" >> "temp/kissanime.twit"
  # cat temp/kissanime.twit

  echo -n "[autoreply] [kissanime] download thumbnail.."
  curl -s "$thumbnail" -o "temp/kissanime.$cJudul.jpg"

  if [[ -f "temp/kissanime.$cJudul.jpg" ]]; then
    echo "ok"

    if [[ "$judulAnime" == "" || "$jumlLink" == "" || "$status" == "" || "$lastEps" == "" || "$thumbnail" == "" ]]; then
      echo "[autoreply] [kissanime] ada data yang kosong.. exit :("
      
      twit -r "$twit_id" -s "Maap bos $comm_user, kyaknya ada data yg kelewat deh pas ane cari info $tco tadi, duh.. coba lagi ya bos :("
      exit
    fi

    echo "[autoreply] [twit]"
    twit -s "`cat temp/kissanime.twit`" -i "temp/kissanime.$cJudul.jpg"

    # cleanup
    rm temp/kissanime.*
  else
    echo "gagal"
    echo "[autoreply] [kissanime] exit :("
    exit
  fi

  exit
}
