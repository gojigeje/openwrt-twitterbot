#!/bin/bash

aksi_array+=("twit_gombal")

twit_gombal_pilihtarget() {
  target_num=${#target_array[*]}
  target=${target_array[$((RANDOM%target_num))]}

  # pasitkan gombalan sebelumnya bukan untuk target ini
  entri="plugin_gombal_last"
  if [[ "$plugin_gombal_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      # echo "entri ada tapi kosong, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$target'"/g' "plugin/plugin.conf"
    else
      # echo "entri ga ada, insert"
      echo "$entri=\"$target\"" >> "plugin/plugin.conf"
    fi

  else # cek isinya
    if [[ "$target" != "$plugin_gombal_last" ]]; then
      # echo "isinya nggak sama, replace"
      sed -i 's/'$entri'*.*/'$entri'="'$target'"/g' "plugin/plugin.conf"
    else
      # echo "target sama, pilih lagi [$target]"
      twit_gombal_pilihtarget
    fi
  fi
}

# main method
twit_gombal_main() {
  target_array=(
      "@AllyciaAP"
      "@AnandaRPD"
      "@AnindaRPD"
      "@chen9_"
      "@Chindy_horor"
      "@cipluxx"
      "@d34ff4"
      "@hanazawaqurin"
      "@jessy_zy"
      "@Marsha_Say"
      "@putrinawa"
      "@putrinawa"
      "@Ressaniaa"
      "@ristina55"
      "@RomsZhu"
      "@sarri__"
      "@ulinzulfa"
      "@Zheezayn"
    )
  twit_gombal_pilihtarget

  # gombalan, source:
  # http://muhamadsahlan.blogspot.com/2012/02/kata-kata-gombalan-galau-di-twitter-ii.html
  # http://blog-penerang.blogspot.com/2013/03/kata-kata-gombal-gokil-terbaru-2013.html
  gombalan_array=(
      "Kamu itu udah bikin aku nyesel, bikin aku nyesel banget kenapa gak kenal kamu dari dulu."
      "Menurut km,lebih susah mana pelajaran matematika sama fisika? | menurut aku sih lebih susah lupain mantan | #___#"
      "Punya deterjen pemutih ga? | buat apa? | aku mau mencuci cinta suci kita yg telah kau nodai (-̩-̩̩-̩u-̩-̩̩-̩)"
      "Jujur aja gue ini bkn cowo baik-baik. Suka mencuri. Apalagi mencuri cintamu."
      "Boleh pinjem meteran? | Buat apa? | Aku mau mengukur kedalaman cintaku padamu.~"
      "Nitip beliin racun tikus donk | buat apa? | buat ngeracun pacar km -____-"
      "Woy maling,maling,maling! Ada yg mau maling hatiku ni :D"
      "Masa lalu km sama mantan mungkin memang indah, tp masa depan km bersamaku akan jauh lebih indah, nikah yuuk"
      "Rhoma Irama itu Raja Dangdut, Michael jackson itu Raja Pop, kalau aku itu RAJA dihatimu"
      "Apa beda'y km sama orang utan? | ga tau | kalo orang utan suka ngegantung diatas pohon, klo km suka ngegantung cinta aku"
      "Punya kain kafan gak? | buat apa? | aku mau membungkus perasaanku yg sudah kau bunuh (-̩-̩̩-̩u-̩-̩̩-̩)"
      "Cowo:Kamu tau nggak tadi malem aku mimpi nyasar kemana? Cewe:Kemana?? Cowo:Kehatimu!"
      "Bapak kamu koruptor ya ? | kok tau ? | karna kamu telah mengkorupsi cinta dan kepercayaanku"
      "Kita main rampok-rampokan yuk? Kyk gmna? Kamu curi hatiku, aku curi hatimu"
      "Pinjem modem boleh? | Mau ngapain? | Mau nyari file hati kamu dan mau Upload rasa sayang aku buat kamu."
      "Waah km emang berbakat deh | berbakat apa? | berbakat jadi Qeong Racuuunnnn (¬.¬)ƪ(˘ε˘“)"
      "Aku kayaknya gagal jadi penulis deh Emgnya knapa? Soalnya daritadi yg aku tulis cuma nama kamu aja"
      "Hai mantan, kamu lagi belajar yah? | iya kok tau? | soalnya aku juga sama nih lagi belajar lupain km"
      "Jalan-jalan kesurabaya tak lupa ke suramadu. Buat kau yang disana.. I miss you :)"
      "Neng,klo kmu jd gula. Abang gk mau jd semutnya | Kok gtu bang? | soalnya abang gk mau m'habiskan kmanisan wjahmu.. | *senyum*"
      "Neng, tolong izinin aku ya. | Izinin apa? | Izinkan aku untuk tetap mencintaimu sampai mati."
      "Cinta aku ke kamu itu seperti skripsi | Kok gitu? | Gak kelar-kelar~"
      "Aku rela jadi Jomblo sejati, asalkan Jomblonya ditemani kamu selamanya."
      "km itu seperti hujan yg menyejukkan hati | asekk..so pasti doonk ^_^ | tp bisa bikin aku sakit juga loh | -___-"
      "Kalo di deket km,aku selalu jd inget bunga deh | co cwiittt banget gombal'y (ʃ⌣ƪ) | maksud aku inget bunga bangkai mbak"
      "Kamu tau nggak bedanya bumi sama kamu? | enggak emang apa? | kalau bumi berputar pada porosnya kalau kamu berputar dalam hatiku"
      "km tau ada berapa byk simetri lipat pada lingkaran? | tau, banyak'y tak terhingga | seperti itulah rasa galauku kepadamu :)"
      "Boleh aku pinjem jari manis km? | ahh pasti gombal nih, mau belajar pasang cincin kan? | bukan kok aku mau ngupil"
      "Aku disini selalu mendOakan km, dan km disana selalu mendUakan aku #bedahuruf #bedarasa"
      "Cinta dan sayangku ke kamu itu kaya kuku. Meskipun di potong, tetep tumbuh terus"
      "Sesuatu banget deh punya pacar kaya km | ahh biasa aja kok (ʃ⌣ƪ) | soal'y pinter banget km menguras air mataku"
      "km tau gak kenapa pocong loncat2? | kenapa? | soal'y dia seneng liat kita udah jadian :)"
      "Selang apa yg paling menyakitkan? | apaan? | selang sehari jadian,km udah bisa selingkuh -___-"
      "Gara2 liat foto km,aku jd kangen | aahh masyaa? Mau gombal yaaa?? ^_^ | maksud'y jd kangen sama toilet,bikin mules sih"
      "Tau gak kenapa kuntilanak suka nangis malem2? | emm ga tau | soal'y dia sedih liat km jomblo (-̩-̩̩-̩u-̩-̩̩-̩)"
      "Hey kamu | Iya? | Kamu Arsitek ya? | Haa ko tahu? | Karena kamu telah membangun istana cinta di hatiku #eaaa"
      "Sebentar lg aku 1 bulanan loh sama pacar aku | oh ya? Kapan? | hari ini kalo kamu nerima aku, berarti bulan depan... :)"
      "Hatiku sama seperti MetroMini Sama-sama penuh sesak oleh cintamu"
      "Sebenarnya selama ini aku pencuri. Soalnya aku suka curi-curi pandang ke kamu."
      "Indonesia udah merdeka kan? | iya,emang udah | tapi kok perasaanku masih aja dijajah sama km? #PemberiHarapanPalsu"
      "Kamu jago matematika ya? Boleh dong itungin detak jantungku tiap liat kamu."
      "Mau nitip cinta sama angin ah | kok gitu? | iya,jd saat km masuk angin, saat itu pula cintaku masuk kedalam hatimu"
      "Aku bersihin telapak kaki kamu yah | eh ngapain? | Biar surga anak-anak ku nanti bersih :D"
      "Haii.. Cinta, lg ngapain? | aku lg kangen km nih,kalo km lg apa? | lagi cabutin bulu idung nih"
      "Satu-satunya bahasa yang membuat aku bingung, sampai Google pun tidak bisa membantu ku adalah Bahasa Cinta darimu"
      "Kamu tau ga bedanya kamu sama langit? kalo langit di atas kalo kamu di hati aku :*"
      "Cintamu seperti embun yg menyejukkan hati di pagi hari, tp mudah sirna oleh terik matahari"
      "Apa beda'y km sama nyamuk? | gak tau | kalo nyamuk ngisep darah, kalo km ngisep perasaanku"
      "km tuh ya..yg di update status fb aja. Kapan donk update status hubungan kita?"
      "menunggu itu pekerjaan yang membosankan | emang nungguin apa sih? | nunggu km putus sama pacar km -___-"
      "Apa bedanya kamu sama lebah ? | Apa? | Kalo lebah membuat madu, kalo kamu membuatku rindu."
      "Kalau kamu ajak aku melompat bareng, aku ngga bakalan mau. Mending aku lari ke bawah, bersiap menangkapmu."
      "maaf ya aku gak bisa ngobatin kakimu yang berdarah, tapi aku bisa kok ngobatin hatimu yang terluka oleh cinta"
      "Bapak kamu jaga warnet ya? | iya, kok tau? | tolong tanyain dong, dimana cara upload cinta ku ke hati kamu"
      "km tau knp anak kodok loncat2? | yaah nama'y jg anak2 kan? | bukan kok, dia tuh seneng liat km putus ma pacar km"
      "Cintamu seperti asap, pekat pada awal'y kemudian menguap begitu saja (⌣́_⌣̀)"
      "Tau gak aku lg ada dimana? | emang dimana? | aku ada diterminal hatimu nih,lg ngetem nunggu km jomblo"
      "Kamu bisa sopan dikit gak sih, seenaknya keluar masuk pikiranku tanpa izin."
      "Yang layak di gantung tuh harus'y para koruptor, bukan malah perasaanku yg km gantung"
      "Apa bedanya Monas sama Kamu? Ya bedalah, apaan emgnya? Kalo Monas milik negara, kalo kamu miliku"
      "km punya palu ga? | buat apaan? | aku mau meruntuhkan dinding hatimu yg membeku"
      "Naik busway..digrepe2,naik angkot.. diperkosa,jln kaki..ditabrak xenia, diem di hati km,eh ditabrak cinta deh"
      "Tau gak di warung padang apa yang paling enak? PADANGin wajah kamu terus."
      "Kamu bisa Cantik gitu keturunan dari Ibu / Bapak kamu bukan seeh? Kok bidadari bisa punya Ortu?!"
    )
  gombalan_num=${#gombalan_array[*]}
  gombalan=${gombalan_array[$((RANDOM%gombalan_num))]}  

  # set tweet_status
  tweet_status="$target $gombalan"
}
