#!/bin/bash
#
# nama plugin : dhcp-router
# deksripsi   : script monitor dhcp table di router, posting client yang baru konek
# 
# cara pakai  : twit_dhcp
#
# keterangan  : dicoba dengan modem ADSL merek TP-LINK TD-W8951ND
#

# aksi_array+=("twit_dhcp")

twit_dhcp_main() {

  dhcptemp="temp/dhcp.table"
  dhcptoday="temp/dhcp.today.$tahun$bulan$tanggal"
  firsttime=false

  if [[ ! -f "$dhcptoday" ]]; then
    echo "[dhcp] file dhcp.today ga ada, bikin, hapus yg kemarin"
    rm temp/dhcp.today.* > /dev/null
    touch "$dhcptoday"

    firsttime=true
  fi

  echo "[dhcp] [$jam:$menit]"
  # get dhcp table
  echo "[dhcp] get dhcp table from router.."
  curl -s http://USER:PASSWORD@192.168.1.1/basic/home_dhcplist.htm > "$dhcptemp"
  sleep 2
  # once more, just to make sure
  curl -s http://USER:PASSWORD@192.168.1.1/basic/home_dhcplist.htm > "$dhcptemp"

  # format
  echo "[dhcp] format it.."
  tr -d '\n\r' < "$dhcptemp" | sed 's/<td align="center" class="tabdata">/\n&/g;s/&nbsp; //g;s/<\/td>/<\/td>\n&/g' | grep "align=\"center\" class=\"tabdata\"" | sed "s/<[^>]\+>/ /g;s/[ \t]*//$g;s/ //g" | paste -d " " - - - - > "$dhcptemp.format"
  # group 4 line
  # awk '{ printf "%s ", $0 } !(NR%4) { print "" }' --> http://stackoverflow.com/questions/16906437/#comment24400792_16906497
  # paste -d " " - - - -  --> http://www.unixcl.com/2008/04/combine-every-3-lines-as-one-awk.html?#c8773357981019229365

  jumclient=$(cat "$dhcptemp.format" | wc -l)

  if $firsttime; then
    status="[router-watch] start monitoring Router's DHCP Table (192.168.1.1) ~ currently $jumclient client(s) connected.."
    echo "[dhcp] [twit] $status"
    twit -s "$status"

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

      ip=$(echo "$line" | cut -d " " -f2)
      mac=$(echo "$line" | cut -d " " -f3)
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
        status="[router-watch] New client connected! ~ $host ($ip / $macs / $lease) ~ total: $jumclient client(s)"

        echo "[dhcp] [twit] $status"
        twit -s "$status"

        # masukin line ke file today
        echo "$line" >> "$dhcptoday"
        sleep 2

      fi

      let num++;
    done

  fi

  # clean up
  rm temp/dhcp.table*

  exit 
}
