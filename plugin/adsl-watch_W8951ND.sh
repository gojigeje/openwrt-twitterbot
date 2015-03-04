#!/bin/bash
#
# nama plugin : adsl-watch
# deksripsi   : script monitor adsl status di modem
# 
# cara pakai  : twit_adsl2
#
# keterangan  : dicoba dengan modem ADSL merek TP-LINK TD-W8951ND (model bulat)
#

aksi_array+=("twit_adsl2")

adsltemp="temp/adsl.temp"
num=1

adsl2_getpage() {
  echo "[adsl] ambil data dari modem.. [$num]"

  # get status page
  curl -s http://USER:PASSWORD@192.168.1.1/status/status_deviceinfo.htm > "$adsltemp"
  sleep 2
  # once more, just to make sure
  curl -s http://USER:PASSWORD@192.168.1.1/status/status_deviceinfo.htm > "$adsltemp"
}

adsl2_parsedata() {
  echo "[adsl] parse data modem.."

  # parse data
  # http://stackoverflow.com/a/4203663
  # http://stackoverflow.com/a/339941
  cat "$adsltemp" | sed "s/'tabdata'>/'tabdata'>\n/g;s/<[^>]\+>/ /g;s/[ \t]*//$g;s/ //g;s/&nbsp;//g;/^[ \t]*$/d" | tail -n +15 > "$adsltemp.data"

  cpu=$(sed -n 7p "$adsltemp.data")
  mem=$(sed -n 9p "$adsltemp.data")
  modulation=$(sed -n 40p "$adsltemp.data")
  annex=$(sed -n 42p "$adsltemp.data")
  snr1=$(sed -n 46p "$adsltemp.data")
  snr2=$(sed -n 47p "$adsltemp.data")
  att1=$(sed -n 49p "$adsltemp.data")
  att2=$(sed -n 50p "$adsltemp.data")
  rate1=$(sed -n 52p "$adsltemp.data")
  rate2=$(sed -n 53p "$adsltemp.data")
  max1=$(sed -n 55p "$adsltemp.data")
  max2=$(sed -n 56p "$adsltemp.data")
}

adsl2_cek() {
  echo "[adsl] periksa.."

  if [[ $num -gt 2 ]]; then
    echo "[adsl] giving up.. 3x gagal ambil data dari modem :("
    exit
  else
    if [[ "$cpu" == "" || "$mem" == "" || "$modulation" == "" || "$annex" == "" || "$snr1" == "" || "$snr2" == "" || "$att1" == "" || "$att2" == "" || "$rate1" == "" || "$rate2" == "" || "$max1" == "" || "$max2" == "" ]]; then
      echo "[adsl] ada data yang kosong.. coba lagi"
      let num++

      adsl2_getpage
      adsl2_parsedata
      adsl2_cek
    fi
  fi
}

twit_adsl2_main() {

  adsl2_getpage
  adsl2_parsedata
  adsl2_cek
  
  echo "[adsl-watch]" > "temp/adsl.2.twit"
  echo "[TD-W8951ND][MLG]" >> "temp/adsl.2.twit"
  echo "" >> "temp/adsl.2.twit"
  echo "CPU:$cpu MEM:$mem" >> "temp/adsl.2.twit"
  echo "SNR:$snr1/$snr2" >> "temp/adsl.2.twit"
  echo "LineAtt:$att1/$att2" >> "temp/adsl.2.twit"
  echo "DataRate:$rate1/$rate2" >> "temp/adsl.2.twit"
  echo "MaxRate:$max1/$max2" >> "temp/adsl.2.twit"

  cat "temp/adsl.2.twit"
  
  # tweet
  twit -s "`cat temp/adsl.2.twit`"
  
  # cleanup
  rm temp/adsl.*

  echo -n "[adsl] "
  exit
}
