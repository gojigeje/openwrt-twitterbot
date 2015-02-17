#!/bin/bash

aksi_array+=("twit_ejek")

twit_ejek_pilihtarget() {
  ejek_num=${#target_array[*]}
  ejek_num_max=$(( ejek_num - 1 ))

  # cek entri di config
  entri="plugin_ejek_last"
  if [[ "$plugin_ejek_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      sed -i 's/'$entri'*.*/'$entri'="0"/g' "plugin/plugin.conf"
    else
      echo "$entri=\"0\"" >> "plugin/plugin.conf"
    fi
    urutan="0"
    
  else # cek isinya
    if [[ "$plugin_ejek_last" -eq "$ejek_num_max" ]]; then
      urutan="0"
    else
      urutan=$(( plugin_ejek_last + 1 ))
    fi
    sed -i 's/'$entri'*.*/'$entri'='\"$urutan\"'/g' "plugin/plugin.conf"

  fi

  target=${target_array[$urutan]}
}

# main method
twit_ejek_main() {
  
  twit_ejek_pilihtarget

  peringatan_array=(
      "harap waspada.."
      "hot newsss.."
      "rek waspadalah.."
      "hati-hati.."
      "ati-ati.."
      "rek ati-ati.."
      "ati-ati rek.."
      "ane berani jamin.."
      "hati-hati rek.."
      "ane baru tau.."
      "rek hati-hati.."
      "waspadalah rek.."
      "waspadalah.."
      "ane udah lihat sendiri.."
      "ane berani sumpah.."
      "ane udah buktiin.."
      "kamfretttt..."
      "wasyemmm..."
    )
  peringatan_num=${#peringatan_array[*]}
  peringatan=${peringatan_array[$((RANDOM%peringatan_num))]}

  ejekan_array=(
      "udah 3 hari ga mandi.. sampe banyak lalat berputar-putar di atas kepalanya.."
      "suka menggigit.. bantal, kasur, sendal, tembok semua digigit ama dia.."
      "spesies langka, hampir punah.. baiknya dijaga.. masukin cagar alam.."
      "kalo tidur suka ngorok, dan ngoroknya ampunnn.. kerasnya kayak speaker mesjid.."
      "kalo ngupil, upilnya suka ditaroh sembarangan.."
      "suka kentut sembarangan.. sumpah ane malu pas dia kentut di angkot tadi.."
      "ga pernah gosok gigi.."
      "ada gejala-gejala maho.."
      "upilnya banyak.."
      "maho sejati #terbukti.. "
      "kalo deket cewek matanya suka lirak-lirik.."
      "super maho.. dan dia nganggep super itu kayak di superhero gitu.. dan dia bangga.."
      "suka ngamuk-ngamuk kalo lagi marah.."
      "lagi bokek, udah 3 hari cuma makan mie instan.."
      "obatnya kayaknya mau habis.. sandal aku baru habis dimakan sama dia.."
      "kalo marah suka banting-banting apa aja yang ada di jangkauan dia.."
      "kentutnya super bau.. sekali kentut orang serumah KO semua.."
      "super banyak makannya, 3 piring bisa disikat abis.."
      "ga pernah mandi.. mandi cuma setaun sekali pas lebaran.."
      "suka kentut.. dan kentutnya superrrrr bau.."
      "suka lama-lama di kamar mandi.. ga tau ngapain di dalam.. tidur kayaknya.."
      "menganggap dirinya superhero.. suka loncat + lari-lari pake baju berjubah gitu.."
      "suka lirak-lirik cewek umur 60 tahun ke atas.. selamatkan nenek kamu.."
      "kalo beol selalu lupa disiram.. gue korbannya.."
      "bulu keteknya panjang-panjang.."
      "kalo tidur ngileran.."
      "kalo malam suka ngep*t.. ane yang biasa jagain lilinnya.."
      "suka ngupil.. ni sekarang lagi asyik ngupil dia.."
      "udelnya bodong.. kayak sumur.."
    )
  ejekan_num=${#ejekan_array[*]}
  ejekan=${ejekan_array[$((RANDOM%ejekan_num))]}  

  # set tweet_status
  tweet_status="$target <-- $peringatan! ternyata ni orang $ejekan!!"
}

