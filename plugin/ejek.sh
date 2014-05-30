#!/bin/bash

aksi_array+=("twit_ejek")

twit_ejek_pilihtarget() {
  target_num=${#target_array[*]}
  target=${target_array[$((RANDOM%target_num))]}

  # pasitkan ejekan sebelumnya bukan untuk target ini
  entri="plugin_ejek_last"
  if [[ "$plugin_ejek_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      # echo "entri ada tapi kosong, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$target'"/g' "plugin/plugin.conf"
    else
      # echo "entri ga ada, insert"
      echo "$entri=\"$target\"" >> "plugin/plugin.conf"
    fi

  else # cek isinya
    if [[ "$target" != "$plugin_ejek_last" ]]; then
      # echo "isinya nggak sama, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$target'"/g' "plugin/plugin.conf"
    else
      # echo "target sama, pilih lagi [$target]"
      twit_ejek_pilihtarget
    fi
  fi
}

# main method
twit_ejek_main() {
  target_array=(
      "@afandie5"
      "@aftaonline"
      "@BimaFikry"
      "@blu3f4lc0n"
      "@ekosuhartono_"
      "@Galih_Gundul"
      "@gojigeje"
      "@mang_panga"
      "@Marsha_Say"
      "@muvidm"
      "@MuzanRizqy"
      "@pogal_666"
      "@putrinawa"
      "@Ressaniaa"
      "@RezaTedjoe"
      "@rikza7x"
      "@TegarSwasono"
      "@ulinzulfa"
      "@yudhasatyaap"
      "@yunushadi"
    )
  twit_ejek_pilihtarget

  peringatan_array=(
      "ane baru tau"
      "ane berani jamin"
      "ane berani sumpah"
      "ane udah buktiin"
      "ane udah lihat sendiri"
      "ati-ati rek"
      "ati-ati"
      "harap waspada"
      "hati-hati rek"
      "hati-hati"
      "rek ati-ati"
      "rek hati-hati"
      "rek waspadalah"
      "tolong waspada"
      "waspadalah rek"
      "waspadalah"
    )
  peringatan_num=${#peringatan_array[*]}
  peringatan=${peringatan_array[$((RANDOM%peringatan_num))]}

  ejekan_array=(
      "ada gejala maho"
      "banyak makannya"
      "belum gosok gigi"
      "bulu keteknya panjang"
      "ga pernah mandi"
      "kalo beol selalu lupa disiram"
      "kalo deket cewek suka lirak-lirik"
      "kalo malam suka ngep*t"
      "kalo marah suka banting kursi"
      "kalo tidur suka ngorok"
      "kentutnya super bau"
      "lagi bokek, udah 3 hari cuma makan mie instan"
      "maho sejati #terbukti"
      "maho"
      "menganggap dirinya superhero"
      "obatnya mau habis"
      "spesies langka, hampir punah.. tolong dijaga"
      "suka kentut sembarangan"
      "suka kentut"
      "suka lama-lama di kamar mandi"
      "suka lirak-lirik cewek"
      "suka menggigit"
      "suka ngamuk kalo marah"
      "suka ngupil"
      "udah 3 hari ga mandi"
      "udelnya bodong"
      "upilnya banyak"
    )
  ejekan_num=${#ejekan_array[*]}
  ejekan=${ejekan_array[$((RANDOM%ejekan_num))]}  

  # set tweet_status
  tweet_status="$target <-- $peringatan! ternyata orang ini $ejekan!!"
}
