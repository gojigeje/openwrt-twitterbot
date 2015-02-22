openwrt-twitterbot
==================

A collection of bash script used on my OpenWRT-based router for generating twitter status posted by python twitter tools (PTT).

Koleksi script bash yang digunakan pada router OpenWRT saya untuk membuat status twitter yang kemudian dikirimkan oleh PTT.

####Dependency
Python Twitter Tools (https://github.com/sixohsix/twitter) must be installed properly authorized

PTT harus sudah terinstall dan di *authorize* dengan benar

####Check twit.py first!
Input your app's *consumerKey*, *consumerSecret*, your *accessToken*, *accessTokenSecret* and your bot username to this script, and you're ready to go!

Masukan token, key dan username bot di twit.py

####Script Structure
The main script is *tweet.sh*, basically what it does is to randomly choose available/enabled plugins, the chosen plugin then generate status text, and then tweet.sh posted it to twitter through twit.py

Script utamanya adalah *tweet.sh*, yang dilakukan script ini sebenarnya hanya memilih plugin yang di-enable, plugin tersebut lalu membuat teks status, kemudian tweet.sh mengirimkannya ke twitter lewat script twit.py

ruwet ya? :D

####Plugins
Various plugins available, check on "plugin" folder.

Ada macem-macem plugin, periksa satu-satu di folder "plugin".

####How to directly call a particular plugin
Run ` tweet.sh [plugin_name] [parameter]`. The *plugin_name* is the content of ` aksi_array ` on each plugin.

Jalankan ` tweet.sh [plugin_name] [parameter]`. *plugin_name* adalah isi dari ` aksi_array ` di masing-masing script plugin. 