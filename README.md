#openwrt-twitterbot
A collection of bash script used on my OpenWRT-based router for generating twitter status, and then post the status to twitter using python twitter tools (PTT).

The bot's twitter account: [@gojibox](https://twitter.com/gojibox)

*Koleksi script bash yang digunakan pada router OpenWRT saya untuk membuat status twitter yang kemudian diposting ke twitter menggunakan PTT.*

##Dependency
You need to install bash on your awesome OpenWRT powered router, as this script mainly written in bash. And some other additional package like curl and wget.

    opkg install bash curl wget sed

To use PTT, you need to install Python Twitter Tools (https://github.com/sixohsix/twitter) first.

    easy_install twitter

You will also need to create an app account on https://dev.twitter.com/apps

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

##Script Structure
The main script is ` tweet.sh `, basically what it does is to randomly select available/enabled plugins, the selected plugin then generate status text (or doing something else), and then tweet.sh posted it to twitter through twit.py

*Script utamanya adalah ` tweet.sh `, yang dilakukan script ini sebenarnya hanya memilih secara acak plugin yang di-enable, plugin tersebut lalu membuat teks status, kemudian tweet.sh mengirimkannya ke twitter lewat script twit.py*

*ruwet ya? :smile:*

####How to run the script?
By running the main script, try to run multiple time and it should display different output on each run (because the random selection of plugin)

    ./tweet.sh

*Dengan menjalankan script utama, coba jalankan beberapa kali. Script akan menampilkan output berbeda setiap kali dijalankan (karena plugin yang dipilih secara acak)*

##Plugins
Various plugins available, check on "plugin" folder. You can create your own plugin by following the guide written on ` plugin/1_template.sh ` file.

*Ada bermacam-macam plugin, periksa di folder "plugin". Anda bisa membuat plugin sendiri dengan mengikuti panduan yang tertulis di file ` plugin/1_template.sh `*

####How to disable / enable plugin?
The term *disable* or *enable* here is actually means *to include or not to include* a plugin on random selection process by main script (tweet.sh). You can exclude a plugin by commenting this line on each plugin:

    # aksi_array+=("twit_xxxx")

By doing that, that particular plugin won't be executed when running the main script.

*Maksud dari enable dan disable di sini sebenarnya adalah menyertakan atau tidak menyertakan sebuah plugin pada proses pemilihan secara acak oleh script utama. Untuk tidak menyertakan sebuah plugin, beri koemntar pada baris tersebut.*

####How to run / execute disabled plugin?
A disabled plugin still can be executed by directly calling its name as main script's parameter. Assuming that you have disabled ` twit_xxxx ` plugin from before, you can call it like this:

    ./tweet.sh twit_xxxx

And that plugin will be executed despite being disabled. You can do this if you want to override the random selection process in main script or if you want to call a particular plugin.

*Plugin yang didisable masih bisa dijalankan dengan memanggilnya nama plugin sebagai parameter script utama. Anda bisa menggunakan cara ini untuk memanggil plugin tertentu secara langsung / melewati proses pemilihan acak.*

##Berkontribusi
*Saya yakin masih banyak terdapat bug di project ini, selain hanya dicoba di router pribadi, dalam proses pembuatannya juga tidak terdokumentasi dengan baik. Silahkan fork, oprek dan kirim pull request. Laporkan bug atau eror di tab [issue](https://github.com/gojigeje/openwrt-twitterbot/issues).*

*Atau diskusikan dengan saya di twitter saya [@gojigeje](https://twitter.com/gojigeje), terima kasih :smile:*
