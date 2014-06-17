#!/bin/bash

# aksi_array+=("twit_cekposting")

cekposting() {
  fail=$(cat temp/*_output | grep FAILED | wc -l)

  if [[ "$failed" -gt 0 ]]; then
    echo "[posting-cek-failed] -- coba reload cron + ulangi"
    /etc/init.d/cron reload
    rm temp/*_output
    if [[ -z "$1" ]]; then
      tweet_status
      cekposting
    else
      if [[ "$1" = "status" ]]; then
        failed="1"
      fi
    fi
  else
    if [[ -z "$1" ]]; then
      echo "[posting-cek-success] -- siip :)"
    else
      if [[ "$1" = "status" ]]; then
        failed="0"
      fi
    fi
  fi
}
