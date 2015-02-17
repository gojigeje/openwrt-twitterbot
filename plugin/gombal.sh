#!/bin/bash

aksi_array+=("twit_gombal")

twit_gombal_pilihtarget() {
  target_num=${#target_array[*]}
  target_num_max=$(( target_num - 1 ))

  # cek entri di config
  entri="plugin_gombal_last"
  if [[ "$plugin_gombal_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      sed -i 's/'$entri'*.*/'$entri'="0"/g' "plugin/plugin.conf"
    else
      echo "$entri=\"0\"" >> "plugin/plugin.conf"
    fi
    urutan="0"
    
  else # cek isinya
    if [[ "$plugin_gombal_last" -eq "$target_num_max" ]]; then
      urutan="0"
    else
      urutan=$(( plugin_gombal_last + 1 ))
    fi
    sed -i 's/'$entri'*.*/'$entri'='\"$urutan\"'/g' "plugin/plugin.conf"

  fi

  target=${target_array[$urutan]}
}

twit_gombal_pilihgombalan() {
  gombalan_num=${#gombalan_array[*]}
  gombalan_num_max=$(( gombalan_num - 1 ))

  # cek entri di config
  entri="plugin_gombalan_last"
  if [[ "$plugin_gombalan_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      sed -i 's/'$entri'*.*/'$entri'="0"/g' "plugin/plugin.conf"
    else
      echo "$entri=\"0\"" >> "plugin/plugin.conf"
    fi
    urutan="0"
    
  else # cek isinya
    if [[ "$plugin_gombalan_last" -eq "$gombalan_num_max" ]]; then
      urutan="0"
    else
      urutan=$(( plugin_gombalan_last + 1 ))
    fi
    sed -i 's/'$entri'*.*/'$entri'='\"$urutan\"'/g' "plugin/plugin.conf"

  fi

  gombalan=${gombalan_array[$urutan]}
}

# main method
twit_gombal_main() {
  target_array=(
      "@sarri__"
      "@hanazawaqurin"
      "@d34ff4"
      "@Zheezayn"
      "@RomsZhu"
      "@Diflarizqiya"
      "@putrinawa"
      "@Chindy_horor"
      "@AllyciaAP"
      "@ristina55"
      "@putrinawa"
      "@puu_sita"
      "@Ressaniaa"
      "@cipluxx"
      "@AnindaRPD"
      "@ulinzulfa"
      "@AnandaRPD"
      "@jessy_zy"
      "@Marsha_Say"
      "@Diflarizqiya"
    )
  twit_gombal_pilihtarget

  # gombalan, source:
  # http://muhamadsahlan.blogspot.com/2012/02/kata-kata-gombalan-galau-di-twitter-ii.html
  # http://blog-penerang.blogspot.com/2013/03/kata-kata-gombal-gokil-terbaru-2013.html
  gombalan_array=(
      "Mau nitip cinta sama angin ah | kok gitu? | iya,jd saat km masuk angin, saat itu pula cintaku msuk ke hatimu :D"
      "Sebentar lg aku 1 bulanan lo sama pacar aku | oh ya? Kapan? | hari ini kl kamu nerima aku, berarti bulan depan... :) :D"
      "Pinjem modem boleh? | Mau ngapain? | Mau nyari file hati kamu dan mau Upload rasa sayang aku buat kamu. :D"
      "Apa beda'y km sama orang utan? | g tau | kalo orang utan suka ngegantung di pohon, klo km suka ngegantung cinta aku :D"
      "Indonesia udah merdeka kan? | iya,emang udah | tapi kok perasaanku masih aja dijajah sama km? #PHP :D"
      "Masa lalu km sama mantan mungkin memang indah, tp masa depan km bersamaku akan jauh lebih indah, pacaran yuuk :D"
      "Haii.. Cinta, lg ngapain? | aku lg kangen km nih,kalo km lg apa? | lagi cabutin bulu ketek nih :D"
      "km tau knp anak kodok loncat2? | yaah nama'y jg anak2 kan? | bukan, dia tuh seneng liat km putus ma pacar km :D"
      "Boleh aku pinjem jari manis km? | ahh pasti gombal nih, mau belajar pasang cincin kan? | bukan kok aku mau ngupil :D"
      "Woy maling,maling,maling! Ada yg mau maling hatiku ni :D :D"
      "km itu seperti hujan yg menyejukkan hati | asekk..so pasti doonk ^_^ | tp bisa bikin aku sakit juga loh | -___- :D"
      "Menurut km,lebih susah mana pelajaran matematika sama fisika? | menurut aku sih lebih susah lupain kamu | #___#"
      "Apa bedanya kamu sama lebah ? | Apa? | Kalo lebah membuat madu, kalo kamu membuatku rindu. :D"
      "Waah km emang berbakat deh | berbakat apa? | berbakat jadi Qeong Racuuunnnn (¬.¬)ƪ(˘ε˘“)"
      "Yang layak di gantung tuh harus'y para koruptor, bukan malah perasaanku yg km gantung :D"
      "Sesuatu banget deh punya pacar kaya km | ahh biasa aja kok (ʃ⌣ƪ) | soal'y pinter banget km menguras air mataku :D"
      "Kalau kamu ajak aku melompat bareng, aku g bakalan mau. Mending aku lari ke bawah, bersiap menangkapmu. :D"
      "Tau gak kenapa kuntilanak suka nangis malem2? | emm ga tau | soal'y dia sedih liat km jomblo (-̩-̩̩-̩u-̩-̩̩-̩) :D"
      "Rhoma Irama itu Raja Dangdut, Michael jackson itu Raja Pop, kalau aku itu RAJA dihatimu :D"
      "maaf ya aku gak bisa ngobatin kakimu yang luka, tapi aku bisa kok ngobatin hatimu yang terluka oleh cinta :D"
      "Punya deterjen pemutih ga? | buat apa? | aku mau mencuci cinta suci kita yg telah kau nodai (-̩-̩̩-̩u-̩-̩̩-̩)"
      "Kamu itu udah bikin aku nyesel, bikin aku nyesel banget kenapa gak kenal kamu dari dulu. :D"
      "Kamu tau ga bedanya kamu sama langit? kalo langit di atas kalo kamu di hati aku :* :D"
      "Kamu bisa sopan dikit gak sih, seenaknya keluar masuk pikiranku tanpa izin. :D"
      "Aku disini selalu mendOakan km, dan km disana selalu mendUakan aku #bedahuruf #bedarasa :D"
      "Kamu bisa Cantik gitu keturunan dari Ibu / Bapak kamu bukan seeh? Kok bidadari bisa punya Ortu?! :D"
      "Sebenarnya selama ini aku pencuri. Soalnya aku suka curi-curi pandang ke kamu. :D"
      "Neng, tolong izinin aku ya. | Izinin apa? | Izinkan aku untuk tetap mencintaimu sampai mati. :D"
      "Apa bedanya Monas sama Kamu? Ya bedalah, apaan emgnya? Kalo Monas milik negara, kalo kamu miliku :D"
      "Hatiku sama seperti MetroMini Sama-sama penuh sesak oleh cintamu :D"
      "Hey kamu | Iya? | Kamu Arsitek ya? | Haa ko tahu? | Karena kamu telah membangun istana cinta di hatiku #eaaa :D"
      "Cinta dan sayangku ke kamu itu kaya kuku. Meskipun di potong, tetep tumbuh terus :D"
      "Kita main rampok-rampokan yuk? Kyk gmna? Kamu curi hatiku, aku curi hatimu :D"
      "Jujur aja gue ini bkn cowo baik-baik. Suka mencuri. Apalagi mencuri cintamu. :D"
      "Boleh pinjem meteran? | Buat apa? | Aku mau mengukur kedalaman cintaku padamu. :D"
      "km tau gak kenapa pocong loncat2? | kenapa? | soal'y dia seneng liat kita udah jadian :) :D"
      "Kamu tau g bedanya bumi sama kamu? | enggak emang apa? | kalau bumi berputar pd porosnya kalau kamu berputar di hatiku :D"
      "km tau ada berapa byk simetri lipat pada lingkaran? | tau, banyak'y tak terhingga | seperti itulah rasa galauku ke km :D"
      "Kalo di deket km,aku selalu jd inget bunga deh | co cwiittt banget gombal'y (ʃ⌣ƪ) | maksud inget bunga bangkai mbak :D"
      "Neng,klo kmu jd gula. Abang gk mau jd semutnya | Kok gt bang? | soalnya abang gk mau m'habiskan kmanisan wjahmu.. :D"
      "Aku rela jadi Jomblo sejati, asalkan Jomblonya ditemani kamu selamanya. :D"
      "Tau gak aku lg ada dimana? | emang dimana? | aku ada diterminal hatimu nih,lg ngetem nunggu km jomblo :D"
      "Bapak kamu jaga warnet ya? | iya, kok tau? | tolong tanyain dong, dimana cara upload cinta ku ke hati kamu :D"
      "Punya kain kafan gak? | buat apa? | aku mau membungkus perasaanku yg sudah kau bunuh (-̩-̩̩-̩u-̩-̩̩-̩)"
      "Cowo:Kamu tau nggak tadi malem aku mimpi nyasar kemana? Cewe:Kemana?? Cowo:Kehatimu! :D"
      "Cintamu seperti embun yg menyejukkan hati di pagi hari, tp mudah sirna oleh terik matahari :D"
      "Bapak kamu koruptor ya ? | kok tau ? | karna kamu telah mengkorupsi cinta dan kepercayaanku :D"
      "Hai mantan, kamu lagi belajar yah? | iya kok tau? | soalnya aku juga sama nih lagi belajar lupain km :D"
      "Jalan-jalan kesurabaya tak lupa ke suramadu. Buat kau yang disana.. I miss you :) :D"
      "Kamu jago matematika ya? Boleh dong itungin detak jantungku tiap liat kamu. :D"
      "Nitip beliin racun tikus donk | buat apa? | buat ngeracun pacar km -____-"
      "Aku kayaknya gagal jadi penulis deh Emgnya knapa? Soalnya daritadi yg aku tulis cuma nama kamu aja :D"
      "Tau gak di warung padang apa yang paling enak? PADANGin wajah kamu terus. :D"
      "Aku bersihin telapak kaki kamu yah | eh ngapain? | Biar surga anak-anak ku nanti bersih :D :D"
      "Selang apa yg paling menyakitkan? | apaan? | selang sehari jadian,km udah bisa selingkuh -___- :D"
      "menunggu itu pekerjaan yang membosankan | emang nungguin apa sih? | nunggu km putus sama pacar km -___- :D"
      "Gara2 liat foto km,aku jd kangen | aahh masaa? Mau gombal yaa?? ^_^ | maksud'y jd kangen sm toilet,bikin mules sih :D"
      "Apa beda'y km sama nyamuk? | gak tau | kalo nyamuk ngisep darah, kalo km ngisep perasaanku :D"
      "km tuh ya..yg di update status fb aja. Kapan donk update status hubungan kita? :D"
      "Cinta aku ke kamu itu seperti skripsi | Kok gitu? | Gak kelar-kelar~ :D"
      "km punya palu ga? | buat apaan? | aku mau meruntuhkan dinding hatimu yg membeku :D"
      "Satu-satunya bahasa yang membuat aku bingung, sampai Google pun tidak bisa bantu adalah Bahasa Cinta darimu :D"
      "Cintamu seperti asap, pekat pada awal'y kemudian menguap begitu saja (⌣́_⌣̀) :D"
    )
  twit_gombal_pilihgombalan

  # set tweet_status
  tweet_status="$target $gombalan"
}

