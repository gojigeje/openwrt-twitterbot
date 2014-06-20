#!/bin/bash
#
# Need package coreutils-paste + coreutils-sort (use --force-overwrite)

# aksi_array+=("twit_reply")
aksi_nolog="1"
touch "temp/reply_replied"

pilih_respon() {
  respon_array=(
      "Halo {target}, gimana kabarnya? masih ingat janji kita kemarin ngga nih?"
      "{target} plis jangan alay gitu.. jadi mules liatnya.."
      "{target} ngefans sama @gojigeje kan yaa? ga usah pake malu2 gitu laah"
      "{target} ini fans sejati aku guys.. foto aku ditempel2 gitu di kamarnya"
      "Kenal aku ya {target}? aku kok gak kenal siapa kamu ya? kamu stalker yaa?"
      "Oi oi {target},, sabar dulu boss.. kalo ngefans jangan maksa!"
      "{target} <-- udah lama stalking aku, aku jadi parno"
      "ga usah pake marah ya {target}.. just kidding just for fun"
      "baru ketemu ama si {target}.. ternyata orangnya gimanaa gitu.. agak mengkhawatirkan.."
      "{target} ngefans aku ya? kalo beneran ngefans jgn cm mention.. follow juga dong!!"
      "{target} sedari dulu kamu kan memang gitu.. aneh gitu.."
      "pede amat lo {target}.. aku laporin @gojigeje tau rasa lo.."
      "{target} ga usah rempong gitu napa.. aku bisa GeEr ntar.."
      "Hai {target}, ada apa mention2.. jangan sok kenal yee?"
      "bentar aku tanya.. kamu udah mandi ta emangnya {target}??"
      "{target} <-- ini kayaknya stalker deh.. udah beberapa hari ini mantau TL aku terus"
      "nggak bosen ta kamu stalking aku sejak kemaren {target} ?"
      "fans terbaru aku nih --> {target} . orangnya suka ngupil sayangnya"
      "Makasih ya {target} udah perhatian sama aku.."
      "semalam lu tidurnya ga ngiler lagi kan {target}..?"
      "hebat juga kamu {target} bisa tahan ga mandi 3 hari gitu.."
      "{target} ga usah lebay gitu deh.. aku jadi mules.."
      "{target} apa lo mention-mention..?!! aku laporin @gojigeje kapok lo..!!"
      "{target} <-- stalker sejati.. inbox aku penuh ama pesan dia.."
      "{target} <-- kayaknya doi ngefans sama aku, aku di inbox terus euy"
      "{target} mention berarti ngefans,, ngefans berarti berani follow aku dong"
      "Dilanjut nanti yaa {target}.. gapapa sih kalo situ maksa lanjut, berarti situ ngefans aku"
      "aku cuma bercanda kok {target}.. ga usah dimasukin ati"
      "asem si {target} kalo kentut jangan sembarangan oi..!!"
      "{target} temannya @gojigeje ya? apa jangan2 fansnya dia??"
      "ini udah hari ke 3 si {target} ga mandi kayaknya ya? baunya sampek ke sini #ampuuunnn"
      "Ada yang bisa aku bantu {target}? tapi kalo masalah asmara sori aku gabisa bantu, tanya @gojigeje aja"
      "Kangen aku ya {target}? ga usah banyakan mention.. kalo emang ngefans langsung bilang aja deh"
      "{target} apanya @gojigeje ya? kok stalking dia terus??"
      "Hehe.. {target} ternyata gokil juga ya, bisa ga mandi sampe 3 hari gitu.. super gokil"
      "{target} ini siapa yaa? sok kenal sok dekat bingits.."
      "Apasih {target}?? mention2 terus.. ga ada kerjaan lain apa?"
      "iih,, si {target} sejak kemaren mention aku terus.. kalo ngefans langsung bilang aja kali"
      "stalker detected --> {target} , aku korbannya.. ati2"
      "{target} plis deh, jangan maksa.. terima aja nasibmu nak"
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
twit_reply_main() {

  getJam
  echo "- [$getjam] curl halaman.."
  curl -s "https://twitter.com/search?f=realtime&q=%40gojibox&src=typd" > "temp/reply.html"

  # echo "- ambil yang ngetwit.."
  grep "username js-action-profile-name" "temp/reply.html" | sed "s/<[^>]\+>/ /g;s/[ \t]*//$g;s/ //g;s/&rlm;//g" > "temp/reply_username"

  # echo "- ambil id twitnya.."
  grep "data-tweet-id" "temp/reply.html" | cut -d '"' -f2 > "temp/reply_id"

  # echo "- ambil isi twitnya.."
  grep "js-tweet-text tweet-text" "temp/reply.html" | sed "s/<[^>]\+>/ /g;s/[ \t]*//$g;s/  //g;s/&rlm;//g" | perl -MHTML::Entities -le 'while(<>) {print decode_entities($_);}' | sed '/^[ \t]*$/d;s/@ gojibox/@gojibox /g' > "temp/reply_isi"

  # echo "- sandingkan id + user + isi"
  paste "temp/reply_id" "temp/reply_username" "temp/reply_isi" > "temp/reply_id_username_isi"
  sed -i 's/[[:space:]]\+/ /g' "temp/reply_id_username_isi"

  # echo "- filter !gojibox "
  baris=$(cat "temp/reply_id_username_isi" | wc -l)
  max=$(( $baris + 1 ))
  num=1
  > "temp/reply_id_username"

  while [[ $num -lt $max ]]; do
    line="`sed -n "$num"p "temp/reply_id_username_isi"`"

    twit_user=$(echo "$line" | awk '{print $2}')
    twit_isi=$(echo "$line" | cut -d " " -f 3-)

    # cari yang bukan @gojibox
    if [[ ! "$twit_user" == "@gojibox" ]]; then
      echo "$line" >> "temp/reply_id_username"
      # echo "-- user: $twit_user, isi: $twit_isi"
    fi

    let num++;
  done

  # echo "- sandingkan id + user + filter !gojibox + unik"
  # paste "temp/reply_id" "temp/reply_username" | grep -v "gojibox" > "temp/reply_id_username"
  # sed -i "s/\s\+/ /g" temp/reply_id_username
  # echo "" >> temp/reply_id_username

  # echo -n "- twit per baris.. "
  baris=$(cat "temp/reply_id_username" | wc -l)
  max=$(( $baris + 1 ))
  num=1
  # echo "ada $baris baris"

  while [[ $num -lt $max ]]; do
    respon="1"
    line="`sed -n "$num"p "temp/reply_id_username"`"

    twit_id=$(echo "$line" | awk '{print $1}')
    twit_user=$(echo "$line" | awk '{print $2}')
    twit_isi=$(echo "$line" | cut -d " " -f 2-)

    # cek dulu di database replied
    if grep -q "$twit_id" "temp/reply_replied" ; then
      echo "-- id $twit_id $twit_user udah ada di database replied, gak usah direply"
    else
      # echo "-- id $twit_id $twit_user belum ada di database replied, reply lalu masukin"

      # commands?
      reply_command "$twit_isi"

      if [[ "$respon" == "1" ]]; then
        if [[ "$dont" != "1" ]]; then
          pilih_respon
          getJam
          responnya=$(echo "$respon" | sed 's/{target}/'$twit_user'/g')
          echo "[ttytter] : $responnya $emot"
          ttytter -status="$responnya $emot"

        fi
      fi
      # masukin twit_id ke database
      echo "$twit_id" >> "temp/reply_replied"

      sleep 3
    fi

    let num++;
  done

  echo "- done -"
  exit 1
}
