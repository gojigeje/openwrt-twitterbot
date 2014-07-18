#!/bin/bash

# aksi_array+=("twit_cuaca")

# main method
twit_cuaca_main() {
  mkdir -p "temp"

  if [[ ! -f "temp/cuaca_hariini_$tanggal$bulan$tahun.xml" ]]; then
    rm temp/cuaca_*
    wget "http://data.bmkg.go.id/propinsi_16_1.xml" -O "temp/cuaca_hariini_$tanggal$bulan$tahun.xml" -q
    # format
    tr -d '\n\r' < "temp/cuaca_hariini_$tanggal$bulan$tahun.xml" > "temp/cuaca_hariini"
    sed -i 's/<Mulai>/\n&/g;s/<MulaiPukul>/\n&/g;s/<Sampai>/\n&/g;s/<SampaiPukul>/\n&/g;s/<\/Tanggal>/\n&/g;s/<Row>/\n&/g;s/<Peringatan>/\n&/g;' "temp/cuaca_hariini"
  else
    if [[ ! -f "temp/cuaca_hariini" ]]; then
      tr -d '\n\r' < "temp/cuaca_hariini_$tanggal$bulan$tahun.xml" > "temp/cuaca_hariini"
      sed -i 's/<Mulai>/\n&/g;s/<MulaiPukul>/\n&/g;s/<Sampai>/\n&/g;s/<SampaiPukul>/\n&/g;s/<\/Tanggal>/\n&/g;s/<Row>/\n&/g;s/<Peringatan>/\n&/g;' "temp/cuaca_hariini"
    fi
  fi

  if [[ ! -f "temp/cuaca_besok_$tanggal$bulan$tahun.xml" ]]; then
    wget "http://data.bmkg.go.id/propinsi_16_2.xml" -O "temp/cuaca_besok_$tanggal$bulan$tahun.xml" -q

    tr -d '\n\r' < "temp/cuaca_besok_$tanggal$bulan$tahun.xml" > "temp/cuaca_besok"
    sed -i 's/<Mulai>/\n&/g;s/<MulaiPukul>/\n&/g;s/<Sampai>/\n&/g;s/<SampaiPukul>/\n&/g;s/<\/Tanggal>/\n&/g;s/<Row>/\n&/g;s/<Peringatan>/\n&/g;' "temp/cuaca_besok"
  else
    if [[ ! -f "temp/cuaca_besok" ]]; then
      tr -d '\n\r' < "temp/cuaca_besok_$tanggal$bulan$tahun.xml" > "temp/cuaca_besok"
      sed -i 's/<Mulai>/\n&/g;s/<MulaiPukul>/\n&/g;s/<Sampai>/\n&/g;s/<SampaiPukul>/\n&/g;s/<\/Tanggal>/\n&/g;s/<Row>/\n&/g;s/<Peringatan>/\n&/g;' "temp/cuaca_besok"
    fi
  fi

  if [[ ! -z "$1" ]]; then
    hariini_cuaca=$(grep -i "$1" "temp/cuaca_hariini" | sed -e 's,.*<Cuaca>\([^<]*\)</Cuaca>.*,\1,g' | head -n 1)
    hariini_suhumin=$(grep -i "$1" "temp/cuaca_hariini" | sed -e 's,.*<SuhuMin>\([^<]*\)</SuhuMin>.*,\1,g' | head -n 1)
    hariini_suhumax=$(grep -i "$1" "temp/cuaca_hariini" | sed -e 's,.*<SuhuMax>\([^<]*\)</SuhuMax>.*,\1,g' | head -n 1)
    hariini_anginkec=$(grep -i "$1" "temp/cuaca_hariini" | sed -e 's,.*<KecepatanAngin>\([^<]*\)</KecepatanAngin>.*,\1,g' | head -n 1)
    hariini_anginarah=$(grep -i "$1" "temp/cuaca_hariini" | sed -e 's,.*<ArahAngin>\([^<]*\)</ArahAngin>.*,\1,g' | head -n 1)

    besok_cuaca=$(grep -i "$1" "temp/cuaca_besok" | sed -e 's,.*<Cuaca>\([^<]*\)</Cuaca>.*,\1,g' | head -n 1)
    besok_suhumin=$(grep -i "$1" "temp/cuaca_besok" | sed -e 's,.*<SuhuMin>\([^<]*\)</SuhuMin>.*,\1,g' | head -n 1)
    besok_suhumax=$(grep -i "$1" "temp/cuaca_besok" | sed -e 's,.*<SuhuMax>\([^<]*\)</SuhuMax>.*,\1,g' | head -n 1)
    besok_anginkec=$(grep -i "$1" "temp/cuaca_besok" | sed -e 's,.*<KecepatanAngin>\([^<]*\)</KecepatanAngin>.*,\1,g' | head -n 1)
    besok_anginarah=$(grep -i "$1" "temp/cuaca_besok" | sed -e 's,.*<ArahAngin>\([^<]*\)</ArahAngin>.*,\1,g' | head -n 1)

    if [[ "$hariini_cuaca" == "-" || "$hariini_suhumin" == "-" || "$hariini_suhumax" == "-" || "$hariini_anginkec" == "-" || "$hariini_anginarah" == "-" || -z "$hariini_cuaca" || -z "$hariini_suhumin" || -z "$hariini_suhumax" || -z "$hariini_anginkec" || -z "$hariini_anginarah" ]]; then
      echo "data tidak lengkap, exit"
      rm temp/cuaca_*
      exit 1
    else
      tweet_status="[BMKG] Cuaca $1 hari ini: $hariini_cuaca ~ $hariini_suhumin-$hariini_suhumax ºC ~ angin $hariini_anginkec km/h ke $hariini_anginarah // kalo besok: $besok_cuaca"
    fi
  else
    echo "parameter kurang: Kota"
    exit 1
  fi

  # cek entri di plugin
  entri="plugin_cuaca_last"
  if [[ "$plugin_cuaca_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      # echo "entri ada tapi kosong, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$1'"/g' "plugin/plugin.conf"
    else
      # echo "entri ga ada, insert"
      echo "$entri=\"$1\"" >> "plugin/plugin.conf"
    fi

  else # cek isinya
    if [[ "$1" != "$plugin_cuaca_last" ]]; then
      # echo "isinya nggak sama, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$1'"/g' "plugin/plugin.conf"
    fi
  fi
  
}
