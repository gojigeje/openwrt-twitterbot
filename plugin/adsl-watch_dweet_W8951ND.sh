#!/bin/bash
#
# nama plugin : adsl-watch
# deksripsi   : script monitor adsl status di modem, lalu publish datanya ke dweet.io
#               --> http://dweet.io/follow/gojigeje-adslmlg 
#
# cara pakai  : twit_adsl_dweet
#               panggil dengan crontab, tiap 1 menit misalnya
#
# keterangan  : dicoba dengan modem ADSL merek TP-LINK TD-W8951ND (model bulat)
#

# aksi_array+=("twit_adsl_dweet")

twit_adsl_dweet_getpage() {
  echo "[adsl-dweet] ambil data dari modem.. [$num]"

  # get status page
  curl -s http://USER:PASSWORD@192.168.1.1/status/status_deviceinfo.htm > "$adsltemp"
  sleep 2
  # once more, just to make sure
  curl -s http://USER:PASSWORD@192.168.1.1/status/status_deviceinfo.htm > "$adsltemp"
}

twit_adsl_dweet_parsedata() {
  echo "[adsl-dweet] parse data modem.."

  # parse data
  # http://stackoverflow.com/a/4203663
  # http://stackoverflow.com/a/339941
  cat "$adsltemp" | sed "s/'tabdata'>/'tabdata'>\n/g;s/<[^>]\+>/ /g;s/[ \t]*//$g;s/ //g;s/&nbsp;//g;/^[ \t]*$/d" | tail -n +15 > "$adsltemp.data"

  cpu=$(sed -n 7p "$adsltemp.data" | sed 's/[^0-9].*//')
  mem=$(sed -n 9p "$adsltemp.data"| sed 's/[^0-9].*//')
  modulation=$(sed -n 40p "$adsltemp.data")
  annex=$(sed -n 42p "$adsltemp.data")
  snr1=$(sed -n 46p "$adsltemp.data")
  snr2=$(sed -n 47p "$adsltemp.data" | sed 's/[^0-9.].*//')
  att1=$(sed -n 49p "$adsltemp.data")
  att2=$(sed -n 50p "$adsltemp.data" | sed 's/[^0-9.].*//')
  rate1=$(sed -n 52p "$adsltemp.data")
  rate2=$(sed -n 53p "$adsltemp.data" | sed 's/[^0-9].*//')
  max1=$(sed -n 55p "$adsltemp.data")
  max2=$(sed -n 56p "$adsltemp.data" | sed 's/[^0-9].*//')
}

twit_adsl_dweet_cek() {
  echo "[adsl-dweet] periksa.."

  if [[ $num -gt 2 ]]; then
    echo "[adsl-dweet] giving up.. 3x gagal ambil data dari modem :("
    exit
  else
    if [[ "$cpu" == "" || "$mem" == "" || "$modulation" == "" || "$annex" == "" || "$snr1" == "" || "$snr2" == "" || "$att1" == "" || "$att2" == "" || "$rate1" == "" || "$rate2" == "" || "$max1" == "" || "$max2" == "" ]]; then
      echo "[adsl-dweet] ada data yang kosong.. coba lagi"
      let num++

      twit_adsl_dweet_getpage
      twit_adsl_dweet_parsedata
      twit_adsl_dweet_cek
    fi
  fi
}

twit_adsl_dweet_main() {

  adsltemp="temp/adsl.dweet.temp"
  num=1
  
  twit_adsl_dweet_getpage
  twit_adsl_dweet_parsedata
  twit_adsl_dweet_cek
  
  echo "[adsl-dweet] [cpu:$cpu] [mem:$mem] [modulation:$modulation] [annex:$annex] [snr1:$snr1] [snr2:$snr2] [att1:$att1] [att2:$att2] [rate1:$rate1] [rate2:$rate2] [max1:$max1] [max2:$max2]"
  
  # # post to sparkfun
  # echo -n "[adsl-dweet] post to sparkfun.. "
  # curl -s "http://data.sparkfun.com/input/jqE5OA5O4RhE6w31lb71?private_key=[PRIVATE-KEY]&annex=$annex&att1=$att1&att2=$att2&cpu=$cpu&max1=$max1&max2=$max2&mem=$mem&modulation=$modulation&rate1=$rate1&rate2=$rate2&snr1=$snr1&snr2=$snr2"

  # post to dweet.io
  # uncomment to activate
  echo -n "[adsl-dweet] post to dweet.io.. "
  #curl -s "https://dweet.io/dweet/for/gojigeje-adslmlg-github?&annex=$annex&att1=$att1&att2=$att2&cpu=$cpu&max1=$max1&max2=$max2&mem=$mem&modulation=$modulation&rate1=$rate1&rate2=$rate2&snr1=$snr1&snr2=$snr2"
  echo ""

  # cleanup
  rm temp/adsl.dweet.*

  exit
}
