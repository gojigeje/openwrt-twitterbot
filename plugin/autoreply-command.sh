#!/bin/bash
#
# nama plugin : autoreply_command
# deksripsi   : plugin tambahan untuk menentukan sebuah mention merupakan command atau bukan
#               plugin ini dipanggil lewat script autoreply.sh
#

# TODO:
# !stop
# !gombalin
# !ejekin

cekngadimin() {
  # list username admin, pisahkan dengan spasi, lengkap dengan @...
  ngadimin="@gojigeje @gojibuntu"

  if [[ "$ngadimin" == *"$twit_user"* ]]; then
    # echo "$comm_user ada di list ngadimin"
    respon="0"
    isngadimin="1"
  else
    # echo "$comm_user nggak ada di list ngadimin"
    respon="1"
    isngadimin="0"    
  fi
}

autoreply_command() {

  cekngadimin
  udahdibalas="0"
  comm_user="$(echo "$@" | awk '{print $1}')"
  comm_tipe="$(echo "$@" | awk '{print $3}')"
  comm_tipeisi="$(echo "$@" | cut -d " " -f 3-)"
  comm_isi="$(echo "$@" | cut -d " " -f 4-)"

  echo "[autoreply] - comm_user    : $comm_user"
  echo "[autoreply] - comm_tipe    : $comm_tipe"
  echo "[autoreply] - comm_tipeisi : $comm_tipeisi"
  echo "[autoreply] - comm_isi     : $comm_isi"

  # comm_user        : @gojibuntu
  # comm_tipe        : !satu
  # comm_tipeisi     : !satu dua tiga empat lima enam tujuh lapan sembilan 
  # comm_isi         : dua tiga empat lima enam tujuh lapan sembilan


  # ==================================================================================================================
  #  filter commands
  # ==================================================================================================================

  if [[ "$comm_tipe" == "!say" || "$comm_tipe" == "!bilang" ]]; then
    command_say
  elif [[ "$comm_tipe" == "!follow" ]]; then
    command_follow
  elif [[ "$comm_tipe" == "!unfollow" || "$comm_tipe" == "!leave" ]]; then
    command_unfollow
  elif [[ "$comm_tipe" == "!status" ]]; then
    command_status
  elif [[ "$comm_tipe" == "!info" ]]; then
    command_info
  elif [[ "$comm_tipe" == "!ip" ]]; then
    command_ipgue
  elif [[ "$comm_tipe" == "!ping" ]]; then
    command_ping
  elif [[ "$comm_tipe" == "!pong" ]]; then
    command_pong
  elif [[ "$comm_tipe" == "!adsl" ]]; then
    command_adsl
  elif [[ "$comm_tipe" == "!kissanime" ]]; then
    command_kissanime
  else
    respon="1"
  fi

}


# ====================================================================================================================
#  command functions
# ====================================================================================================================

command_say() {
  if [[ "$isngadimin" == "1" ]]; then
    echo "[autoreply] admin $comm_user nyuruh kita bilang $comm_isi"
    twit -s "$comm_isi"
  else
    # echo "[twit] : $comm_user nyuruh2 !say"
    twit -r "$twit_id" -s "oi oi.. $comm_user emangnya elu siapa nyruh2 gue gitu..??"
    udahdibalas="1"
  fi
}

command_follow() {
  if [[ "$isngadimin" == "1" ]]; then

    array_who=( $comm_isi )
    for user in "${array_who[@]}"; do
      if [[ "$user" == @* ]]; then
        target=$(echo "$user" | sed 's/[^a-zA-Z0-9@_]//g')
        # echo "$comm_user nyruh kita follow $target"
        twit -f "$target"
      fi
    done
    twit -r "$twit_id" -s "oke bos $comm_user, sudah ane follow barusan :)"

  else
    # echo "[twit] : $comm_user nyuruh2 !follow"
    twit -r "$twit_id" -s "oi oi.. $comm_user emangnya elu siapa nyruh2 gue follow.. elu aja gak follow gue gitu..! "
    udahdibalas="1"
  fi
}

command_unfollow() {
  if [[ "$isngadimin" == "1" ]]; then
    
    array_who=( $comm_isi )
    for user in "${array_who[@]}"; do
      if [[ "$user" == @* ]]; then
        target=$(echo "$user" | sed 's/[^a-zA-Z0-9@_]//g')
        # echo "$comm_user nyruh kita unfollow $target"
        twit -l "$target"
      fi
    done
    twit -r "$twit_id" -s "oke bos $comm_user, sudah ane unfollow barusan, kalau perlu ane blok tuh :)"

  else
    # echo "[twit] : $comm_user nyuruh2 !unfollow"
    twit -r "$twit_id" -s "oi oi.. $comm_user emangnya elu siapa nyruh2 gue gitu..??"
    udahdibalas="1"
  fi
}

