#!/usr/bin/python
"""
  +------------------------------------------------------------------------+
  | twit.py ~ Script sederhana untuk mengakases PTT (Python Twitter Tools) |
  +------------------------------------------------------------------------+
  
  Penggunaan: python twit.py [opsi] [parameter]
  
  Opsi:
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
                                      [code] mengacu pada 'ISO 639-1' / kode bahasa 2 huruf

            --trending=[code]       tampilkan 10 trending topic di lokasi [code]
                                      [code] mengacu pada WOEID / 'Where On Eath ID'

    -h, --help                      tampilkan bantuan
  
  Panduan lebih lengkap bisa dibaca di:
    https://github.com/gojigeje/openwrt-twitterbot/blob/master/README_twit.py.md
"""
__author__ = "Ghozy Arif Fajri <gojigeje@gmail.com>"
__contact__ = "@gojigeje on twitter"
__version__ = "$Revision: 1.2 $"
__date__ = "$Date: 2015/02/25 12:09 WIB $"
__copyright__ = "Copyright (c) Ghozy Arif Fajri"
__license__ = "MIT"

from twitter import *
import sys
import getopt

# variabel global
status = imagepath = direct = user = follow = leave = tipe = target = reply = query = limit = lang = woeid = ""

# username akun bot, tanpa @
botUsername = "gojibox"

# key dan token app anda
consumerKey = ""
consumerSecret = ""
accessToken = ""
accessTokenSecret = ""
t = Twitter(auth=OAuth(accessToken, accessTokenSecret, consumerKey, consumerSecret))

def usage():
    print __doc__

def proses():

    if status or imagepath or reply:
        if direct or user or follow or leave or tipe:
            if status:
                print("Error: opsi -s hanya bisa digunakan dengan opsi -i saja")
            elif imagepath: 
                print("Error: opsi -i hanya bisa digunakan dengan opsi -s saja")
            else: 
                print("Error: opsi -r hanya bisa digunakan dengan opsi -s saja")
        else:
            if status and imagepath and reply:
                print("Error: opsi -r hanya bisa digunakan dengan opsi -s saja")
            elif status and imagepath and not reply:
                # print("twit status: "+status+", dengan gambar: "+imagepath)
                post_image(status,imagepath)
            elif status and reply:
                # print("twit reply ke : "+reply+", dengan status : "+status)
                post_reply(reply,status)
            elif imagepath and reply:
                print("Error: opsi -r hanya bisa digunakan dengan opsi -s saja")
            elif status and not imagepath and not reply:
                # print("twit status aja: "+status)
                post_status(status)
            elif imagepath and not status and not reply:
                # print("twit gambar aja: "+imagepath)
                post_image("",imagepath)
            elif reply and not imagepath or status:
                print("Error: opsi -r harus digunakan dengan opsi -s")

    elif direct or user:
        if status or imagepath or follow or leave or tipe:
            if direct: print("Error: opsi -d (direct) hanya bisa digunakan dengan opsi -u (user) saja")
            else : print("Error: opsi -u (user) hanya bisa digunakan dengan opsi -d (direct) saja")
        else:
            if direct and user:
                # print("kirim dm ke "+user+", isinya: "+direct)
                post_dm(user,direct)
            else:
                if user: print("opsi -u (user) harus disertai dengan opsi -d (direct)")
                else: print("opsi -d (direct) harus disertai dengan opsi -u (user)")

    elif follow or leave:
        if follow and leave or tipe:
            if follow: print("Error: opsi -f (follow) tidak bisa digunakan dengan opsi lain")
            else: print("Error: opsi -l (leave) tidak bisa digunakan dengan opsi lain")
        else:
            if follow:
                # print("follow : "+follow)
                t.friendships.create(screen_name=follow, follow=True)
            else:
                # print("leave : "+leave)
                t.friendships.destroy(screen_name=leave)

    elif tipe:
        if tipe == "follower":
            # print("cek apakah "+target+" follower dari bot")
            isfollower = t.friendships.show(source_screen_name=botUsername, target_screen_name=target)["relationship"]["target"]["following"]
            print(isfollower)
        elif tipe == "following":
            # print("cek apakah bot following "+target)
            isfollowing = t.friendships.show(source_screen_name=target, target_screen_name=botUsername)["relationship"]["target"]["following"]
            print(isfollowing)
        elif tipe == "search":
            # print("Search tweets matching : '"+query+"'")
            post_search(query,limit,lang)
        elif tipe == "autort":
            # print("Auto RT tweets matching : '"+query+"'")
            auto_rt(query,limit,lang)
        elif tipe == "autofav":
            # print("Auto FAV tweets matching : '"+query+"'")
            auto_fav(query,limit,lang)
        elif tipe == "trending":
            # print("Auto FAV tweets matching : '"+query+"'")
            get_trends(woeid)

    else:
        usage()
        
