#!/bin/bash

# plugin disabled, mungkin akan dihapus nanti

# aksi_array+=("twit_cekposting")

cekposting() {
  fail=$(cat temp/*_output | grep FAILED | wc -l)
  succ=$(cat temp/*_output | grep SUCCEEDED | wc -l)
  echo "[cekposting] s1=$1"

  if [[ "$fail" -gt 0 ]]; then
    echo "[cekposting-failed] -- coba reload cron + ulangi"
    /etc/init.d/cron reload
    ntpd -p 0.openwrt.pool.ntp.org
    rm temp/*_output
    if [[ -z "$1" ]]; then
      #tweet_status
      #cekposting
      echo "[cekposting] s1 kosong, nggak jelas"
    else
      if [[ "$1" = "status" ]]; then
        failed="1"
        echo "[cekposting] s1=status"
      fi
    fi
  else
    if [[ "$succ" -gt 0 ]]; then
      if [[ -z "$1" ]]; then
        echo "[cekposting-success] -- siip :)"
      else
        if [[ "$1" = "status" ]]; then
          failed="0"
        fi
      fi
    fi

  fi
}

if [[ "$1" = "cron" ]]; then
  echo "[cekposting-cron]"
  echo -n "[cekposting-cron] - Cek failed record.. "
  fail=$(cat /root/script/twit/temp/*_output | grep FAILED | wc -l)
  succ=$(cat /root/script/twit/temp/*_output | grep SUCCEEDED | wc -l)

  if [[ "$fail" -gt 0 ]]; then
    echo "$fail found.."
    echo "[cekposting-cron] - reloading crontab.. "
    /etc/init.d/cron reload
    ntpd -p 0.openwrt.pool.ntp.org
    rm /root/script/twit/temp/*_output

  else
    echo "not found.."
    echo -n "[cekposting-cron] - Cek succeeded record.. "
    if [[ "$succ" -eq 0 ]]; then
      echo "no recent succeeded post.."
      echo "[cekposting-cron] - reloading crontab.. "
      /etc/init.d/cron reload
      ntpd -p 0.openwrt.pool.ntp.org
      rm /root/script/twit/temp/*_output

    else
      if [[ "$succ" -gt 0 ]]; then
        echo "[cekposting-cron] - looks good.. :) "
      else
        echo "??"
        echo "something wrong here.."
        echo "[cekposting-cron] - reloading crontab.. "
        /etc/init.d/cron reload
        ntpd -p 0.openwrt.pool.ntp.org
        rm /root/script/twit/temp/*_output
      fi
    fi
  fi
  
echo "[cekposting-cron] - done.. "
fi

