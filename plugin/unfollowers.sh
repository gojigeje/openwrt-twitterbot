#!/bin/bash
#
# nama plugin : unfollowers
# deksripsi   : twit statistik follower ngaco
# 
# cara pakai  : twit_unfollowers
#
# keterangan  : nothing special
#

aksi_array+=("twit_unfollowers")

# main method
twit_unfollowers_main() {
  # set tweet_status
  tweet_status="Today stats: $((RANDOM%300+100)) new followers, $((RANDOM%100)) unfollowers and followed $((RANDOM%100)) people via Unfollowers.com/?s=@gojigeje"
}
