#!/bin/bash
#
# nama plugin : trending
# deksripsi   : twit 4 trending topic terbaru
#               default menampilkan trendi Indonesia, sesuaikan dengan mengubah WOEID
# 
# cara pakai  : twit_trending [WOEID]
#

aksi_array+=("twit_trending")

# main method
twit_trending_main() {
  if [[ -z "$1" ]]; then
    woeid="23424846"
  else
    woeid="$1"
  fi

  getJam

  echo "[trending] [$getjam] get 4 top trending.."

  # get 4 top trending
  twit --trending=23424846 | sed 's/trends/top 4 trending ['$getjam']/g' | head -n 5 > "temp/trending.output"

  cat "temp/trending.output"

  # twit it
  twit -s "`cat temp/trending.output`"

  echo "[trending] done.."

  exit
  # very simple :|
}

