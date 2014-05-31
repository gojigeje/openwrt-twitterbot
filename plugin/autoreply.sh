#!/bin/bash
#
# Need package coreutils-paste + coreutils-sort (use --force-overwrite)

# aksi_array+=("twit_autoreply")
touch "temp/autoreply_replied"

pilih_respon() {
  respon_array=(
      "Ada yang bisa aku bantu {target}?"
      "Apasih {target}? ga ada kerjaan lain apa?"
      "Dilanjut nanti yaa {target}"
      "fans gue nih --> {target}"
      "Hai {target}, ada apa mention2 ?"
      "Halo {target}, gimana kabarnya?"
      "Hehe.. {target} aneh juga ya"
      "iih,, si {target} sejak kemaren mention gue terus.."
      "Kangen aku ya {target}?"
      "Kenal aku ya {target}?"
      "Makasih ya {target} udah perhatian sama gue"
      "nggak bosen elu stalking gue {target} ?"
      "Oi oi {target},, sabar dulu boss.."
      "stalker detected --> {target}"
      "{target} <-- ini kayaknya stalker deh"
      "{target} <-- ngefans sama gue"
      "{target} <-- udah lama stalking gue"
      "{target} apa lo mention-mention..?!!"
      "{target} apanya @gojigeje ya?"
      "{target} ini siapa yaa?"
      "{target} mention berarti ngefans"
      "{target} ngefans aku ya?"
      "{target} plis deh, jangan maksa.."
      "{target} temannya @gojigeje ya?"
    )
  respon_num=${#respon_array[*]}
  respon=${respon_array[$((RANDOM%respon_num))]}

  emot_array=(
      "(:"
      ":)"
      ":D"
      ":P"
      ":p"
      "^_^"
      "^o^"
    )
  emot_num=${#emot_array[*]}
  emot=${emot_array[$((RANDOM%emot_num))]}

}

# main method
twit_autoreply_main() {

  getJam
  echo "- [$getjam] curl halaman.."
  curl -s "https://twitter.com/search?f=realtime&q=%40gojibox&src=typd" > "temp/autoreply.html"

  echo "- ambil yang ngetwit.."
  grep "username js-action-profile-name" "temp/autoreply.html" | sed "s/<[^>]\+>/ /g;s/[ \t]*//$g;s/ //g;s/&rlm;//g" > "temp/autoreply_username"

  echo "- ambil id twitnya.."
  grep "data-tweet-id" "temp/autoreply.html" | cut -d '"' -f2 > "temp/autoreply_id"

  # echo "- ambil isi twitnya.."
  # grep "js-tweet-text tweet-text" "temp/autoreply.html" | sed "s/<[^>]\+>/ /g;s/[ \t]*//$g;s/  //g;s/&rlm;//g" | perl -MHTML::Entities -le 'while(<>) {print decode_entities($_);}' | sed '/^[ \t]*$/d' > "temp/autoreply_isi"

  echo "- sandingkan id + user + filter !gojibox + unik"
  paste "temp/autoreply_id" "temp/autoreply_username" | grep -v "gojibox" | sort -k 2,2 -u > "temp/autoreply_id_username"

  echo -n "- twit per baris.. "
  baris=$(cat "temp/autoreply_id_username" | wc -l)
  max=$(( $baris + 1 ))
  num=1
  echo "ada $baris baris"

  while [[ $num -lt $max ]]; do
    line="`sed -n "$num"p ""temp/autoreply_id_username""`"

    twit_id=$(echo "$line" | awk '{print $1}')
    twit_user=$(echo "$line" | awk '{print $2}')

    # cek dulu di database replied
    if grep -q "$twit_id" "temp/autoreply_replied" ; then
      echo "id $twit_id udah ada di database replied, gak usah direply"
    else
      echo "id $twit_id belum ada di database replied, reply lalu masukin"

      pilih_respon
      getJam
      responnya=$(echo "$respon" | sed 's/{target}/'$twit_user'/g')
      echo "[ttytter] : $responnya $emot ~ $getjam"
      # ttytter -status="$responnya $emot ~ $getjam"

      # masukin twit_id ke database
      echo "$twit_id" >> "temp/autoreply_replied"

      sleep 5
    fi

    let num++;
  done

  echo "- done -"
  exit 1
}
