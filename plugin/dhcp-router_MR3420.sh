#!/bin/bash
#
# nama plugin : dhcp-router
# deksripsi   : script monitor dhcp table di router, posting client yang baru konek
# 
# cara pakai  : twit_dhcp2
#
# keterangan  : dicoba dengan 3G router merek TP-LINK MR3420
#

# aksi_array+=("twit_dhcp2")

twit_dhcp2_main() {

  dhcptemp="temp/dhcp.2.temp"
  dhcptoday="temp/dhcp.2.today.$tahun$bulan$tanggal"
  firsttime=false

  if [[ ! -f "$dhcptoday" ]]; then
    echo "[dhcp] file dhcp.2.today ga ada, bikin, hapus yg kemarin"
    rm temp/dhcp.2.today.* > /dev/null
    touch "$dhcptoday"

    firsttime=true
  fi

  echo "[dhcp] [$jam:$menit]"
  # get dhcp table
  echo "[dhcp] get dhcp table from router.."
  curl -s http://USER:PASSWORD@192.168.2.1/userRpm/AssignedIpAddrListRpm.htm > "$dhcptemp"
  sleep 2
  # once more, just to make sure
  curl -s http://USER:PASSWORD@192.168.2.1/userRpm/AssignedIpAddrListRpm.htm > "$dhcptemp"

  # format
  echo "[dhcp] format it.."

  jumclient=$(cat "$dhcptemp" | sed -n "/var DHCPDynPara/,/);/p" | sed -n 2p | sed 's/[^0-9]//')
  maxline=$(( $jumclient + 2 ))

  cat "$dhcptemp" | sed -n "3,$maxline"p | sed 's/[",]//g' > "$dhcptemp.format"

  if $firsttime; then
    echo "[router-watch]" > "$dhcptemp.twit"
    echo "[TL-MR3420][MLG]" >> "$dhcptemp.twit"
    echo "" >> "$dhcptemp.twit"
    echo "Start monitoring Router's DHCP Table (TL-MR3420/192.168.2.1) ~ currently $jumclient client(s) connected.." >> "$dhcptemp.twit"

    cat "$dhcptemp.twit"
    twit -s "`cat $dhcptemp.twit`"

    # isi file today
    cat "$dhcptemp.format" > "$dhcptoday"
  else
    
    # compare
    echo "[dhcp] compare.."
    grep -Fvf "$dhcptoday" "$dhcptemp.format" > "$dhcptemp.new"

    # check..

    client=$(cat "$dhcptemp.new" | wc -l)
    max=$(( $client + 1 ))
    num=1

    if [[ $client -gt 0 ]]; then
      echo "[dhcp] $client clients found!"
    else
      echo "[dhcp] No new client.."
    fi

    while [[ $num -lt $max ]]; do
      
      line="`sed -n "$num"p $dhcptemp.new`"

      host=$(echo "$line" | cut -d " " -f1)
      if [[ $host == "&nbsp;" ]]; then
        host="unknown?"
      fi

      ip=$(echo "$line" | cut -d " " -f3)
      mac=$(echo "$line" | cut -d " " -f2)
      lease=$(echo "$line" | cut -d " " -f4)
      macs=$(echo "$mac" | sed 's/[A-Z0-9].$/XX/g')

      # tabel dhcp kosong
      if [[ $ip == "&nbsp;" ]]; then
        break
      fi

      if grep -q "$mac" "$dhcptoday" ; then
        echo "[dhcp] $mac udah ada di file today.."
      else
        echo "[dhcp] $mac belum ada ada di file today.."
        
        echo "[router-watch]" > "$dhcptemp.twit"
        echo "[TL-MR3420][MLG]" >> "$dhcptemp.twit"
        echo "" >> "$dhcptemp.twit"
        echo "New client connected!" >> "$dhcptemp.twit"
        echo "$host, $macs, $ip" >> "$dhcptemp.twit"
        echo "total: $jumclient client(s)" >> "$dhcptemp.twit"
        
        cat "$dhcptemp.twit"
        twit -s "`cat $dhcptemp.twit`"

        # masukin line ke file today
        echo "$line" >> "$dhcptoday"
        sleep 2

      fi

      let num++;
    done

  fi

  # clean up
  rm temp/dhcp.2.temp*

  exit 
}
