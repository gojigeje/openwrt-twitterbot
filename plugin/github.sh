#!/bin/bash
#
# nama plugin : github
# deksripsi   : posting aktifitas github terbaru @gojigeje ke twitter
# 
# cara pakai  : twit_github
#
# keterangan  : kayaknya harus install dulu paket coreutils-paste + coreutils-sort (use --force-overwrite)

# aksi_array+=("twit_github")

# main method
twit_github_main() {

  aksi_nolog="1"
  touch "temp/github_posted"
  
  getJam
  echo "- [$getjam] curl feed.."
  curl --cacert "$certificate" -A "$ua" -s "https://github.com/gojigeje.atom" > "temp/github.xml"

  # id
  echo "id.."
  grep "<id>" "temp/github.xml" | tail -n +2 | sed "s/<[^>]\+>/ /g;s/[ \t]*//$g" | cut -d "/" -f2 > "temp/github_id"

  # title
  echo "title.."
  grep "<title " "temp/github.xml" | sed "s/<[^>]\+>/ /g;s/[ \t]*//$g;s/^gojigeje/[github-watch] @gojigeje/g;s/$/~/g" > "temp/github_title"

  # link
  echo "link.."
  grep "<link " "temp/github.xml" | tail -n +3 | cut -d '"' -f6 > "temp/github_link"

  # waktu
  echo "waktu.."
  grep "<published>" "temp/github.xml" | sed "s/<[^>]\+>/ /g;s/[ \t]*//$g;s/[TZ]/ /g" > "temp/github_waktu"

  # id waktu title link
  echo "id waktu title link.."
  paste "temp/github_id" "temp/github_title" "temp/github_link" | sort > "temp/github_tempel"
  sed -ie "s/[[:space:]]\+/ /g" "temp/github_tempel"

  echo -n "- twit per baris.. "
  baris=$(cat "temp/github_tempel" | wc -l)
  max=$(( $baris + 1 ))
  num=1
  echo "ada $baris baris"

  while [[ $num -lt $max ]]; do
    line="`sed -n "$num"p ""temp/github_tempel""`"

    git_id=$(echo "$line" | awk '{print $1}')

    # cek dulu di database posted
    if grep -q "$git_id" "temp/github_posted" ; then
      echo "-- id $git_id udah ada di database posted, gak usah dipost"
    else
      echo "-- id $git_id belum ada di database posted, post lalu masukin"

      getJam
      status=$(echo "$line" | cut -d ' ' -f2-)
      echo "   [twit] : $status"
      twit -s "$status"
      # ttytter -status="$status"

      # masukin git_id ke database
      echo "$git_id" >> "temp/github_posted"

      sleep 5
    fi

    let num++;
  done

  echo "- done -"
  exit 1
}
