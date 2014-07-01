#!/bin/bash

aksi_array+=("twit_greeting")

# greeting
# ----------------------------------------------------------------------------------
plihtarget() {

  target_num=${#target_array[*]}
  target=${target_array[$((RANDOM%target_num))]}

  # pasitkan greeting sebelumnya bukan untuk target ini
  entri="plugin_greeting_last"
  if [[ "$plugin_greeting_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      # echo "entri ada tapi kosong, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$target'"/g' "plugin/plugin.conf"
    else
      # echo "entri ga ada, insert"
      echo "$entri=\"$target\"" >> "plugin/plugin.conf"
    fi

  else # cek isinya
    if [[ "$target" != "$plugin_greeting_last" ]]; then
      # echo "isinya nggak sama, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$target'"/g' "plugin/plugin.conf"
    else
      # echo "target sama, pilih lagi [$target]"
      plihtarget
    fi
  fi

}

greeting_cek()
{
  case "$jam" in
    01)
       greet="Sudah malam.. ingin tidur.. tapi ga bisa.. ane kan router -__-"
    ;;
    02)
       greet="$target kalo tidur jangan suka ngorok..! ntar hidungmu tambah gede..!"
    ;;
    03)
       greet="pusing liat $target sejak tadi pecicilan aja di atas kasur.. tidur apa pencak silat??"
    ;;
    04)
       greet="Udah sholat subuh apa belom bos, opo masih mlungker? cc $target"
    ;;
    05)
       greet="$target <-- tumben banget pagi-pagi gini dah bangun ni orang?"
    ;;
    06)
       greet="Udah sikat gigi belum nih? bau nafasmu itu loh.. cc $target.. bikin polusi udara..!"
    ;;
    07)
       greet="Udah mandi bos..? Cuci muka gitu..?? mukanya masih burem dan lungset tuh $target"
    ;;
    08)
       greet="Sarapan apa yaa..? (padahal mandi aja belum) ~ $target dijamin belum mandi ini, pasti.."
    ;;
    09)
       greet="Ayo kerja kerjaaa..!!! (Semangat Mode ON) #membara cc $target"
    ;;
    10)
       greet="Masak jam segini udah laper lagi sih bos..??! cc $target"
    ;;
    11)
       greet="Jam segini kok bawaannya udah ngantuk ya? semangat woy $target..!"
    ;;
    12)
       greet="Sholat Dzuhur.. terus Tiduuuurrr.. :D #tukangtidur cc $target"
    ;;
    13)
       greet="Sudah sholat Dzuhur bos $target?.. Kok jadi ngantuk gini ya.. :("
    ;;
    14)
       greet="Jam segini sih paling enak tidur bos.. :D cc $target"
    ;;
    15)
       greet="Sudah sholat Ashar pa belum ni bos..? cc $target"
    ;;
    16)
       greet="Ashar-nya udah?.. Perut mulai laper lagi.. -_- #tukangmakan kayak si $target"
    ;;
    17)
       greet="Mandi mandi sono dulu, biar seger dikit.. bau badanmu $target.. ampuuunnn.."
    ;;
    18)
       greet="Sholat Maghribnya sudah bos..? cc $target"
    ;;
    19)
       greet="Sholat Isya' udah? Saatnya makan.. :D cc $target"
    ;;
    20)
       greet="Enaknya belajar apa nonton film ya..? :D ~ router ga perlu belajar sih.. #pemalas"
    ;;
    21)
       greet="lagi ngerjain apa ni bos $target? #penasaran"
    ;;
    22)
       greet="jadi penasaran.. si $target lagi ngapain ya jam segini..?"
    ;;
    23)
       greet="Belum ngantuk bos $target? Hwoooaaaahm... >_< #ngantukberat"
    ;;
    *)
       greet="Zzz.. Zzz.. (-_-) Zzz.. Zzz.. #ngorok"
    ;;
  esac
}

greeting_hari_jumat()
{
   case "$hari" in
      # Siap-siap jumatan
      5) #5=jumat
         case "$jam" in
            11 )
               greet="Ayo siap-siap sholat Jumat dulu bos.. cc @gojigeje"
            ;;
            12 )
               greet="Habis Jumatan gini enaknya ya tidur :D"
            ;;
            13 )
               greet="Jumat siang, buat tidur mantap nih :D"
            ;;
         esac
      ;;
   esac 
}

# main method, set tweet_status
twit_greeting_main() {
  plihtarget
  greeting_cek
  greeting_hari_jumat
  getJam
  tweet_status="$greet - $getjam"
}
