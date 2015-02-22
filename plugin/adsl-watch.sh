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

adsltemp="temp/adsl.temp"

twit_adsl_main() {

  # get status page
  curl -s http://USER:PASSWORD@192.168.1.1/status/status_deviceinfo.htm > "$adsltemp"
  sleep 2
  # once more, just to make sure
  curl -s http://USER:PASSWORD@192.168.1.1/status/status_deviceinfo.htm > "$adsltemp"

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

  tweet_status="[adsl-watch] $modulation $annex ~ SNR:$snr1/$snr2 ~ LineAttenuation:$att1/$att2 ~ DataRate:$rate1/$rate2 ~ MaxRate:$max1/$max2"
  echo "[twit] $tweet_status"
  
  # cleanup
  rm temp/adsl.*
  
}
