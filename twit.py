#!/usr/bin/python
"""
Script tweet sederhana untuk mengakases PTT (Python Twitter Tools)

  Penggunaan: python twit.py [opsi] [parameter]
  
  Opsi:
    -s ..., --status=...        isi tweet / status
    -i ..., --image=...         path gambar
    -d ..., --dm=...            isi direct message, harus disertai dengan -u
    -u ..., --user=...          user target direct message
    -f ..., --follow=...        follow user
    -l ..., --leave=...         unfollow user
            --follower=...      cek apakah user merupakan follower dari bot
            --following=...     cek apakah bot memfollow user
    -h, --help                  tampilkan bantuan
  
  Contoh:
    twit.py -s "halo dunia!"                    posting tweet "halo dunia!" ke twitter
    twit.py -i "gbr.jpg"                        posting gambar "gbr.jpg" ke twitter
    twit.py -s "ini gambarku" -i "gbr.jpg"      posting tweet "ini gambarku" dan 
                                                    disertai gambar "gambar.jpg" ke twitter
    twit.py -u "gojigeje" -d "halo masbro!"     kirim DM ke @gojigeje, isinya "halo masbro!"

  NB:
    Isi parameter image bisa berupa relative path atau absolute path, sangat disarankan
    untuk mengisi parameter image dengan absolute path gambar agar meminimalisir eror. 
    Misalnya:   twit.py -i "/home/goji/Picture/image.jpg"
"""
__author__ = "Ghozy Arif Fajri <gojigeje@gmail.com>"
__contact__ = "@gojigeje on twitter"
__version__ = "$Revision: 1.1 $"
__date__ = "$Date: 2015/02/18 12:53 WIB $"
__copyright__ = "Copyright (c) Ghozy Arif Fajri"
__license__ = "MIT"

from twitter import *
import sys
import getopt

# variabel global
status = imagepath = direct = user = follow = leave = tipe = target = ""

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

    if status or imagepath:
        if direct or user or follow or leave or tipe:
            if status: print("Error: opsi -s hanya bisa digunakan dengan opsi -i saja")
            else: print("Error: opsi -i hanya bisa digunakan dengan opsi -s saja")
        else:
            if status and imagepath:
                # print("twit status: "+status+", dengan gambar: "+imagepath)
                post_image(status,imagepath)
            elif status and not imagepath:
                # print("twit status aja: "+status)
                post_status(status)
            elif imagepath and not status:
                # print("twit gambar aja: "+imagepath)
                post_image("",imagepath)

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
        else:
            # print("cek apakah bot following "+target)
            isfollowing = t.friendships.show(source_screen_name=target, target_screen_name=botUsername)["relationship"]["target"]["following"]
            print(isfollowing)

    else:
        usage()
        
def post_status(st):
    t.statuses.update(status=st)
    # print("upload status: "+st)

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

def main(argv):
    if not argv:
        usage()
    else:
        try:
            opts, args = getopt.getopt(argv, "hs:i:d:u:f:l:", ["help", "status=", "image=", "dm=", "user=", "follow=", "leave=", "follower=", "following="])
        except getopt.GetoptError:
            usage()
            sys.exit()
        for opt, arg in opts:
            global status, imagepath, direct, user, follow, leave, target, tipe

            if opt in ("-h", "--help"):
                usage()
                sys.exit()
            elif opt in ("-s", "--status"):
                status = arg
            elif opt in ("-i", "--image"):
                imagepath = arg
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

        proses()
    
main(sys.argv[1:])
