#!/bin/bash

aksi_array+=("twit_greeting")

# greeting
# ----------------------------------------------------------------------------------
greeting_cek()
{
  case "$jam" in
    01)
       greet="Sudah malam.. ingin tidur.. tapi ga bisa.. ane kan router -__-"
    ;;
    02)
       greet="@gojigeje kalo tidur jangan ngorok..! ntar hidungmu tambah gede..!"
    ;;
    03)
       greet="pusing liat @gojigeje sejak tadi pecicilan aja di atas kasur.. tidur apa pencak silat??"
    ;;
    04)
       greet="Udah sholat subuh apa belom bos, opo masih mlungker? cc @gojigeje"
    ;;
    05)
       greet="@gojigeje <-- tumben banget pagi-pagi gini dah bangun ni orang?"
    ;;
    06)
       greet="Udah sikat gigi belum nih? bau nafasmu itu loh.. cc @gojigeje"
    ;;
    07)
       greet="Udah mandi bos..? Cuci muka gitu..?? muka elu masih burem tuh @gojigeje"
    ;;
    08)
       greet="Sarapan apa yaa..? (padahal mandi aja belum) ~ @gojigeje dijamin belum mandi ini, pasti.."
    ;;
    09)
       greet="Ayo kerja kerjaaa..!!! (Semangat Mode ON) #membara"
    ;;
    10)
       greet="Masak jam segini udah laper lagi sih bos..??! cc @gojigeje"
    ;;
    11)
       greet="Jam segini kok bawaannya udah ngantuk ya? :("
    ;;
    12)
       greet="Sholat Dzuhur.. terus Tiduuuurrr.. :D #tukangtidur"
    ;;
    13)
       greet="Sudah sholat Dzuhur bos @gojigeje?.. Kok jadi ngantuk ya.. :("
    ;;
    14)
       greet="Jam segini sih paling enak tidur bos.. :D cc @gojigeje"
    ;;
    15)
       greet="Sudah sholat Ashar pa belum ni bos..? cc @gojigeje"
    ;;
    16)
       greet="Ashar-nya udah?.. Perut mulai laper lagi.. -_- #tukangmakan"
    ;;
    17)
       greet="Mandi mandi sono dulu, biar seger dikit.. bau badanmu @gojigeje.. ampuuunnn.."
    ;;
    18)
       greet="Sholat Maghribnya sudah bos..? cc @gojigeje"
    ;;
    19)
       greet="Sholat Isya' udah? Saatnya makan.. :D cc @gojigeje"
    ;;
    20)
       greet="Enaknya belajar apa nonton film ya..? :D ~ router juga perlu belajar.. #pemalas"
    ;;
    21)
       greet="lagi ngerjain apa bos @gojigeje? #penasaran"
    ;;
    22)
       greet="jadi penasaran.. si @gojigeje lagi ngapain ya jam segini..?"
    ;;
    23)
       greet="Belum ngantuk bos? Hwoooaaaahm... >_< #ngantukberat"
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
  greeting_cek
  greeting_hari_jumat

  tweet_status="$greet"
}
