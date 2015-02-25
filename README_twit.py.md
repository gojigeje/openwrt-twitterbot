#twit.py
A simple python script to access twitter using Python Twitter Tools library ([python-twitter](https://github.com/sixohsix/twitter)).

####Install Python Twitter Tools Library
To use PTT, you need to install Python Twitter Tools (https://github.com/sixohsix/twitter) first.

    easy_install twitter

####Get Acces Token and Consumer Key
You need to create an app account on https://dev.twitter.com/apps

1. Sign in with your Twitter account
2. Create a new app account
3. Modify the settings for that app account to allow read & write
4. Generate a new OAuth token with those permissions
5. Put those tokens in the **twit.py** script

Then you need to copy twit.py script to ` /usr/bin/twit ` and give it executable permission so we can run it globally by calling ` twit ` command:
    
    cp twit.py /usr/bin/twit
    chmod +x /usr/bin/twit

*Install PTT > Buat App > Generate OAuth Token > Masukan token dan key di script __twit.py__ > lalu copy twit.py ke /usr/bin/twit > beri permission*

Test the setup, try to post some tweet:

    twit -s "hello world!"

If tweet sent succesfully, then everything should be working fine :smile:

##Dokumentasi

####Penggunaan
    python twit.py [opsi] [parameter]
  
####Opsi
    -s ..., --status=[isi]          isi tweet / status
    -i ..., --image=[path]          path gambar
    -r ..., --reply=[id]            id tweet yang akan direply, harus disertai dengan -s
                                      sebagai isi dari reply nya
    -d ..., --dm=[isi]              isi direct message, harus disertai dengan -u
    -u ..., --user=[user]           [user] target direct message
    
    -f ..., --follow=[user]         follow [user]
    -l ..., --leave=[user]          unfollow [user]
            --follower=[user]       cek apakah [user] merupakan follower dari bot
            --following=[user]      cek apakah bot memfollow [user]
    
            --search=[query]        search tweet yang sesuai dengan [query]
            --auto-rt=[query]       otomatis RT tweet yang sesuai dengan [query]
            --auto-fav=[query]      otomatis FAV tweet yang sesuai dengan [query]
            --limit=[1-100]         jumlah tweet yang akan diproses dalam 'search' dan 'auto-*'
            --lang=[code]           bahasa tweet yang akan diproses dalam 'search' dan 'auto-*'
                                      [kode] mengacu pada 'ISO 639-1' / kode bahasa 2 huruf
    
            --trending=[code]       tampilkan 10 trending topic di lokasi [code]
                                      [code] mengacu pada WOEID / 'Where On Eath ID'

    -h, --help                      tampilkan bantuan
  

####Contoh Penggunaan

**Posting tweet berupa teks biasa**

    twit.py -s "halo dunia!"

**Posting tweet berupa gambar**

    twit.py -i "gbr.jpg"

**Posting tweet berupa teks disertai gambar**

    twit.py -s "ini gambarku" -i "gbr.jpg"

**Kirim DM ke @gojigeje, isinya 'halo masbro!'**

    twit.py -u "gojigeje" -d "halo masbro!"

====

###Keterangan Tambahan
#####-s, --status
Selain mengirim tweet biasa, opsi ini juga bisa digunakan untuk mengirim DM tanpa harus menggunakan opsi -d dan -u. Caranya adalah dengan mengawali isi status dengan huruf 'D' atau 'M' lalu harus langsung diikuti dengan username target DM.

    twit.py -s "D @gojigeje halo gan!"
    twit.py -s "M @gojigeje halo gan!"

*> kirim DM ke @gojigeje dengan isi 'halo gan!'*

#####-i, --image
Isi parameter -i (image) bisa berupa relative path atau full path, sangat disarankan untuk mengisi parameter image dengan full path gambar agar meminimalisir eror. 
    
    twit.py -i "/home/goji/Picture/image.jpg"

*> posting gambar dengan full path*

#####--search, --auto-rt, --auto-fav
Format [query] yang digunakan sudah mendukung Query Operators twitter search.  Baca [Query Operators](https://dev.twitter.com/rest/public/search) sebagai referensi.

    twit.py --search="-filter:retweets -from:blacklist openwrt OR router"

*> search tweet yang bukan merupakan retweet, bukan tweet yang dikirim oleh user @blacklist, mengandung kata openwrt atau router*

#####--limit
Bila opsi ini tidak diisi saat melakukan search / auto-*, secara default akan ditampilkan sebanyak 15 hasil. Twitter membatasi hasil search maksimal sebanyak 100 hasil.

    twit.py --search="[query]" --limit=50

*> membatasi hasil pencarian menjadi sebanyak 50 tweet*

#####--lang
Kode bahasa mengacu pada 'ISO 639-1' / kode bahasa 2 huruf. Baca [wikipedia](http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) sebagai referensi.

    twit.py --search="[query]" --lang="id"

*> search tweet tentang [query] yang ditulis dengan bahasa indonesia*

#####--trending
[code] mengacu pada WOEID / 'Where On Eath ID'. Baca [Yahoo! GeoPlanet](https://developer.yahoo.com/geo/geoplanet/) atau cari kode secara manual di [Yahoo! WOEID Lookup](http://zourbuth.com/tools/woeid/).

    twit.py --trending=23424846

*> tampilkan 10 trending topic di wilayah Indonesia*

Berikut adalah beberapa kode WOEID yang saya himpun per 2015/02/25 11:52 WIB

    23424846 = Indonesia    
    1047180  = Bandung      
    1030077  = Bekasi       
    1032539  = Depok        
    1047378  = Jakarta      
    1046138  = Makassar     
    1047908  = Medan        
    1048059  = Palembang    
    1040779  = Pekanbaru    
    1048324  = Semarang     
    1044316  = Surabaya     
    1048536  = Tangerang    

    1        = Worldwide                 23424873 = Lebanon
    23424740 = Algeria                   23424901 = Malaysia
    23424747 = Argentina                 23424900 = Mexico
    23424748 = Australia                 23424909 = Netherlands
    23424750 = Austria                   23424916 = New Zealand
    23424753 = Bahrain                   23424908 = Nigeria
    23424765 = Belarus                   23424910 = Norway
    23424757 = Belgium                   23424898 = Oman
    23424768 = Brazil                    23424922 = Pakistan
    23424775 = Canada                    23424924 = Panama
    23424782 = Chile                     23424919 = Peru
    23424787 = Colombia                  23424934 = Philippines
    23424796 = Denmark                   23424923 = Poland
    23424800 = Dominican Republic        23424925 = Portugal
    23424801 = Ecuador                   23424935 = Puerto Rico
    23424802 = Egypt                     23424930 = Qatar
    23424819 = France                    23424936 = Russia
    23424829 = Germany                   23424938 = Saudi Arabia
    23424824 = Ghana                     23424948 = Singapore
    23424833 = Greece                    23424942 = South Africa
    23424834 = Guatemala                 23424950 = Spain
    23424848 = India                     23424954 = Sweden
    23424846 = Indonesia                 23424957 = Switzerland
    23424803 = Ireland                   23424960 = Thailand
    23424852 = Israel                    23424969 = Turkey
    23424853 = Italy                     23424976 = Ukraine
    23424856 = Japan                     23424738 = United Arab Emirates
    23424860 = Jordan                    23424975 = United Kingdom
    23424863 = Kenya                     23424977 = United States
    23424868 = Korea                     23424982 = Venezuela
    23424870 = Kuwait                    23424984 = Vietnam
    23424874 = Latvia                

##Berkontribusi
*Saya yakin masih banyak terdapat bug di project ini, selain hanya dicoba di router pribadi, dalam proses pembuatannya juga tidak terdokumentasi dengan baik. Silahkan fork, oprek dan kirim pull request. Laporkan bug atau eror di tab [issue](https://github.com/gojigeje/openwrt-twitterbot/issues).*

*Atau diskusikan dengan saya di twitter saya [@gojigeje](https://twitter.com/gojigeje), terima kasih :smile:*