#!/bin/bash

#aksi_array+=("twit_ramadhan_greet")

# greeting
# ----------------------------------------------------------------------------------
plihtarget_ramadhan() {
  
  target_num=${#target_array[*]}
  target_num_max=$(( target_num - 1 ))

  # cek entri di config
  entri="plugin_greeting_ramadhan_last"
  if [[ "$plugin_greeting_ramadhan_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      echo "entri ada tapi kosong"
      sed -i 's/'$entri'*.*/'$entri'="0"/g' "plugin/plugin.conf"
    else
      echo "entri belum ada"
      echo "$entri=\"0\"" >> "plugin/plugin.conf"
    fi
    urutan="0"
    
  else # cek isinya
    if [[ "$plugin_greeting_ramadhan_last" -eq "$target_num_max" ]]; then
      echo "target max"
      urutan="0"
    else
      echo "urutan ganti"
      urutan=$(( plugin_greeting_ramadhan_last + 1 ))
    fi
    sed -i 's/'$entri'*.*/'$entri'='\"$urutan\"'/g' "plugin/plugin.conf"

  fi

  target=${target_array[$urutan]}

}

greeting_cek_ramadhan()
{
  case "$jam" in
    01)
       greet_arr+=("Sudah malam bos $target.. cepetan tidur biar nanti ga kelewat lagi sahurnya.. :D")
       greet_arr+=("Ayo bos $target cepetan tidur.. apa mo begadang sampe sahur sih?")
       greet_arr+=("$target jam masih melek apa udah bangun buat sahur? :D")
       greet_arr+=("kalo jam segini masih bangun,, biasanya ntar si $target telat bangun sahurnya..")
    ;;
    02)
       greet_arr+=("Sahuurr.. Sahuurr... ayo banguun.. banguuun!! cc $target")
       greet_arr+=("si $target tu rajin banget, biasanya jam segini udah ronda muter2 kampung :D")
       greet_arr+=("$target udah bangun apa belom?? ayo sahur sahuur...")
       greet_arr+=("$target ikut aku ronda keliling kampung yook.. :D")
    ;;
    03)
       greet_arr+=("$target barusan bangun sahur ada seseorang yang mbangunin nggak nih..? :D")
       greet_arr+=("sahur pake menu apa ni bos $target ??")
       greet_arr+=("$target kalo makan sahur ga usah keburu yaa.. ntar keselek malah ga bisa puasa.. :D")
       greet_arr+=("ada yang jam segini masih molor nggak bangun sahur lo.. --> $target")
       greet_arr+=("tebakan yok.. si $target sahurnya habis berapa piring..? :D")
    ;;
    04)
       greet_arr+=("bos $target udah mau imsak tuh.. sahurnya cepetan dihabisin..!")
       greet_arr+=("ada juga lo orang yang baru bangun sahur jam segini.. --> $target :D")
       greet_arr+=("sahur abis berapa piring ni bos $target..? banyak amat nimbun persediaannya :D")
       greet_arr+=("abis sahur itu afdhol-nya sholat subuh.. nggak kayak si $target yg langsung tidur lagi :D")
    ;;
    05)
       greet_arr+=("$target <-- habis sahur biasanya ni orang langsung tidur.. :D")
       greet_arr+=("si $target kayaknya lagi tidur pules nih jam segini, kekenyangan pas sahur tadi..")
       greet_arr+=("$target <-- nggak ada yg bangunin sahur.. baru bangun jam segini.. #ngenes")
       greet_arr+=("$target <-- abis sahur langsung tidur.. lupa ga subuh dulu :D")
    ;;
    06)
       greet_arr+=("$target <-- kalo baru bangun jam segini buat sahur ya kebangetan namanya bos.. --___--")
       greet_arr+=("si $target kayaknya lagi mlungker meluk guling jam segini nih..")
       greet_arr+=("$target sekarang lagi sahur susulan.. tadi nggak sempat bangun soalnya :D")
    ;;
    07)
       greet_arr+=("tumben jam segini si $target melek.. biasanya habis sahur tidur sampe siang ni orang..")
       greet_arr+=("selamat pagi $target.. udah sarapan apa belom..? :D")
       greet_arr+=("pagi $target.. hari ini puasa apa nggak nih? :D")
       greet_arr+=("ciyeee.. yang baru selesai ibadah #tidur.. cc $target")
    ;;
    08)
       greet_arr+=("$target --> Sarapan apa yaa..? (pagi-pagi udah lupa kalau lagi puasa)")
       greet_arr+=("oi $target.. puasa itu memang wajib,, tapi nggak seharusnya kamu ninggalin mandi, bau nih.. :D")
       greet_arr+=("$target <-- masih terbayang-bayang menu sahur tadi.. :D")
    ;;
    09)
       greet_arr+=("walaupun lagi puasa,, kudu tetap semangat kerja,, setuju kan $target? :)")
       greet_arr+=("$target <-- mukanya melas banget.. lemes.. kayak orang lagi puasa aja.. :D")
       greet_arr+=("$target <-- jangan lemes gitu woy.. kayak orang lagi puasa aja..")
    ;;
    10)
       greet_arr+=("tenang $target.. bentar lagi udah bisa buka puasa kok.. puasa setengah hari kan? :D")
       greet_arr+=("nah gitu dong $target.. walaupun puasa tapi tetep fresh.. eh.. emangnya situ puasa?")
       greet_arr+=("cerah banget wajah $target pagi ini.. menu sahurnya cocok ya?")
    ;;
    11)
       greet_arr+=("$target sono gih siap2 buka puasa.. situ puasa setengah hari kan? :D")
       greet_arr+=("$target <-- lagi nungguin bedug dzuhur, mau buka puasa dia :D")
       greet_arr+=("oi $target.. kuat nggak puasa sehari penuh? kalo nggak kuat habis ini buka puasa aja, puasa bedug :D")
    ;;
    12)
       greet_arr+=("selamat berbuka puasa bagi yang lagi puasa bedug --> $target")
       greet_arr+=("nah.. kayak $target gini dong.. walaupun puasa tapi dia semangat banget.. (baru buka puasa bedug sualnya) :D")
       greet_arr+=("$target lagi buka puasa bedug nih kayaknya.. :D")
    ;;
    13)
       greet_arr+=("tetep semangat $target..! walaupun panas-panas gini, puasanya harus tetep dilanjut lo.. :)")
       greet_arr+=("$target <-- baru mandi karena kepanasan.. pas mandi tadi minum air nggak? dosa lo.. :D")
       greet_arr+=("semangat $target..! tinggal 5 jam lagi menuju es cendol dingiiiin yang segerrr.. :D")
       greet_arr+=("$target <-- lagi ibadah #tidur dengan khusyuk.. :D")
    ;;
    14)
       greet_arr+=("$target ga usah mikirin menu buka puasa dulu napa..? masih lama boss..")
       greet_arr+=("hebat ni si $target.. jam segini udah nentuin menu buka puasa nanti pake apa.. :D")
       greet_arr+=("$target, habis sahur itu gosok gigi.. biar ga kuning gitu giginya..")
       greet_arr+=("$target, paling enak ya jam segini tidur.. trus ntar baru bangun pas maghrib buat buka puasa..")
    ;;
    15)
       greet_arr+=("$target udah sholat Ashar pa belum..? santai.. sholat dulu.. berdoa biar maghribnya datang lebih awal :D")
       greet_arr+=("kalau sore2 gini biasanya si $target modus tidur, biar nanti bangun2 udah maghrib dan tinggal buka puasa :D")
       greet_arr+=("$target udah nentuin menu buka puasa nanti apa belum nih?")
    ;;
    16)
       greet_arr+=("sabar ya $target.. buka puasa tinggal sebentar lagi tuh.. :)")
       greet_arr+=("$target <-- biasanya jam segini lagi berburu takjil gratisan :D")
       greet_arr+=("udah nentuin nanti mau takjil gratisan di mana $target ? :D")
       greet_arr+=("$target mau takjil gratis nggak? datang aja ke rumah aku sekarang :D")
    ;;
    17)
       greet_arr+=("semangat buat buka puasa sih boleh-boleh aja $target.. tapi mbok ya mandi dulu.. baumu itu loh..")
       greet_arr+=("buka puasa pake apa nih $target ??")
       greet_arr+=("Alhamdulillah buka puasaaaa... :) cc $target")
    ;;
    18)
       greet_arr+=("selamat berbuka puasa ya $target.. udah habis berapa piring barusan?")
       greet_arr+=("buka puasa barusan kamu habis berapa piring makannya $target?")
       greet_arr+=("$target ga usah banyak2 makan pas buka puasa.. ntar pas tarawih nggak bs dipake sujud perutmu?")
    ;;
    19)
       greet_arr+=("$target hari ini kayaknya nggak sholat tarawih deh.. malah twitteran aja :D")
       greet_arr+=("hayooo yang nggak tarawih gara-gara kekenyangan pas buka puasa.. --> $target :D")
       greet_arr+=("$target <-- shalat tarawihnya ngebut banget ya, jam segini udah selesai..")
       greet_arr+=("$target <-- ini yang biasanya rame di shof belakang pas jamaah tarawih.. --___--")
       greet_arr+=("Hari ini sholat tarawihnya super express.. bentar aja udah selesai.. yeey..!! cc $target")
    ;;
    20)
       greet_arr+=("$target <-- biasanya abis tarawih doi lanjut buka puasa level 2 nih.. :D")
       greet_arr+=("gimana $target..? siap lanjut buka puasa level 2? atau malah udah level 3 nih?")
       greet_arr+=("$target habis sholat tarawih biasanya langsung tidur nih anak..")
       greet_arr+=("$target kalo ikut jamaah tarawih tu jangan cuma rame di shof belakang oi.. --___--")
    ;;
    21)
       greet_arr+=("lagi ngerjain apa ni bos $target? lagi mikirin menu sahur besok ta? #penasaran")
       greet_arr+=("$target tidur lebih awal aja gih sono.. biar nanti nggak telat lagi bangun sahurnya..")
       greet_arr+=("$target jam segini masih lanjut makan..?? wow superr sekali kamu ya :D")
    ;;
    22)
       greet_arr+=("$target jangan tidur malem2 bos.. ntar malah telat bangun buat sahur merena deh kamu..")
       greet_arr+=("$target <-- daripada bengong mending tidur aja..")
       greet_arr+=("$target <-- jam segini masih belum waktunya ronda bos.. keliling aja dari tadi --___--")
    ;;
    23)
       greet_arr+=("Belum ngantuk bos $target? Hwoooaaaahm... >_< #ngantukberat")
       greet_arr+=("si $target kalo dah ngantuk jangan dipaksain.. tidur aja..")
       greet_arr+=("si $target jam segini udah siap-siap mau ngeronda?? hebat bener semangatmu nak..")
    ;;
    *)
       greet_arr+=("Zzz.. Zzz.. (-_-) Zzz.. Zzz.. #ngorok")
       greet_arr+=("$target, masih bangun apa udah #ngorok sambil #ngiler? :D")
    ;;
  esac

  greet_num=${#greet_arr[*]}
  greet=${greet_arr[$((RANDOM%greet_num))]}
}

greeting_hari_jumat_ramadhan()
{
   case "$hari" in
      # Siap-siap jumatan
      5) #5=jumat
         case "$jam" in
            11 )
               greet="Ayo siap-siap sholat Jumat dulu bos.. cc @gojigeje"
            ;;
            12 )
               greet="Habis Jumatan gini enaknya ya ibadah tidur :D"
            ;;
            13 )
               greet="Jumat siang, buat tidur mantap nih :D"
            ;;
         esac
      ;;
   esac 
}

# main method, set tweet_status
twit_ramadhan_greet_main() {
  plihtarget_ramadhan
  greeting_cek_ramadhan
  greeting_hari_jumat_ramadhan
  #getJam
  tweet_status="$greet"
}

