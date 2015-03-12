#!/bin/bash
#
# nama plugin : adsl-restarter
# deksripsi   : script untuk memonitor nilai SNR modem, jika nilai SNR di bawah
#               nilai batas yang ditentukan, maka script akan mencoba mereload
#               koneksi ADSL
# 
# cara pakai  : twit_adsl_restarter
#
# keterangan  : dicoba dengan modem ADSL merek TP-LINK TD-W8951ND (model bulat)
#

aksi_array+=("twit_adsl2")

adsl_restarter_getpage() {
  echo "[adsl-restarter] ambil data dari modem.. [$num]"

  # get status page
  curl -s http://USER:PASSWORD@192.168.1.1/status/status_deviceinfo.htm > "$adsltemp"
  sleep 2
  # once more, just to make sure
  curl -s http://USER:PASSWORD@192.168.1.1/status/status_deviceinfo.htm > "$adsltemp"
}

adsl_restarter_parsedata() {
  echo "[adsl-restarter] parse data modem.."

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

adsl_restarter_cek() {
  echo "[adsl-restarter] periksa.."

  if [[ $num -gt 2 ]]; then
    echo "[adsl-restarter] giving up.. 3x gagal ambil data dari modem :("
    exit
  else
    if [[ "$cpu" == "" || "$mem" == "" || "$modulation" == "" || "$annex" == "" || "$snr1" == "" || "$snr2" == "" || "$att1" == "" || "$att2" == "" || "$rate1" == "" || "$rate2" == "" || "$max1" == "" || "$max2" == "" ]]; then
      echo "[adsl-restarter] ada data yang kosong.. coba lagi"
      let num++

      adsl_restarter_getpage
      adsl_restarter_parsedata
      adsl_restarter_cek
    fi
  fi

  # cek snr1 value (biasanya download speed, makin kecil makin lemot, bahkan putus)
  # kita batasi minimal 10, di bawah itu langsung reload ADSL
  lemot=$(echo "$snr1<10" | bc) # http://stackoverflow.com/a/11541699

}

twit_adsl_restarter_main() {

  adsltemp="temp/adsl.temp"
  num=1
  
  adsl_restarter_getpage
  adsl_restarter_parsedata
  adsl_restarter_cek
  
  if [[ $lemot -gt 0 ]]; then
    # kita coba untuk ngetwit dulu, entah bisa terkirim atau gak..
    twit -s "[adsl-restarter] [TD-W8951ND/MLG] Koneksi ADSL lagi super lemot (SNR:$snr1). Ane reload dulu modemnya, permisi ya bos @gojigeje"

    echo "[adsl-restarter] nilai SNR ADSL < 10 ($snr1, lemot), reload koneksi ADSL.."

    curl -d ModulationType="Auto Sync-Up" -d AnnexTypeA="ANNEX A/I/J/L/M" -d adslcfgBitswapEnableCheck="on" -d adslcfgSRAEnableCheck="on" -d adsl_opmode_apply="SAVE" http://USER:PASSWORD@192.168.1.1/Forms/adv_adsl_1
    sleep 1
    
    echo "[adsl-restarter] mereload koneksi ADSL.."
    # coba sekali lagi, biar mantep
    curl -d ModulationType="Auto Sync-Up" -d AnnexTypeA="ANNEX A/I/J/L/M" -d adslcfgBitswapEnableCheck="on" -d adslcfgSRAEnableCheck="on" -d adsl_opmode_apply="SAVE" http://USER:PASSWORD@192.168.1.1/Forms/adv_adsl_1

    echo "[adsl-restarter] koneksi ADSL berhasil direload.."

  else
    echo "[adsl-restarter] nilai SNR ADSL > 10 ($snr1, normal) exit.."
  fi

  # cleanup
  rm temp/adsl.*

  exit
}
