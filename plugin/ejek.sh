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
      "ane baru tau.."
      "ane berani jamin.."
      "ane berani sumpah.."
      "ane udah buktiin.."
      "ane udah lihat sendiri.."
      "ati-ati rek.."
      "ati-ati.."
      "harap waspada.."
      "hati-hati rek.."
      "hati-hati.."
      "rek ati-ati.."
      "rek hati-hati.."
      "rek waspadalah.."
      "hot newsss.."
      "waspadalah rek.."
      "waspadalah.."
    )
  peringatan_num=${#peringatan_array[*]}
  peringatan=${peringatan_array[$((RANDOM%peringatan_num))]}

  ejekan_array=(
      "ada gejala-gejala maho.."
      "super banyak makannya, 3 piring bisa abis.."
      "ga pernah gosok gigi.."
      "bulu keteknya panjang-panjang.."
      "ga pernah mandi.. mandi cuma setaun sekali pas lebaran.."
      "kalo beol selalu lupa disiram.. gue korbannya.."
      "kalo deket cewek matanya suka lirak-lirik.."
      "kalo malam suka ngep*t.. ane yang biasa jagain lilinnya.."
      "kalo marah suka banting-banting apa aja yang ada di jangkauan dia.."
      "kalo tidur suka ngorok, dan ngoroknya ampunnn.. kerasnya kayak pake speaker musholla.."
      "kentutnya super bau.. sekali kentut orang serumah KO semua.."
      "lagi bokek, udah 3 hari cuma makan mie instan.."
      "maho sejati #terbukti.. "
      "super maho.. dan dia nganggap super itu kayak di superhero gitu.. dan dia bangga.."
      "menganggap dirinya superhero.. suka loncat + lari-lari pake baju berjubah gitu.."
      "obatnya kayaknya mau habis.. sandal aku baru habis dimakan sama dia.."
      "spesies langka, hampir punah.. baiknya dijaga.. masukin cagar alam.."
      "suka kentut sembarangan.. sumpah ane malu pas dia kentut di angkot tadi.."
      "suka kentut.. dan kentutnya superrrrr bau.."
      "suka lama-lama di kamar mandi.. ga tau ngapain di dalam.. tidur kayaknya.."
      "suka lirak-lirik cewek umur 60 tahun ke atas.. selamatkan nenek kamu.."
      "suka menggigit.. bantal, kasur, sendal, tembok semua digigit ama dia.."
      "suka ngamuk-ngamuk kalo lagi marah.."
      "suka ngupil.. ni sekarang lagi asyik ngupil dia.."
      "kalo ngupil, upilnya suka ditaroh sembarangan.."
      "udah 3 hari ga mandi.. sampe banyak lalat berputar-putar di atas kepalanya.."
      "udelnya bodong.. kayak sumur.."
      "upilnya banyak.."
      "kalo tidur ngileran.."
    )
  ejekan_num=${#ejekan_array[*]}
  ejekan=${ejekan_array[$((RANDOM%ejekan_num))]}  

  # set tweet_status
  tweet_status="$target <-- $peringatan! ternyata orang ini $ejekan!!"
}
