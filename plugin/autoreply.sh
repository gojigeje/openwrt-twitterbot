#!/bin/bash
#
# Need package coreutils-paste + coreutils-sort (use --force-overwrite)

# aksi_array+=("twit_autoreply")
aksi_nolog="1"

touch "temp/autoreply_replied"

pilih_respon() {
  respon_array=(
      "Ada yang bisa aku bantu {target}? tapi kalo masalah asmara sori aku gabisa bantu, tanya @gojigeje aja"
      "aku cuma bercanda kok {target}.. ga usah dimasukin ati"
      "Apasih {target}?? mention2 terus.. ga ada kerjaan lain apa?"
      "asem si {target} kalo kentut jangan sembarangan oi..!!"
      "baru ketemu ama si {target}.. ternyata orangnya gimanaa gitu.. agak mengkhawatirkan.."
      "bentar aku tanya.. kamu udah mandi ta emangnya {target}??"
      "Dilanjut nanti yaa {target}.. gapapa sih kalo situ maksa lanjut, berarti situ ngefans aku"
      "fans terbaru aku nih --> {target} . orangnya suka ngupil sayangnya"
      "ga usah pake marah ya {target}.. just kidding just for fun"
      "Hai {target}, ada apa mention2.. jangan sok kenal yee?"
      "Halo {target}, gimana kabarnya? masih ingat janji kita kemarin ngga nih?"
      "hebat juga kamu {target} bisa tahan ga mandi 3 hari gitu.."
      "Hehe.. {target} ternyata gokil juga ya, bisa ga mandi sampe 3 hari gitu.. super gokil"
      "iih,, si {target} sejak kemaren mention aku terus.. kalo ngefans langsung bilang aja kali"
      "ini udah hari ke 3 si {target} ga mandi kayaknya ya? baunya sampek ke sini #ampuuunnn"
      "Kangen aku ya {target}? ga usah banyakan mention.. kalo emang ngefans langsung bilang aja deh"
      "Kenal aku ya {target}? aku kok gak kenal siapa kamu ya? kamu stalker yaa?"
      "Makasih ya {target} udah perhatian sama aku.."
      "nggak bosen ta kamu stalking aku sejak kemaren {target} ?"
      "Oi oi {target},, sabar dulu boss.. kalo ngefans jangan maksa!"
      "pede amat lo {target}.. aku laporin @gojigeje tau rasa lo.."
      "semalam lu tidurnya ga ngiler lagi kan {target}..?"
      "stalker detected --> {target} , aku korbannya.. ati2"
      "{target} <-- ini kayaknya stalker deh.. udah beberapa hari ini mantau TL aku terus"
      "{target} <-- kayaknya doi ngefans sama aku, aku di inbox terus euy"
      "{target} <-- stalker sejati.. inbox aku penuh ama pesan dia.."
      "{target} <-- udah lama stalking aku, aku jadi parno"
      "{target} apa lo mention-mention..?!! aku laporin @gojigeje kapok lo..!!"
      "{target} apanya @gojigeje ya? kok stalking dia terus??"
      "{target} ga usah lebay gitu deh.. aku jadi mules.."
      "{target} ga usah rempong gitu napa.. aku bisa GeEr ntar.."
      "{target} ini fans sejati aku guys.. foto aku ditempel2 gitu di kamarnya"
      "{target} ini siapa yaa? sok kenal sok dekat bingits.."
      "{target} mention berarti ngefans,, ngefans berarti berani follow aku dong"
      "{target} ngefans aku ya? kalo beneran ngefans jgn cm mention.. follow juga dong!!"
      "{target} ngefans sama @gojigeje kan yaa? ga usah pake malu2 gitu laah"
      "{target} plis deh, jangan maksa.. terima aja nasibmu nak"
      "{target} plis jangan alay gitu.. jadi mules liatnya.."
      "{target} sedari dulu kamu kan memang gitu.. aneh gitu.."
      "{target} temannya @gojigeje ya? apa jangan2 fansnya dia??"
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
  # grep "js-tweet-text tweet-text" "temp/autoreply.html" | sed "s/<[^>]\+>/ /g;s/[ \t]*//$g;s/  //g;s/&rlm;//g" | perl -MHTML::Entities -le 'while(<>) {print decode_entities($_);}' | sed '/^[ \t]*$/d;s/@ gojibox/@gojibox /g' > "temp/autoreply_isi"

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
      echo "-- id $twit_id $twit_user udah ada di database replied, gak usah direply"
    else
      echo "-- id $twit_id $twit_user belum ada di database replied, reply lalu masukin"

      pilih_respon
      getJam
      responnya=$(echo "$respon" | sed 's/{target}/'$twit_user'/g')
      echo "[ttytter] : $responnya $emot"
      ttytter -status="$responnya $emot"

      # masukin twit_id ke database
      echo "$twit_id" >> "temp/autoreply_replied"

      sleep 5
    fi

    let num++;
  done

  echo "- done -"
  exit 1
}
