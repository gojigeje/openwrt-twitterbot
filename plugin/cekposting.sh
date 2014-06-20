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

if [[ ! -z "$1" ]]; then
  if [[ "$1" = "cron" ]]; then
    echo "[cekposting-cron]"
    echo -n "[cekposting-cron] - Cek failed record.. "
    fail=$(cat /root/script/twit/temp/*_output | grep FAILED | wc -l)
    succ=$(cat /root/script/twit/temp/*_output | grep SUCCEEDED | wc -l)

    if [[ "$fail" -gt 0 ]]; then
      echo "$fail found.."
      echo "[cekposting-cron] - reloading crontab.. "
      /etc/init.d/cron reload
      rm /root/script/twit/temp/*_output

    else
      echo "not found.."
      echo -n "[cekposting-cron] - Cek succeeded record.. "
      if [[ "$succ" -eq 0 ]]; then
        echo "no recent succeeded post.."
        echo "[cekposting-cron] - reloading crontab.. "
        /etc/init.d/cron reload
        rm /root/script/twit/temp/*_output

      else
        echo "??"
        echo "something wrong here.."
      fi
    fi
    
  fi
  echo "[cekposting-cron] - done.. "
fi
