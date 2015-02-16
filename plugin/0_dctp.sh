#!/bin/bash

# aksi_array+=("twit_dctp")

# main method
twit_dctp_main() {
  DCTPFILE="temp/dctp.html"
  getJam

  echo -n "[$getjam] Downloading dctp page.."
  if eval "ping -c 1 dctp.ws -w 10 > /dev/null"; then
    date +"%d %b" > $DCTPFILE
    curl -s http://www.dctp.ws/Main.html > $DCTPFILE
    echo " [OK]"
  else
    echo " [ERROR]"
    echo " [PING-TIMEOUT] - Gagal menghubungi dctp.ws!"
    exit 1
  fi

  chapter=$(grep "File [0-9]" "$DCTPFILE" | sed "s/[ \t]*//$g;s/<[^>]\+>/ /g;s/ <span//g" | sed "s/[a-z A-Z]//g" | head -n1 | tr -d '\n\r')
  link=$(grep "sendspace.com" "$DCTPFILE" | sed "s/[ \t]*//$g;s/<[^>]\+>/ /g;s/ <span//g" | head -n1 | cut -d '"' -f2 )
  view=$(grep "[0-9]-Reader" "$DCTPFILE" | grep "www.dctp.ws" | sed "s/^ *.//g" | head -n1 | cut -d '"' -f2)


  # cek entri di config
  entri="plugin_dctp_last"
  if [[ "$plugin_dctp_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      # echo "entri ada tapi kosong, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$chapter'"/g' "plugin/plugin.conf"
    else
      # echo "entri ga ada, insert"
      echo "$entri=\"-\"" >> "plugin/plugin.conf"
    fi    
  fi

  if [[ "$chapter" -gt "$plugin_dctp_last" ]]; then
    # getJam
    status="[DCTP] Update! Det.Conan chapter $chapter udah rilis..! Download: $link ~ Baca: $view ~ cc @gojigeje"
    echo "[ttytter] : $status"
    ttytter -status="$status" -newline

    # echo "isinya nggak sama, replace"
    sed -i 's/'$entri'*.*/'$entri'="'$chapter'"/g' "plugin/plugin.conf"
    
    entri="plugin_dctp_posted"
    sed -i 's/'$entri'*.*/'$entri'="1"/g' "plugin/plugin.conf"
    if [[ "$plugin_dctp_posted" = "" ]]; then
      if grep -q "$entri" "plugin/plugin.conf" ; then
        # echo "entri ada tapi kosong, replace"
        sed -i 's/'$entri'*.*/'$entri'="'$chapter'"/g' "plugin/plugin.conf"
      else
        # echo "entri ga ada, insert"
        echo "$entri=\"1\"" >> "plugin/plugin.conf"
      fi    
    fi

  else

    # cek udah dipost berapa kali
    num="$plugin_dctp_posted"
    entri="plugin_dctp_posted"
    if [[ "$plugin_dctp_posted" = "" ]]; then
      if grep -q "$entri" "plugin/plugin.conf" ; then
        # echo "entri ada tapi kosong, replace"
        sed -i 's/'$entri'*.*/'$entri'="'$num'"/g' "plugin/plugin.conf"
      else
        # echo "entri ga ada, insert"
        echo "$entri=\"$num\"" >> "plugin/plugin.conf"
      fi
    fi

    if [[ $num -lt 3 ]]; then
      # getJam
      status="[DCTP] Update! Det.Conan chapter $chapter udah rilis..! ~ Download: $link ~ Baca: $view ~ cc @gojigeje"
      echo "[ttytter] : $status"
      ttytter -status="$status" -newline

      let num++;
      # echo "isinya nggak sama, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$num'"/g' "plugin/plugin.conf"
    else
      if [[ "$chapter" == "$plugin_dctp_last" ]]; then
        echo "Chapter udah paling baru [$chapter].. dan udah di twit 3x.. gak ngetwit.."
      fi
    fi

  fi

  exit 1
}

