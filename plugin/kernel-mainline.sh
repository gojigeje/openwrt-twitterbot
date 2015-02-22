#!/bin/bash
#
# nama plugin : kernel-mainline
# deksripsi   : posting kernel mainline ubuntu versi terbaru (stable) ke twitter
# 
# cara pakai  : twit_kernel
#
# keterangan  : data diambil dari http://kernel.ubuntu.com/~kernel-ppa/mainline/
#               ditampilkan versi stable saja.
#

# aksi_array+=("twit_kernel")

# main method
twit_kernel_main() {
  LISTFILE="temp/kernel_lists"
  getJam

  echo -n "[$getjam] Updating kernel list.."
  if eval "ping -c 1 kernel.ubuntu.com -w 10 > /dev/null"; then
    date +"%d %b" > $LISTFILE
    curl --cacert "$certificate" -A "$ua" -s http://kernel.ubuntu.com/~kernel-ppa/mainline/ | sed 's/<[^>]\+>/ /g' | sed "s/[ \t]*//$g" | grep "v[0-9]" | cut -d " " -f1 | tr / " " >> $LISTFILE
    echo " [OK]"
  else
    echo " [ERROR]"
    echo " [PING-TIMEOUT] - Gagal menghubungi kernel.ubuntu.com!"
    exit 1
  fi

  # ambil versi
  STABLE=$(grep -v 'rc[0-9]' "$LISTFILE" | tail -n 1 | cut -d " " -f1)
  # STABLE="v3.14.5-utopic"
  LASTRC=$(grep 'rc[0-9]' "$LISTFILE" | tail -n 1 | cut -d " " -f1)

  # cek entri di config
  entri="plugin_kernel_stable"
  if [[ "$plugin_kernel_stable" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      # echo "entri ada tapi kosong, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$STABLE'"/g' "plugin/plugin.conf"
    else
      # echo "entri ga ada, insert"
      echo "$entri=\"-\"" >> "plugin/plugin.conf"
    fi    
  fi

  if [[ "$STABLE" != "$plugin_kernel_stable" ]]; then
    # getJam
    status="[kernel-watch] UPDATE Kernel Ubuntu terbaru! (stable) $STABLE ~ donlot dimari --> http://kernel.ubuntu.com/~kernel-ppa/mainline/$STABLE cc @gojigeje"
    echo "[twit] : $status"
    twit -s "$status"

    # echo "isinya nggak sama, replace"
    sed -i 's/'$entri'*.*/'$entri'="'$STABLE'"/g' "plugin/plugin.conf"
    
    entri="plugin_kernel_posted"
    if [[ "$plugin_kernel_posted" = "" ]]; then
      if grep -q "$entri" "plugin/plugin.conf" ; then
        # echo "entri ada tapi kosong, replace"
        sed -i 's/'$entri'*.*/'$entri'="'$STABLE'"/g' "plugin/plugin.conf"
      else
        # echo "entri ga ada, insert"
        echo "$entri=\"1\"" >> "plugin/plugin.conf"
      fi    
    fi

  else

    # cek udah dipost berapa kali
    num="$plugin_kernel_posted"
    entri="plugin_kernel_posted"
    if [[ "$plugin_kernel_posted" = "" ]]; then
      if grep -q "$entri" "plugin/plugin.conf" ; then
        # echo "entri ada tapi kosong, replace"
        sed -i 's/'$entri'*.*/'$entri'="'$num'"/g' "plugin/plugin.conf"
      else
        # echo "entri ga ada, insert"
        echo "$entri=\"$num\"" >> "plugin/plugin.conf"
      fi
    fi

    if [[ $num -lt 3 ]]; then
      getJam
      status="[kernel-watch] UPDATE Kernel Ubuntu terbaru! (stable) $STABLE ~ donlot dimari --> http://kernel.ubuntu.com/~kernel-ppa/mainline/$num cc @gojigeje ~ $getjam"
      echo "[twit] : $status"
      twit -s "$status"

      let num++;
      # echo "isinya nggak sama, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$num'"/g' "plugin/plugin.conf"
    fi

  fi

  echo "- done -"
  exit 1
}