def post_status(st):
    t.statuses.update(status=st)
    # print("upload status: "+st)

def post_reply(twid,st):
    t.statuses.update(in_reply_to_status_id=twid,status=st)
    # print("upload reply ke : "+twid+", status : "+st)

def post_image(st,im):
    if not st:
        # print("upload image: "+im)
        with open(im, "rb") as imagefile:
            params = {"media[]": imagefile.read(), "status": ""}
    else:
        with open(im, "rb") as imagefile:
            params = {"media[]": imagefile.read(), "status": st}
        # print("upload status: "+st+" dan image: "+im)

    with open(im, "rb") as im:
        t.statuses.update_with_media(**params)

def post_dm(u,dm):
    t.direct_messages.new(
        user=u,
        text=dm)

def search_tweets(q, count, lang, result_type="recent"):
    # print("q: "+q)
    # print("lang: "+lang)
    # print("counts: "+str(count))
    # print("result_type: "+str(result_type))
    return t.search.tweets(q=q, result_type=result_type, count=count, lang=lang)

def post_search(q,limit,lang):
    result = search_tweets(q,limit,lang)
    for tweet in result["statuses"]:
        print("%s" % (tweet["id_str"]+" @"+tweet["user"]["screen_name"]+" "+tweet["text"]).encode("utf-8").replace("\n", " "))

def auto_rt(q,limit,lang):
    result = search_tweets(q,limit,lang)

    for tweet in reversed(result["statuses"]):
        try:
            # jangan rt twit sendiri
            if tweet["user"]["screen_name"] == botUsername:
                continue

            result = t.statuses.retweet(id=tweet["id"])
            print("[auto-rt] %s" % ("@"+tweet["user"]["screen_name"]+" "+tweet["text"]).encode("utf-8").replace("\n", " "))

        # kalau tweet sudah pernah di rt, print error
        except TwitterHTTPError as e:
            print("error: %s" % (str(e)))

def auto_fav(q,limit,lang):
    result = search_tweets(q,limit,lang)

    for tweet in reversed(result["statuses"]):
        try:
            # jangan fav twit sendiri
            if tweet["user"]["screen_name"] == botUsername:
                continue

            result = t.favorites.create(_id=tweet["id"])
            print("[auto-fav] %s" % ("@"+tweet["user"]["screen_name"]+" "+tweet["text"]).encode("utf-8").replace("\n", " "))

        # kalau tweet sudah pernah di fav, print error
        except TwitterHTTPError as e:
            print("error: %s" % (str(e)))

def get_trends(woeid):
    result = t.trends.place(_id=woeid)

    location = result[0]["locations"]
    print(location[0]["name"]+" trends:")

    trending = result[0]["trends"]
    for tweet in trending:
        print(tweet["name"].encode("utf-8")) 

def main(argv):
    if not argv:
        usage()
    else:
        try:
            opts, args = getopt.getopt(argv, "hs:i:r:d:u:f:l:", ["help", "status=", "image=", "reply=", "dm=", "user=", "follow=", "leave=", "follower=", "following=", "search=", "limit=", "lang=", "auto-rt=", "auto-fav=", "trending="])
        except getopt.GetoptError:
            usage()
            sys.exit()
        for opt, arg in opts:
            global status, imagepath, direct, user, follow, leave, target, tipe, reply, query, limit, lang, woeid

            if opt in ("-h", "--help"):
                usage()
                sys.exit()
            elif opt in ("-s", "--status"):
                status = arg
            elif opt in ("-i", "--image"):
                imagepath = arg
            elif opt in ("-r", "--reply"):
                reply = arg
            elif opt in ("-d", "--dm"):
                direct = arg
            elif opt in ("-u", "--user"):
                user = arg
            elif opt in ("-f", "--follow"):
                follow = arg
            elif opt in ("-l", "--leave"):
                leave = arg
            elif opt in ("--follower"):
                target = arg
                tipe = "follower"
            elif opt in ("--following"):
                target = arg
                tipe = "following"
            elif opt in ("--search"):
                query = arg
                tipe = "search"
            elif opt in ("--limit"):
                limit = arg
            elif opt in ("--lang"):
                lang = arg
            elif opt in ("--auto-rt"):
                query = arg
                tipe = "autort"
            elif opt in ("--auto-fav"):
                query = arg
                tipe = "autofav"
            elif opt in ("--trending"):
                woeid = arg
                tipe = "trending"

        proses()
    
main(sys.argv[1:])
