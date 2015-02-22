#!/bin/bash
#
# nama plugin : bacot
# deksripsi   : ngebacot twit random
# 
# cara pakai  : twit_bacot
#

aksi_array+=("twit_bacot")

pilih_bacotan() {

  bacotan_num=${#bacotan_array[*]}
  bacotan_num_max=$(( bacotan_num - 1 ))

  # cek entri di config
  entri="plugin_bacotan_last"
  if [[ "$plugin_bacotan_last" = "" ]]; then
    if grep -q "$entri" "plugin/plugin.conf" ; then
      sed -i 's/'$entri'*.*/'$entri'="0"/g' "plugin/plugin.conf"
    else
      echo "$entri=\"0\"" >> "plugin/plugin.conf"
    fi
    urutan="0"
    
  else # cek isinya
    if [[ "$plugin_bacotan_last" -eq "$bacotan_num_max" ]]; then
      urutan="0"
    else
      urutan=$(( plugin_bacotan_last + 1 ))
    fi
    sed -i 's/'$entri'*.*/'$entri'='\"$urutan\"'/g' "plugin/plugin.conf"

  fi

  bacotan=${bacotan_array[$urutan]}
}

# main method
twit_bacot_main() {

  # bacotan, source:
  # http://lintas-terbaru.blogspot.com/2013/11/kata-kata-lucu-update-status-twitter.html
  # http://www.bloggergubug.com/2013/01/update-status-gokil-anti-galau-2013.html
  # http://munafsiq.blogspot.com/2012/09/status-lucu.html
  # http://ariepinoci.blogspot.com/2013/07/kata-kata-lucu-di-twitter-yang-ngaco.html
  # http://bolaynet.blogspot.com/2013/07/kata-kata-jomblo-yang-lucu.html
  # http://penajib.blogspot.com/2014/02/kata-kata-jomblo-galau-lucu-banget.html
  bacotan_array=(
      "abis putus. galau. mau mabok. tapi dikulkas cuma ada susu kental manis. apa bisa mabok pake susu kental manis?"
      "Kalo dapet pacar itu mudah, Jomblo bakalan punah... lestarikan jomblo..!"
      "Cie yg lagi kangen sama pacar tapi gak punya pacar ._."
      "Katanya Gak mau disamain dengan binatang. Tapi masih aja percaya sama ramalan yang lambangnya binatang.."
      "#News Diduga ternoda oleh pacar, seorang pemudi nekat mandi dgn deterjen anti noda."
      "Punya pacar Cakep itu susah... Susah di jelek-jelekinnya kalo udah putus."
      "*KFC* siang mas, brapa orang? | 5 | smoking area atau ga? | Jomblo area ada mbak | ....."
      "Orang yg sering cari muka itu mungkin aja muka nya hilang #lah"
      "#Horror itu saat lo beli baju Couple di olshop. Begitu kiriman baju sampe ga taunya lo udah putus.."
      "Cinta itu tak harus memiliki. Terus apa yang harus gue miliki? GALAU?"
      "Ingat, Shalat jumat itu nambah Iman, bukan nambah ganteng #Fact"
      "Percuma nyuruh pacar makan, yang kenyang juga bukan lo ┒(ˇ_ˇ)┎"
      "Orang pintar, minum tolak angin. Orang jenius, ke Klinik Tong Fang!"
      "Ternyata air ludah bisa nyembuhin darah rendah.. coba ludahin muka temen lu yang darah rendah, 2 detik langsung naik darahnya.."
      "Kata cewek 'Semua Lelaki itu brengsek' Nah guys kalo lo brengsek berbanggalah, Brarti lo laki."
      "Cinta sama org Bodoh itu gpp, tp jgn sampe Dibodoh2in ama org karena Cinta -__-"
      "Lebih baik kejebak macet dijalan, dari pada kejebak kenangan dimasa lalu! :p"
      "Bang, kecap sebotol berapa? | 20ribu | Mahal amat, di TV aja lebih murah | Yaudah, ibu belinya di TV aja."
      "Prajurit:'pak, kita telah dikepung dari berbagai arah!' Komandan:'Bagus! sekarang kita bisa menyerang dari segala arah! MUAHAHA!"
      "Walau Lo jelek tapi nyari temen itu harus milih2. Ya harus org yang lebih jelek dari lo. Biar lo keliatan cakep #nasehat"
      "3 dari 10 wanita itu takut sama pacar pria nya. Sisa nya takut sama berat badan"
      "Semua LDR itu SETIA - SEring TIdak Apel.... #Eh"
      "Jangan suka ngomongin orang dari belakang, kalo kamu ga mau dikentutin."
      "Kalo kamu mau punya pacar yg bisa menjaga kamu & hati kamu... Pacaran aja ama security."
      "Jomblo mah gitu, Ngeliat tukang ojek lagi boncengin penumpangnya aja cemburu #Eh"
      "co: leh kenalan? | ce: bleh bang | co: nmanya siapa? | ce: sheila | co: bgus bgt, nama panjangnya? | ce: sheilangkangan | co: %!$%!@$%"
      "Menurut dokter olah raga itu bikin sehat, tapi menurut logika gue, olah raga itu bikin capek *elap keringat*"
      "*lagi makan diwarteg* *update status* At Pizza Hut with my friends."
      "Cowok yg suka galau itu kecantikannya naik 90% #Analis"
      "Jangan menggunakan kamera 360. Karena mengandung zat pewarna. Bibir jadi orange misalnya"
      "Sebenci apa pun cowok sama pelajaran biologi, pasti bakal duduk paling depan kalo lagi ngebahas tentang 'reproduksi' -_-!"
      "Jomblo mah gitu, ngeliat maling dikejar aja langsung cemburu...."
      "Aa dokter ya? | Kok tau? | Karna Aa udah ngobatin hati neng.. | Masa? Aa kan dokter hewan, Neng.."
      "Cowok yg suka foto di Toilet mall itu Kecentilannya meningkat 90%"
      "Hey kmu, iya kmu!! Kalau pacar kamu cuma pengen paha sama dada kamu doang , suruh dia pacaran sama pegawai KFC! (¬_¬')"
      "Jangan terlalu sering mengeluh di dunia maya, nanti dikira pengemis yg gaul (?)"
      "artis itu lucu. mereka bekerja keras agar menjadi terkenal. setelah terkenal, mereka pakai kacamata hitam agar gak dikenal."
      "Lowbat adalah salah satu musuh pacaran dunia maya/LDR yang paling nyata.."
      "gue ini berjiwa penolong, karena itu gue selalu nolongin org2 yang perlu bantuan. Tapi yg cakep aja ┒(ˇ_ˇ)┎"
      "Jadi jomblo tu serba salah. Jaga jarak dibilang Sombong. Jaga image dibilang Sok Cool. Jaga komplek dibilang Satpam :|"
      "Anak muda itu baru bangun langsung update status disosmed, bukan mandi..."
      "Jangan percaya dengan avatar, percayalah dengan foto yg berukuran 3x4"
      "Bt adalah ketika abis mandi gak ada handuk. keluar pake ape gue?"
      "Beb, Semalem aku ngimpi indaaaaah banget | ngimpi kita nikah ya? | bukan, tp ngimpi kita putus | =,,="
      "Siswa relijius itu, waktu UN lembar jawabnya kosong, tapi ninggalin tulisan 'semuanya kuserahkan kepada Tuhan'"
      "orang yg suka nyari perhatian pasti dia bercita-cita jadi pussat Infomarsi. #Eaaa"
      "Ada 3 alasan orang Insomnia: Jomblo, LDR dan Internet. tapi saya ga yakin sama yg ke 3."
      "Sayang, kamu mau gak janji sama aku? | anything for you yank.. | janji ya kalo aku minta putus kamu harus nurut -__-"
      "Ucapan 'Selamat pagi' di TL adalah salah 1 cara jomblo mencari perhatian, Waspadalah waspadalah."
      "Ga usah sok unyu pake monyong2in bibir gitu dong difoto... Inget Kamu itu bukan tukul ┒(ˇ_ˇ)┎"
      "enak yah pacaran ama Alay. Dia ga mungkin selingkuh, karna bisanya CheL1n6kuH."
      "Jomblo itu jgn dibully, tapi dipacarin... ckckckckck"
      "pacaran itu penuh gombal, gombal itu bohong, bohong itu dosa, dosa masuk neraka, jadi pacaran itu bikin masuk Neraka"
      "Mungkin aja mereka yg fotonya membawa kamera itu pengen banget di sebut photograper :|"
      "*lagi nonton tv tetangga* *update status* ngantri tiket di XXI panjang beuudh yah ckck."
      "Voldemort: Dlu saya mengidap pnyakit bisul dihidung. tpi smenjak kenal dng klinik TongFang, saya jdi ga pnya hidung..!!"
      "gue: mah, ada brita bgus! | mamah: apa? apa? kmu dpet ranking 1 dikelas? | gue: mah, aku bilang brita bagus, bukan keajaiban -__-"
      "Ngenes itu ketika bangun tidur cek HP, gak ada sms/bm/notif sama sekali :|"
      "guru: 3xy + 2y² = a-z. carilah x? | gue: beuh, gampang. itu, ada di antara 3 sama y. pinter kan?"
      "Teman baik waktu minjem barang selalu Dikembalikan tp sahabat waktu minjem barang slalu pura2 lupa dikembalikan.."
      "Siapa yg paling romantis dan slalu bikin nyaman setiap larut malam (?) ya kasur."
      "Tak ada kata terlambat dalam belajar, ya benar, karena yang terlambat itu biasanya pacar.."
      "Hujan jauh lebih awet dari gaya pacaran remaja jaman sekarang"
      "Malem Minggu --> Pacaran : Bersandar dibahu pacar | Jomblo : Bersandar dibahu jalan. *Pak Minta Paaak.."
      "Dengan memakan Make Up, apakah seorang cewek akan cantik dari dalam?"
      "Foto KTP/SIM atau yg berukuran 3x4 itu membuktikan bahwa kenyataan itu pait"
      "Hati2 sama yg ngaku Single, mungkin dia Single Parent... #Krik"
      "Jomblo kalo tidur ngimpinya apaan sih?"
      "#KeselAdalah ketika kita lagi download sesuatu, dan ketika udah sampe ████████████ 99%... gagal download!"
      "Hidup itu jgn dibikin susah, coz dulu org tua kita waktu ngebuat kita itu saat mereka lg seneng2. #bijak"
      "Cantik/ganteng itu wajib di syukuri, begitu juga dgn jelek. Karna Itu juga nasib yg harus di syukuri"
      "Single: dapet sms dari cewek di diemin | jomblo: dapet sms dari cewek di 'save as draft' buat kenang2an 1x seumur idup."
      "Hujan nya awet. Seawet hubungan kita. Tapi cuma sebatas teman :|"
      "Kebiasaan Jomblo kalo baru OL ditwitter pasti nulis 'Met Pagi' atau sejenisnya biar dpt perhatian. #Uhuk"
      "Ummm kamu suka mandi pake formalin yah? Kok nge-Jomblonya awet banget?"
      "Beb, kalo kamu ga mau aku pacarin,,, gimana kalo kamu aja yg macarin aku? Adil kan?"
      "Cie yg serius banget sama sebuah tulisan, padahal penulisnya gak serius2 amat ---"
      "Satu kebodohan pemain sepak bola adalah selalu mengulangi kesalahan dan kekalahan yang sama pada siaran ulangnya!"
      "Anak twitter kalo kehujanan berteduhnya bukan diemperan toko. tapi di timeline.. :|"
      "Setiap kejahatan akan mendapat balasannya. Cinta bukan kejahatan, makanya jangan heran jika cinta kadang ga dibalas.."
      "Cie yg modus sana sini tapi di cuekin mulu #pait"
      "Rasa malas bangun pagi selalu bisa dikalahkan oleh rasa mules..."
      "Jangan lihat cowok itu dari mobil mewah yang dikendarainya. Lihatlah STNK mobil itu dulu, atas nama dia atau bukan."
      "Enak ya jadi alay, Ga pernah sedih. Bisanya cewdih ;("
      "Lihat langit, itulah Ciptaan Tuhan, Lihat Pemandangan, itulah Karya Tuhan, & lihatlah Cermin, itulah Kutukan Tuhan."
      "Orang jomblo itu kreatif banget lho. Contoh mereka sengaja pake hape dual sim card, biar bisa sms-sms sendiri, dibales-bales sendiri :p"
      "PHP itu keahlian yang dibawa sejak lahir. buktinya nggak pernah diajarkan disekolah... tapi udah pada pinter-pinter :|"
      "Jgn pernah ngomongin masa depan, kalo masa lalu ama mantan aja masih ga bisa dilupain ┒(ˇ_ˇ)┎"
      "KFC, Slamat mlm. mau pesan apa? | Saya mau pesen paket Panas 1 ya | Yakin? gak mau tirai nomor 1? Atau amplop yg ada disaku saya?"
      "Kalo ujan gini, pacar pasti jadi pelukable banget ya mblo?"
      "Emang kalo mau PACARAN harus punya PACAR dulu ya? Terus, kalo kita mau SARAPAN harus jadi SARAP dulu, gitu?"
      "#SoSweet itu ketika liat mantan lagi galau ditimeline, karena diselingkuhin pacar barunya."
      "Jadilah mantan yg Elegan, yg ga pernah ngajak balikan tapi sering diajak balikan #Nasehat"
      "Pacaran : ngumpulin duit buat nikah | LDR : ngumpulin kangen buat ketemuan | Jomblo : ngumpulin sabun!(۳˚Д˚)۳"
      "Abis beli PS baru, PS yg lama langsung rusak. PS yang pengertian.. *Elus-elus PS lama*"
      "Anak alim: #AnakMUDAitu keren kalo ibadahnya kuat | Anak alay: #AnakMUDAitu keren kalo lagi joged2 gak jelas di acara musik."
      "Hanya karena 'pacar itu dihati, bukan di bio' lantas kamu naruh nama selingkuhan kamu dibio.."
      "Kalo hati begitu sepi, otomatis HP juga sepi"
      "Tabahkan hatimu ,kuatkan imanmu ,putuskan pacarmu, Berikan padaku~"
      "cowok: Neng kita nikah yuk! | cewek: gak ah bang, aku kan masih sekolah | cowok: oh.. kirain libur."
      "Kenapa rata-rata penggangguran gak bisa bangun pagi? Karena ketika bangun pagi dia binggung mau ngapain ┒(ˇ_ˇ)┎"
      "Kematrean seorang wanita, berbanding lurus dengan tingkat kejelekan Prianya. #EaaGitu"
      "Siapa bilang putus cinta itu sakit hati... Bisa aja kan sakit hati banget ┒(ˇ_ˇ)┎"
      "alien 1: lo percaya manusia gak? | alien 2: itu tahayul!!"
      "Gini nih kalo abis mandi gini,,, cakep gue jadi berlebihan gini... Nasib..."
      "Cie yg daritadi cuma meluk guling. Meluk pacar nya kapan?"
      "Buat cewek #Horror itu saat dia tau, kalo cowoknya punya poster anggota boyband gede banget dikamarnya."
      "Kartini 2014 = Wanita cantik bukan dilihat dari hatinya, melainkan dilihat dari avatar twitternya. ---"
      "Mau apa datang ksni ? | Mau melamar pak.. | Haha.. Kamu jngan melucu yah.. Kerja apa kamu? | Saya pelawak Pak.."
      "Menyalahkan diri sendiri itu ga baik. Daripada nyalahin diri sendiri mendingan nyalahin org lain. #Babijak"
      "cowok sejati itu main futsal pake bakyak."
      "Ngenes itu ketika bangun tidur cek BB, isi nya Broadcast semua :|"
      "Hidup itu maju kedepan, bukan mundur kebelakang. Lupakan mantan yang ada dimasa lalu, jadikan ia patokan untuk lebih baik dimasa depan!"
      "Wanita peka pada pikirannya, pria peka pada perasaannya & waria peka terhadap Sirine mobil satpol pp"
      "disekolah, jika kamu cukup lama kekamar mandi, pasti smua orang mengira kamu abis boker.. -___-"
      "Mungkin mereka yg bentar-bentar upload2 foto itu pengen banget di sebut foto model"
      "#GueSukaSamaLoeTapi gue gak suka sama make up menor yang ada dimuka loe. Plis deh, ITU MUKA, BUKAN BUKU GAMBAAR!!"
      "jatuh dari sepeda - biasa | jatuh dari motor - lumayan sakit | jatuh dari mobil - BEGO berarti!"
      "cowok sejati nempelin upil di baju mantan!kenaapaaa!?'"
      "Kalo cewek bilang, 'semua cowok tuh brengsek!'. Pertanyaannya, Berjenis kelamin apakah Bapa mereka?"
      "Jika cowok kamu ngelirik cewe lain bersyukurlah, Kamu msih diberi cowo normal. Daripada dia ngelirik cowok lain.."
      "Tuhan jika ia jodohku, dekatkanlah padaku, tp jika ia bukan jodohku, jodohin aku dgn sahabatnya (˘ʃƪ˘)"
      "Aang: Dulu saya sering masuk angin. Tetapi semenjak kenal dengan klinik Tong Fang, saya jadi pengendali angin. Terimakasih Tong Fang!"
      "Percuma ngomong tinggi-tinggi, gue orang nya gak suka dengan ketinggian ┒(ˇ_ˇ)┎"
      "Kalau cewek matre lagi sakit mata, mereka nggak perlu ke dokter. Iya.. cukup dikepret pake duit 100 ribuan pasti langsung sembuh :)"
      "cowok sejati itu ngupil pake tangan guru killer!"
      "Dalam pacaran Perbedaan Umur itu gak penting, yg penting itu Perbedaan Kelamin.. Inget perbedaaan Kelamin..!!"
      "Anak muda itu bangun tidur langsung nyari HP, ngucapin selamat pagi juga harus disosmed... are u?"
      "Jomblo itu sumber dari segala kesepian. Jadi buat dukun yang suka bertapa ditempat sepi, ini bisa dimanfaatkan.."
      "Cie yg jelek ngarepin pacar yg cakep. Ngimpi~ ---"
      "Kentut terbaik adalah kentut dihadapan orang yang kita gak suka. (y)"
      "Lebih nyesek lagi kalo pacaran sama cewek yang lebih tua dari kita. Iya gitu, mau ciuman aja dikira mau nyium emaknya :'"
      "Berharap laptop gue berhubungan intim sama HP gue dan berharap mereka akan mempunyai anak iPad."
      "Kalo mau cari pasangan yg Ideal, jangan lupa 4B: Banyak Duit, Berusaha, Berdoa dan Bercerminlah...."
      "#SoSweet itu saat lo liat mantan lo lagi jalan sama pacar barunya dan pacarnya lebih jelek dari lo."
      "terkadang gue bodoh kaya patrick, mata duitan kaya mr.krab, bad mood kaya squidward, dan ceria kaya spongebob."
      "Mantan itu investasi jangka panjang, kalo kamu kehabisan stok, pergunakanlah mantan #salahbijak"
      "Pacaran: Tuker-tukeran coklat | LDR: Kirim-kiriman coklat | Jomblo: Tukeran Baygon.."
      "Baca aturan photoshop, jika jelek berlanjut, jangan foto-foto lagi"
      "tidur Mblo, kali aja bangun2 langsung punya pacar... #Eaaa"
      "Jangan salahkan pacar kamu mutusin kamu, salahkan aja diri kamu sendiri kenapa ga mutusin duluan?"
      "Jika mantan adalah masa lalu. Pacar adalah masa depan. Berarti selingkuhan adalah tantangan.."
      "Jomblo itu, daripada cari muka mulu, mendingan cari pacar gih #wejangan  #nasibJomblo"
      "Tuhan, jika dia memang bukan tercipta untukku, maka jangan pernah menciptakan dia di dunia ini :D"
      "Jomblo sejati itu menggunakan hari sabtu untuk tidur seharian  #nasibJomblo"
      "Jomblo nya awet banget. Di kontrak jomblo berapa tahun?  #nasibJomblo"
      "Jomblo yg udah lama itu tiap dapat kenalan yg baru langsung di PDKT in :|  #nasibJomblo"
      "Jomblo itu jangankan jodoh, pacar aja gak punya ┒(ˇ_ˇ)┎  #nasibJomblo"
      "Jomblo baru: Menggantung harapan | Jomblo lama: Menggantung diri. #nasibJomblo"
      "Bener-bener nyiksa diri ya kalo jalan ke mall malem minggu tanpa gandengan, #nasibJomblo"
      "Jomblo yg rajin itu pagi-pagi harus dan selalu udah online  #nasibJomblo"
      "baru pesen menu, blm makan udah kenyang duluan gegara liat org pacaran makan suap2an.. #nasibJomblo"
      "Jomblo itu manusia yg mandiri, karena kemana-mana selalu sendiri  #nasibJomblo"
      "Jomblo itu kalo pake AXE, yg turun bukan bidadari, melainkan hujan ┒(ˇ_ˇ)┎  #nasibJomblo"
      "Gelas aja ada yang ngisi, masa' hati Goe nggak ada yang ngisi mblo? #nasibJomblo"
      "Udh Jomblo, Malam Minggu, ujan deres, di rumah sendirian, tv kesamber petir, mending keluar aja biar kesambar petir sekalian."
      "Biar Jomblo tapi jangan patah samangat buat jalan di Malam Minggu, biar cuma ke pom isi bensin trus pulang tidur. :|"
      "Jomblo itu belom tentu siap menghadapi malem minggu, dia siapnya menghadapi malem begadang  #nasibJomblo"
      "Tuh kan, mending jadi jomblo, kemana aja gak ada yg larang, gak usah ijin dan gak ada yg nanyain, bener gak tuh?"
      "Jomblo itu ibarat twitter tanpa jomblo di twitter #hampa  #nasibJomblo"
      "GUE bingung kalo udah Malam Minggu, gue ngerasa kaya' Jomblo ~ padahal iya... :D"
      "Jomblo yg elegan itu, tidak modus sana-sini tapi dimodusin sana-sini  #nasibJomblo"
      "Jomblo itu bukan benci hari sabtu nya, tapi malem minggu nya itu lho ┒(ˇ_ˇ)┎  #nasibJomblo"
      "Mblo, kok sendirian aja? Kaya roda depan bajaj :D #nasibJomblo"
      "'Jomblo itu bahagia' itulah kata-kata mutiara bagi mereka yg suka menghibur diri  #nasibJomblo"
      "Jomblo biasanya sering insomnia. Karena gak ada yg ingetin tidur ┒(ˇ_ˇ)┎  #nasibJomblo"
      "Dear Jomblo.. Jangan lupa makan siang yg banyak. Biar nanti kuat ngadepin Malam Minggu. Sendirian. Sekali lagi, sendirian."
      "Jomblo itu jngn banyak begadang, banyakin PDKT sama gebetan  #nasibJomblo"
      "Jomblo sarapan dulu gih. Oh udah? Makan apa? Makan ati ya?  #nasibJomblo"
      "Jomblo itu jangan diledekin, nanti dia punah. Harus di lestarikan.  #nasibJomblo"
      "Sekarang malam jumat, besok malam sabtu, trus besoknya lagi malam senin... | he_eh.. *Jomblo gak kenal namanya Malam Minggu*"
      "Jomblo itu jangan banyak gombal buat dapetin gebetan, tapi banyakin itu duit  #nasibJomblo"
      "Jomblo itu suka cari perhatian, karna jomblo kurang diperhatikan.. #nasibJomblo"
      "Hari gini kok masih Jomblo, gak cape yah nonton bioskopnya sendirian mulu *pelukan sama bangku bioskop*"
      "Jomblo itu jgn terlalu sedih menghadapi malem minggu ini. Karena masih ada malming2 berikutnya yg lebih mengenaskan #nasibJomblo"
      "Jadi Jomblo itu bukan musibah, tapi ibadah, ibadah nahan hawa nafsu ~ #jombloMoveOn"
      "Jomblo itu dikasih 2 tangan agar saat kedinginan, bisa memeluk diri nya sendiri  #nasibJomblo"
      "Jujur ni Ya, Sebenernya Aqu Gak JOMBLO, Tapi aqu Ada lah SINGLE ~ #jombloMoveOn"
      "Nyesek itu ketika di mana kalian melihat Jomblo lain nya udah punya Mantan sedangkan kalian belum punya sama sekali.."
      "Jomblo itu percuma keluar malem minggu cari keramaian. Tetep aja hati nya sepi  #nasibJomblo"
      "Kamu jomblo, aku juga jomblo. Daripada kita iri liat orang pacaran, mending kayak mereka juga yuk ;)"
      "Jomblo itu kaya pembalap, karna naik motor nya gak pernah boncengan sama pacar  #nasibJomblo"
      "Jomblo itu memanfaatkan kesepian dan kesendirian ikut acara uji nyali..  #nasibJomblo"
      "Jomblo itu, daripada cari perhatian lebih baik cari pacar  #nasibJomblo"
    )

  pilih_bacotan
  tweet_status="$bacotan"
}