command_status() {
  echo "[autoreply] admin $comm_user nanyain status kita"

  statusnya_array=(
      "bokek akut"
      "bokek"
      "kena kanker (kantong kering)"
      "di-PHP-in"
      "galau kamu php in terus"
      "digantung"
      "galau akut"
      "galau"
      "jomblo 3 bulan"
      "jomblo abadi"
      "jomblo akut"
      "jomblo"
      "menggalau"
      "merana karena jomblo"
      "ngejomblo"
      "susah BAB akhir2 ini"
      "susah boker"
      "mencret"
    )
  statusnya_num=${#statusnya_array[*]}
  statusnya=${statusnya_array[$((RANDOM%statusnya_num))]}

  twit -r "$twit_id" -s "hai $comm_user, status aku tuh saat ini lagi $statusnya kayak majikan aku si @gojigeje ..T_T"
  respon="0"
}

command_info() {
  if [[ "$isngadimin" == "1" ]]; then
    echo "[autoreply] admin $comm_user minta info"
    
    uname -a > "temp/command.info.twit1"
    up=$(uptime)
    echo "Uptime: $up"  >> "temp/command.info.twit1"

    free -mot | awk '
    /Mem/{print "[RAM] Total: " $2 "Mb Used: " $3 "Mb Free: " $4 "Mb"}
    /Swap/{print "[Swap] Total: " $2 "Mb Used: " $3 "Mb Free: " $4 "Mb"}' > "temp/command.info.twit2"

    iplokal=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
    ippublic=$(curl -s http://ipgue.ml/text)

    echo "IP Lokal  : $iplokal" > "temp/command.info.twit3"
    echo "IP Public : $ippublic" >> "temp/command.info.twit3"

    twit -r "$twit_id" -s "Siap bos $comm_user! System Info ane kirim via DM :)"

    twit -u "$comm_user" -d "`cat temp/command.info.twit1`"
    sleep 2
    twit -u "$comm_user" -d "`cat temp/command.info.twit2`"
    sleep 2
    twit -u "$comm_user" -d "`cat temp/command.info.twit3`"
    sleep 2

    # cleanup
    rm temp/command.info.*

  else
    # echo "[twit] : $comm_user nyuruh2 !say"
    twit -r "$twit_id" -s "oi oi.. $comm_user emangnya elu siapa nyruh2 gue gitu..??"
    udahdibalas="1"
  fi
}

command_ipgue() {
  if [[ "$isngadimin" == "1" ]]; then
    echo "[autoreply] admin $comm_user minta info IP Publik"
    
    twit -r "$twit_id" -s "Siap bos $comm_user! Sedang mengambil IP Publik, habis ini ane DM bos.. :)"

    getJam
    ippublic=$(curl -s http://ipgue.ml/text)

    twit -u "$comm_user" -d "[$getjam] IP Publik: $ippublic"

  else
    # echo "[twit] : $comm_user nyuruh2 !say"
    twit -r "$twit_id" -s "oi oi.. $comm_user emangnya elu siapa nyruh2 gue gitu..??"
    udahdibalas="1"
  fi
}

command_ping() {
  echo "[autoreply] [twit] : !ping dari $comm_user"
  twit -r "$twit_id" -s "$comm_user pong!"
  respon="0"
}

command_pong() {
  echo "[autoreply] [twit] : !pong dari $comm_user"
  twit -r "$twit_id" -s "$comm_user pingpong!"
  respon="0"
}

command_adsl() {
  if [[ "$isngadimin" == "1" ]]; then
    echo "[autoreply] admin $comm_user minta info adsl"
    
    twit -r "$twit_id" -s "Siap bos $comm_user! Sedang mengambil info ADSL dari modem, habis ini ane twit.. :)"

    # masukin twit id ke database, lakukan sekarang karena plugin adsl ada exit
    echo "$twit_id $comm_user" >> "temp/reply_replied" 

    # memanggil plugin lain
    twit_adsl_main 

  else
    # echo "[twit] : $comm_user nyuruh2 !say"
    twit -r "$twit_id" -s "oi oi.. $comm_user emangnya elu siapa nyruh2 gue gitu..??"
    udahdibalas="1"
  fi
}

command_kissanime() {
  if [[ "$isngadimin" == "1" ]]; then
    echo "[autoreply] admin $comm_user nyuruh liat kissanime"
    twit -r "$twit_id" -s "Siap bos $comm_user! Sedang mengambil info $comm_isi dari kissanime, habis ini ane twit.. :)"

    echo "$twit_id $comm_user" >> "temp/reply_replied"
    kissanime "$comm_isi"

  else
    # echo "[twit] : $comm_user nyuruh2 !say"
    twit -r "$twit_id" -s "oi oi.. $comm_user emangnya elu siapa nyruh2 gue gitu..??"
    udahdibalas="1"
  fi
}
