#!/bin/bash
#
# nama plugin : adsl-watch
# deksripsi   : script monitor adsl status di modem
# 
# cara pakai  : twit_adsl
#
# keterangan  : dicoba dengan modem ADSL merek TP-LINK TD-W8951ND
#

aksi_array+=("twit_adsl")

adsl_getpage() {
  echo "[adsl] ambil data dari modem.. [$num]"

  # get status page
  curl -s http://USER:PASSWORD@192.168.1.1/status/status_deviceinfo.htm > "$adsltemp"
  sleep 2
  # once more, just to make sure
  curl -s http://USER:PASSWORD@192.168.1.1/status/status_deviceinfo.htm > "$adsltemp"
}

adsl_parsedata() {
  echo "[adsl] parse data modem.."

  # parse data
  # http://stackoverflow.com/a/4203663
  # http://stackoverflow.com/a/339941
  cat "$adsltemp" | sed "s/'tabdata'>/'tabdata'>\n/g;s/<[^>]\+>/ /g;s/[ \t]*//$g;s/ //g;s/&nbsp;//g;/^[ \t]*$/d" | tail -n +15 > "$adsltemp.data"

  modulation=$(sed -n 36p "$adsltemp.data")
  annex=$(sed -n 38p "$adsltemp.data")
  snr1=$(sed -n 42p "$adsltemp.data")
  snr2=$(sed -n 43p "$adsltemp.data")
  att1=$(sed -n 45p "$adsltemp.data")
  att2=$(sed -n 46p "$adsltemp.data")
  rate1=$(sed -n 48p "$adsltemp.data")
  rate2=$(sed -n 49p "$adsltemp.data")
  max1=$(sed -n 51p "$adsltemp.data")
  max2=$(sed -n 52p "$adsltemp.data")
}

adsl_cek() {
  echo "[adsl] periksa.."

  if [[ $num -gt 2 ]]; then
    echo "[adsl] giving up.. 3x gagal ambil data dari modem :("
    exit
  else
    if [[ "$modulation" == "" || "$annex" == "" || "$snr1" == "" || "$snr2" == "" || "$att1" == "" || "$att2" == "" || "$rate1" == "" || "$rate2" == "" || "$max1" == "" || "$max2" == "" ]]; then
      echo "[adsl] ada data yang kosong.. coba lagi"
      let num++

      adsl_getpage
      adsl_parsedata
      adsl_cek
    fi
  fi
}

twit_adsl_main() {
  
  adsltemp="temp/adsl.temp"
  num=1

  adsl_getpage
  adsl_parsedata
  adsl_cek

  echo "[adsl-watch]" > "temp/adsl.twit"
  echo "[TD-W8951ND][TAG]" >> "temp/adsl.twit"
  echo "" >> "temp/adsl.twit"
  echo "$modulation $annex" >> "temp/adsl.twit"
  echo "SNR:$snr1/$snr2" >> "temp/adsl.twit"
  echo "LineAtt:$att1/$att2" >> "temp/adsl.twit"
  echo "DataRate:$rate1/$rate2" >> "temp/adsl.twit"
  echo "MaxRate:$max1/$max2" >> "temp/adsl.twit"

  cat "temp/adsl.twit"
  
  # tweet
  twit -s "`cat temp/adsl.twit`"

  # cleanup
  rm temp/adsl.*

  exit
}
