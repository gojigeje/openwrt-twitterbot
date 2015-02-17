#!/usr/bin/python
"""
Script tweet sederhana untuk mengakases PTT (Python Twitter Tools)

  Penggunaan: python twit.py [opsi] [parameter]
  
  Opsi:
    -s ..., --status=...        isi tweet / status
    -i ..., --image=...         path gambar
    -d ..., --dm=...            isi direct message
    -u ..., --user=...          user, harus diisi bila opsi -d dipakai
    -h, --help                  tampilkan bantuan
  
  Contoh:
    twit.py -s "halo dunia!"                    posting tweet "halo dunia!" ke twitter
    twit.py -i "gbr.jpg"                        posting gambar "gbr.jpg" ke twitter
    twit.py -s "ini gambarku" -i "gbr.jpg"      posting tweet "ini gambarku" dan 
                                                    disertai gambar "gambar.jpg" ke twitter
    twit.py -u "gojigeje" -d "halo masbro!"     kirim dm ke @gojigeje
    
  NB:
    Isi parameter image bisa berupa relative path atau absolute path, sangat disarankan
    untuk mengisi parameter image dengan absolute path gambar agar meminimalisir eror. 
    Misalnya:   twit.py -i "/home/goji/Picture/image.jpg"
"""
__author__ = "Ghozy Arif Fajri (gojigeje@gmail.com)"
__version__ = "$Revision: 1.0 $"
__date__ = "$Date: 2015/02/12 21:19 WIB $"
__copyright__ = "Copyright (c) Ghozy Arif Fajri"
__license__ = "MIT"

from twitter import *
import sys
import getopt

# variabel global
status = ""
imagepath = ""
direct = ""
user = ""

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
        if direct or user:
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
        if status or imagepath: print("Error: opsi -d (direct) hanya bisa digunakan dengan opsi -u (user) saja")
        else:
            if direct and user:
                # print("kirim dm ke "+user+", isinya: "+direct)
                post_dm(user,direct)
            else:
                if user: print("opsi -u (user) harus disertai dengan opsi -d (direct)")
                else: print("opsi -d (direct) harus disertai dengan opsi -u (user)")

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
            opts, args = getopt.getopt(argv, "hs:i:d:u:", ["help", "status=", "image=", "dm=", "user="])
        except getopt.GetoptError:
            usage()
            sys.exit()
        for opt, arg in opts:
            if opt in ("-h", "--help"):
                usage()
                sys.exit()
            elif opt in ("-s", "--status"):
                global status
                status = arg
            elif opt in ("-i", "--image"):
                global imagepath
                imagepath = arg
            elif opt in ("-d", "--dm"):
                global direct
                direct = arg
            elif opt in ("-u", "--user"):
                global user
                user = arg
        
        proses()
    
main(sys.argv[1:])
