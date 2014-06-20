#!/bin/bash

# !say
# !follow
# !unfollow !leave

# !stop
# !gombalin
# !ejekin

ngadimin="@gojigeje @gojibuntu"

cekngadimin() {
  if [[ "$ngadimin" == *"$twit_user"* ]]; then
    # echo "$comm_user ada di list ngadimin"
    respon="0"
  else
    # echo "$comm_user nggak ada di list ngadimin"
    respon="1"
  fi
}

bilang() {
  # echo "[bilang]: $@"
  ttytter -status="$@"
}


reply_command() {

  cekngadimin
  dont="0"
  comm_user="$(echo "$@" | awk '{print $1}')"
  comm_tipe="$(echo "$@" | awk '{print $3}')"
  comm_tipeisi="$(echo "$@" | cut -d " " -f 3-)"
  comm_isi="$(echo "$@" | cut -d " " -f 4-)"

  if [[ "$comm_tipe" == "!say" ]]; then
    do_say
  fi

  if [[ "$comm_tipe" == "!follow" ]]; then
    do_follow
  fi
  
  if [[ "$comm_tipe" == "!unfollow" || "$comm_tipe" == "!leave" ]]; then
    do_unfollow
  fi

  # quick fix, ntar dibenahin lagi
  if [[ "$comm_tipeisi" != *"!say"* && "$comm_tipeisi" != *"!follow"* && "$comm_tipeisi" != *"!unfollow"* && "$comm_tipeisi" != *"!leave"* ]]; then
    respon="1"
  fi

}

do_say() {
  if [[ "$respon" == "0" ]]; then
    echo "[ttytter] : $comm_user nyuruh kita bilang $comm_isi"
    bilang "$comm_isi"
  else
    dont="1"
    # echo "[ttytter] : $comm_user nyuruh2 !say"
  fi
}

do_follow() {
  if [[ "$respon" == "0" ]]; then

    array_who=( $comm_isi )
    for user in "${array_who[@]}"; do
      if [[ "$user" == @* ]]; then
        target=$(echo "$user" | sed 's/[^a-zA-Z0-9@_]//g')
        # echo "$comm_user nyruh kita follow $target"
        ttytter -runcommand="/follow $target"
      fi
    done
    bilang "oke gan $comm_user, sudah difollow :)"

  else
    dont="1"
    # echo "[ttytter] : $comm_user nyuruh2 !follow"
  fi
}

do_unfollow() {
  if [[ "$respon" == "0" ]]; then
    
    array_who=( $comm_isi )
    for user in "${array_who[@]}"; do
      if [[ "$user" == @* ]]; then
        target=$(echo "$user" | sed 's/[^a-zA-Z0-9@_]//g')
        # echo "$comm_user nyruh kita unfollow $target"
        ttytter -runcommand="/unfollow $target"
      fi
    done
    bilang "oke gan $comm_user, sudah diunfollow :)"

  else
    dont="1"
    echo "[ttytter] : $comm_user nyuruh2 !unfollow"
  fi
}
