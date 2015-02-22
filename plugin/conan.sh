#!/bin/bash
#
# nama plugin : conan
# deksripsi   : posting episode terbaru serial Detective Conan dari gogoanime.com
# 
# cara pakai  : twit_conan
#
# keterangan  : jalankan via crontab, video conan subbed biasanya rilis tiap hari selasa
#               set crontab tiap hari selasa rabu atau kamis
#

# aksi_array+=("twit_conan")

twit_conan_main() {

  CONANFILE="temp/conan"
  rm temp/conan*
  getJam

  echo -n "[$getjam] Downloading detective conan page.."
  if eval "ping -c 1 gogoanime.com -w 10 > /dev/null"; then
    date +"%d %b" > "$CONANFILE"
    curl -s http://www.gogoanime.com/category/detective-conan > "$CONANFILE"
    echo " [OK]"
  else
    echo " [ERROR]"
    echo " [PING-TIMEOUT] - Gagal menghubungi gogoanime.com!"
    exit 1
  fi

  # getlinks
  grep "http://www.gogoanime.com/detective-conan-episode-" "$CONANFILE" | sed -ne 's/.*\(http[^"]*\).*/\1/p;s/[0-9]*//g' > "$CONANFILE.link"
  # getepisode
  grep "detective-conan-episode-" "$CONANFILE" | sed -ne 's/.*\(http[^"]*\).*/\1/p' | sed 's/[^0-9]*//g' > "$CONANFILE.episode"
  # sandingkan
  paste "$CONANFILE.episode" "$CONANFILE.link" > "$CONANFILE.links"

  # ceklink
  echo "- checking episode.."
  baris=$(cat "$CONANFILE.links" | wc -l)
  max=$(( $baris + 1 ))
  num=1

  while [[ $num -lt $max ]]; do
    link="`sed -n "$num"p "$CONANFILE.links"`"
    conan_eps=$(echo "$link" | awk '{print $1}')
    conan_link=$(echo "$link" | awk '{print $2}')
    
    curl -s "$conan_link" > "$CONANFILE.cek"
    # cek status tiap link
    echo -n "-- checking $conan_link.. "

    # belum rilis
    if grep -q "/images/goodmeme.jpg" "$CONANFILE.cek" ; then
      echo "[belum rilis]"
    else

      # masih raw
      if grep -q "/images/raw2.png" "$CONANFILE.cek" ; then
        echo "[masih raw]"
      else
        echo "[udah rilis]"
        terbaru="$conan_eps"
        break
      fi

    fi

    let num++;
  done
  echo "- episode terbaru: $terbaru"

  # cek entri di config
  entri="plugin_conan_last"
  if [[ "$plugin_conan_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      echo "entri ada tapi kosong, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$terbaru'"/g' "plugin/plugin.conf"
    else
      echo "entri ga ada, insert"
      echo "$entri=\"0\"" >> "plugin/plugin.conf"
      plugin_conan_last="0"
    fi    
  fi

  if [[ "$terbaru" -gt "$plugin_conan_last" ]]; then
    # getJam
    status="[gogoanime] Update! Det.Conan Anime episode $terbaru udah rilis..! ~ Liat dimari: $conan_link ~ cc @gojigeje"

    echo "isinya nggak sama, replace"
    sed -i 's/'$entri'*.*/'$entri'="'$terbaru'"/g' "plugin/plugin.conf"
    
    entri="plugin_conan_posted"
    sed -i 's/'$entri'*.*/'$entri'="1"/g' "plugin/plugin.conf"
    if [[ "$plugin_conan_posted" = "" ]]; then
      if grep -q "$entri" "plugin/plugin.conf" ; then
        echo "entri ada tapi kosong, replace"
        sed -i 's/'$entri'*.*/'$entri'="'$terbaru'"/g' "plugin/plugin.conf"
      else
        echo "entri ga ada, insert"
        echo "$entri=\"1\"" >> "plugin/plugin.conf"
      fi    
    fi

  else

    # cek udah dipost berapa kali
    num="$plugin_conan_posted"
    entri="plugin_conan_posted"
    if [[ "$plugin_conan_posted" = "" ]]; then
      if grep -q "$entri" "plugin/plugin.conf" ; then
        echo "entri ada tapi kosong, replace"
        sed -i 's/'$entri'*.*/'$entri'="'$num'"/g' "plugin/plugin.conf"
      else
        echo "entri ga ada, insert"
        echo "$entri=\"$num\"" >> "plugin/plugin.conf"
      fi
    fi

    if [[ $num -lt 2 ]]; then
      # getJam
      status="[gogoanime] Update! Det.Conan Anime episode $terbaru udah rilis..! ~ Liat dimari: $conan_link ~ cc @gojigeje"

      let num++;
      echo "isinya nggak sama, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$num'"/g' "plugin/plugin.conf"
    else
      if [[ "$terbaru" == "$plugin_conan_last" ]]; then
        echo "- Episode udah paling baru [$terbaru].. dan udah di twit 2x.. gak ngetwit.."
      fi
    fi

  fi

  # tweet
  echo "[twit] $status"
  twit -s "$status"

  echo "- done -"
  exit 1
}

