#!/bin/bash

# aksi_array+=("twit_imsakiyah")

# main method
twit_imsakiyah_main() {

  if [[ -z "$1" ]]; then
    echo "mlg|tag ?"
    exit 1
  else
    if [[ "$2" == "ramadhan" ]]; then
      if [[ "$1" = "mlg" ]]; then
        kota="Malang"
        key="malang"
        url="http://www.rukyatulhilal.org/imsakiyah/index.php?id=210"
      fi
      if [[ "$1" = "tag" ]]; then
        kota="Tulungagung"
        key="tulungagung"
        url="http://www.rukyatulhilal.org/imsakiyah/index.php?id=466"
      fi
      prefix="imsakiyah"
    else
      if [[ "$1" = "mlg" ]]; then
        kota="Malang"
        key="mlg"
        url="http://www.jadwalsholat.org/adzan/monthly.php?id=141"
      fi
      if [[ "$1" = "tag" ]]; then
        kota="Tulungagung"
        key="tag"
        url="http://www.jadwalsholat.org/adzan/monthly.php?id=295"
      fi
      prefix="jadwal-sholat"
    fi
  fi

  ayosholat_array=(
      "Ayo kita makmurkan masjid dg sholat jamaah di masjid :)"
      "Ingatkan orang terdekat untuk Sholat.. :)"
      "Mari kita jaga ibadah Sholat kita :)"
      "Perbagus Sholat kita, Allah akan dipermudah urusan kita :)"
      "Sholat adalah tiang agama, tegakkanlah :)"
      "Sholat berjamaah jauh lebih baik :)"
      "Sholat di awal waktu jauh lebih baik :)"
      "Sholat jamaah di masjid yuk :)"
      "Sholat sendiri = cakep 50% | Sholat jamaah = cakep 100% :D"
      "Sholat bikin kita SELAMAT.. SEHAT.. dan HEBAT.. :)"
      "Sibuk bukan alasan untuk meninggalkan sholat, gaaees.. :)"
      "Hati gundah? Galau?.. obati dengan sholat.. :)"
    )
  ayosholat_num=${#ayosholat_array[*]}
  ayosholat=${ayosholat_array[$((RANDOM%ayosholat_num))]}

  tgl=$(date +%d%m);
  tgl2=$(date +%d/%b); 
  jadwal=$(cat "plugin/imsakiyah.sh" | grep "$key" | grep $tgl | sed 's/# '$tgl' '$key' //')

  # set tweet_status
  status="[$prefix] Kota $kota hari ini [$tgl2]: $jadwal"
  echo "[ttytter] : $status"
  ttytter -status="$status"
  #sleep 5
  #status2="[$prefix] Kota $kota diambil dari $url ~ $ayosholat"
  #echo "[ttytter] : $status2"
  #ttytter -status="$status2"

  echo "- done -"
  exit 1
}

# JADWAL SHOLAT (Juni - Desember) 2014 KOTA MALANG
# Sumber: http://www.jadwalsholat.org/adzan/monthly.php?id=141
# ------------------------------------------------------------------------------------------
# 0106 mlg Subuh 04:15 ~ Terbit 05:34 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:19 ~ Isya' 18:34
# 0206 mlg Subuh 04:15 ~ Terbit 05:34 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:19 ~ Isya' 18:34
# 0306 mlg Subuh 04:15 ~ Terbit 05:34 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:20 ~ Isya' 18:34
# 0406 mlg Subuh 04:15 ~ Terbit 05:35 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:20 ~ Isya' 18:34
# 0506 mlg Subuh 04:16 ~ Terbit 05:35 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:20 ~ Isya' 18:34
# 0606 mlg Subuh 04:16 ~ Terbit 05:35 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:20 ~ Isya' 18:34
# 0706 mlg Subuh 04:16 ~ Terbit 05:35 ~ Dzuhur 11:30 ~ Ashar 14:50 ~ Maghrib 17:20 ~ Isya' 18:35
# 0806 mlg Subuh 04:16 ~ Terbit 05:36 ~ Dzuhur 11:30 ~ Ashar 14:51 ~ Maghrib 17:20 ~ Isya' 18:35
# 0906 mlg Subuh 04:16 ~ Terbit 05:36 ~ Dzuhur 11:30 ~ Ashar 14:51 ~ Maghrib 17:20 ~ Isya' 18:35
# 1006 mlg Subuh 04:17 ~ Terbit 05:36 ~ Dzuhur 11:30 ~ Ashar 14:51 ~ Maghrib 17:20 ~ Isya' 18:35
# 1106 mlg Subuh 04:17 ~ Terbit 05:36 ~ Dzuhur 11:30 ~ Ashar 14:51 ~ Maghrib 17:20 ~ Isya' 18:35
# 1206 mlg Subuh 04:17 ~ Terbit 05:37 ~ Dzuhur 11:31 ~ Ashar 14:51 ~ Maghrib 17:21 ~ Isya' 18:36
# 1306 mlg Subuh 04:17 ~ Terbit 05:37 ~ Dzuhur 11:31 ~ Ashar 14:51 ~ Maghrib 17:21 ~ Isya' 18:36
# 1406 mlg Subuh 04:17 ~ Terbit 05:37 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:21 ~ Isya' 18:36
# 1506 mlg Subuh 04:18 ~ Terbit 05:37 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:21 ~ Isya' 18:36
# 1606 mlg Subuh 04:18 ~ Terbit 05:38 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:21 ~ Isya' 18:36
# 1706 mlg Subuh 04:18 ~ Terbit 05:38 ~ Dzuhur 11:32 ~ Ashar 14:52 ~ Maghrib 17:22 ~ Isya' 18:37
# 1806 mlg Subuh 04:18 ~ Terbit 05:38 ~ Dzuhur 11:32 ~ Ashar 14:52 ~ Maghrib 17:22 ~ Isya' 18:37
# 1906 mlg Subuh 04:18 ~ Terbit 05:38 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:22 ~ Isya' 18:37
# 2006 mlg Subuh 04:19 ~ Terbit 05:39 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:22 ~ Isya' 18:37
# 2106 mlg Subuh 04:19 ~ Terbit 05:39 ~ Dzuhur 11:33 ~ Ashar 14:53 ~ Maghrib 17:22 ~ Isya' 18:37
# 2206 mlg Subuh 04:19 ~ Terbit 05:39 ~ Dzuhur 11:33 ~ Ashar 14:53 ~ Maghrib 17:23 ~ Isya' 18:38
# 2306 mlg Subuh 04:19 ~ Terbit 05:39 ~ Dzuhur 11:33 ~ Ashar 14:53 ~ Maghrib 17:23 ~ Isya' 18:38
# 2406 mlg Subuh 04:20 ~ Terbit 05:39 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:23 ~ Isya' 18:38
# 2506 mlg Subuh 04:20 ~ Terbit 05:40 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:23 ~ Isya' 18:38
# 2606 mlg Subuh 04:20 ~ Terbit 05:40 ~ Dzuhur 11:34 ~ Ashar 14:54 ~ Maghrib 17:23 ~ Isya' 18:39
# 2706 mlg Subuh 04:20 ~ Terbit 05:40 ~ Dzuhur 11:34 ~ Ashar 14:54 ~ Maghrib 17:24 ~ Isya' 18:39
# 2806 mlg Subuh 04:20 ~ Terbit 05:40 ~ Dzuhur 11:34 ~ Ashar 14:55 ~ Maghrib 17:24 ~ Isya' 18:39
# 2906 mlg Subuh 04:21 ~ Terbit 05:40 ~ Dzuhur 11:34 ~ Ashar 14:55 ~ Maghrib 17:24 ~ Isya' 18:39
# 3006 mlg Subuh 04:21 ~ Terbit 05:41 ~ Dzuhur 11:34 ~ Ashar 14:55 ~ Maghrib 17:24 ~ Isya' 18:39

# 0107 mlg Subuh 04:21 ~ Terbit 05:41 ~ Dzuhur 11:35 ~ Ashar 14:55 ~ Maghrib 17:25 ~ Isya' 18:40
# 0207 mlg Subuh 04:21 ~ Terbit 05:41 ~ Dzuhur 11:35 ~ Ashar 14:55 ~ Maghrib 17:25 ~ Isya' 18:40
# 0307 mlg Subuh 04:21 ~ Terbit 05:41 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:25 ~ Isya' 18:40
# 0407 mlg Subuh 04:22 ~ Terbit 05:41 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:25 ~ Isya' 18:40
# 0507 mlg Subuh 04:22 ~ Terbit 05:41 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:26 ~ Isya' 18:40
# 0607 mlg Subuh 04:22 ~ Terbit 05:41 ~ Dzuhur 11:36 ~ Ashar 14:56 ~ Maghrib 17:26 ~ Isya' 18:41
# 0707 mlg Subuh 04:22 ~ Terbit 05:42 ~ Dzuhur 11:36 ~ Ashar 14:56 ~ Maghrib 17:26 ~ Isya' 18:41
# 0807 mlg Subuh 04:22 ~ Terbit 05:42 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:26 ~ Isya' 18:41
# 0907 mlg Subuh 04:22 ~ Terbit 05:42 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:26 ~ Isya' 18:41
# 1007 mlg Subuh 04:23 ~ Terbit 05:42 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:27 ~ Isya' 18:41
# 1107 mlg Subuh 04:23 ~ Terbit 05:42 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:27 ~ Isya' 18:41
# 1207 mlg Subuh 04:23 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:57 ~ Maghrib 17:27 ~ Isya' 18:42
# 1307 mlg Subuh 04:23 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:27 ~ Isya' 18:42
# 1407 mlg Subuh 04:23 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:42
# 1507 mlg Subuh 04:23 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:42
# 1607 mlg Subuh 04:23 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:42
# 1707 mlg Subuh 04:23 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:42
# 1807 mlg Subuh 04:23 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:42
# 1907 mlg Subuh 04:24 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:29 ~ Isya' 18:42
# 2007 mlg Subuh 04:24 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:29 ~ Isya' 18:43
# 2107 mlg Subuh 04:24 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 2207 mlg Subuh 04:24 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 2307 mlg Subuh 04:24 ~ Terbit 05:42 ~ Dzuhur 11:37 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 2407 mlg Subuh 04:24 ~ Terbit 05:42 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 2507 mlg Subuh 04:24 ~ Terbit 05:42 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 2607 mlg Subuh 04:24 ~ Terbit 05:41 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 2707 mlg Subuh 04:24 ~ Terbit 05:41 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 2807 mlg Subuh 04:24 ~ Terbit 05:41 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 2907 mlg Subuh 04:24 ~ Terbit 05:41 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 3007 mlg Subuh 04:24 ~ Terbit 05:41 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 3107 mlg Subuh 04:24 ~ Terbit 05:41 ~ Dzuhur 11:37 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43

# 0108 mlg Subuh 04:23 ~ Terbit 05:41 ~ Dzuhur 11:37 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 0208 mlg Subuh 04:23 ~ Terbit 05:40 ~ Dzuhur 11:37 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 0308 mlg Subuh 04:23 ~ Terbit 05:40 ~ Dzuhur 11:37 ~ Ashar 14:59 ~ Maghrib 17:31 ~ Isya' 18:43
# 0408 mlg Subuh 04:23 ~ Terbit 05:40 ~ Dzuhur 11:37 ~ Ashar 14:59 ~ Maghrib 17:31 ~ Isya' 18:43
# 0508 mlg Subuh 04:23 ~ Terbit 05:40 ~ Dzuhur 11:37 ~ Ashar 14:59 ~ Maghrib 17:31 ~ Isya' 18:43
# 0608 mlg Subuh 04:23 ~ Terbit 05:39 ~ Dzuhur 11:37 ~ Ashar 14:59 ~ Maghrib 17:31 ~ Isya' 18:43
# 0708 mlg Subuh 04:23 ~ Terbit 05:39 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:31 ~ Isya' 18:43
# 0808 mlg Subuh 04:23 ~ Terbit 05:39 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:31 ~ Isya' 18:43
# 0908 mlg Subuh 04:22 ~ Terbit 05:39 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:31 ~ Isya' 18:43
# 1008 mlg Subuh 04:22 ~ Terbit 05:38 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:31 ~ Isya' 18:43
# 1108 mlg Subuh 04:22 ~ Terbit 05:38 ~ Dzuhur 11:36 ~ Ashar 14:58 ~ Maghrib 17:31 ~ Isya' 18:43
# 1208 mlg Subuh 04:22 ~ Terbit 05:38 ~ Dzuhur 11:36 ~ Ashar 14:58 ~ Maghrib 17:31 ~ Isya' 18:43
# 1308 mlg Subuh 04:22 ~ Terbit 05:37 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:31 ~ Isya' 18:42
# 1408 mlg Subuh 04:21 ~ Terbit 05:37 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:31 ~ Isya' 18:42
# 1508 mlg Subuh 04:21 ~ Terbit 05:37 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:31 ~ Isya' 18:42
# 1608 mlg Subuh 04:21 ~ Terbit 05:36 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:31 ~ Isya' 18:42
# 1708 mlg Subuh 04:20 ~ Terbit 05:36 ~ Dzuhur 11:35 ~ Ashar 14:57 ~ Maghrib 17:31 ~ Isya' 18:42
# 1808 mlg Subuh 04:20 ~ Terbit 05:35 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:31 ~ Isya' 18:42
# 1908 mlg Subuh 04:20 ~ Terbit 05:35 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:31 ~ Isya' 18:42
# 2008 mlg Subuh 04:20 ~ Terbit 05:35 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:31 ~ Isya' 18:42
# 2108 mlg Subuh 04:19 ~ Terbit 05:34 ~ Dzuhur 11:34 ~ Ashar 14:55 ~ Maghrib 17:31 ~ Isya' 18:42
# 2208 mlg Subuh 04:19 ~ Terbit 05:34 ~ Dzuhur 11:34 ~ Ashar 14:55 ~ Maghrib 17:31 ~ Isya' 18:41
# 2308 mlg Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:34 ~ Ashar 14:55 ~ Maghrib 17:31 ~ Isya' 18:41
# 2408 mlg Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:34 ~ Ashar 14:54 ~ Maghrib 17:31 ~ Isya' 18:41
# 2508 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:31 ~ Isya' 18:41
# 2608 mlg Subuh 04:17 ~ Terbit 05:32 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:30 ~ Isya' 18:41
# 2708 mlg Subuh 04:17 ~ Terbit 05:31 ~ Dzuhur 11:33 ~ Ashar 14:53 ~ Maghrib 17:30 ~ Isya' 18:41
# 2808 mlg Subuh 04:17 ~ Terbit 05:31 ~ Dzuhur 11:33 ~ Ashar 14:53 ~ Maghrib 17:30 ~ Isya' 18:40
# 2908 mlg Subuh 04:16 ~ Terbit 05:31 ~ Dzuhur 11:32 ~ Ashar 14:52 ~ Maghrib 17:30 ~ Isya' 18:40
# 3008 mlg Subuh 04:16 ~ Terbit 05:30 ~ Dzuhur 11:32 ~ Ashar 14:52 ~ Maghrib 17:30 ~ Isya' 18:40
# 3108 mlg Subuh 04:15 ~ Terbit 05:30 ~ Dzuhur 11:32 ~ Ashar 14:51 ~ Maghrib 17:30 ~ Isya' 18:40

# 0109 mlg Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:31 ~ Ashar 14:51 ~ Maghrib 17:30 ~ Isya' 18:40
# 0209 mlg Subuh 04:14 ~ Terbit 05:28 ~ Dzuhur 11:31 ~ Ashar 14:50 ~ Maghrib 17:30 ~ Isya' 18:40
# 0309 mlg Subuh 04:14 ~ Terbit 05:28 ~ Dzuhur 11:31 ~ Ashar 14:50 ~ Maghrib 17:30 ~ Isya' 18:39
# 0409 mlg Subuh 04:14 ~ Terbit 05:27 ~ Dzuhur 11:30 ~ Ashar 14:49 ~ Maghrib 17:30 ~ Isya' 18:39
# 0509 mlg Subuh 04:13 ~ Terbit 05:27 ~ Dzuhur 11:30 ~ Ashar 14:49 ~ Maghrib 17:29 ~ Isya' 18:39
# 0609 mlg Subuh 04:13 ~ Terbit 05:26 ~ Dzuhur 11:30 ~ Ashar 14:48 ~ Maghrib 17:29 ~ Isya' 18:39
# 0709 mlg Subuh 04:12 ~ Terbit 05:26 ~ Dzuhur 11:29 ~ Ashar 14:48 ~ Maghrib 17:29 ~ Isya' 18:39
# 0809 mlg Subuh 04:12 ~ Terbit 05:25 ~ Dzuhur 11:29 ~ Ashar 14:47 ~ Maghrib 17:29 ~ Isya' 18:39
# 0909 mlg Subuh 04:11 ~ Terbit 05:25 ~ Dzuhur 11:29 ~ Ashar 14:47 ~ Maghrib 17:29 ~ Isya' 18:38
# 1009 mlg Subuh 04:11 ~ Terbit 05:24 ~ Dzuhur 11:28 ~ Ashar 14:46 ~ Maghrib 17:29 ~ Isya' 18:38
# 1109 mlg Subuh 04:10 ~ Terbit 05:24 ~ Dzuhur 11:28 ~ Ashar 14:45 ~ Maghrib 17:29 ~ Isya' 18:38
# 1209 mlg Subuh 04:10 ~ Terbit 05:23 ~ Dzuhur 11:28 ~ Ashar 14:45 ~ Maghrib 17:29 ~ Isya' 18:38
# 1309 mlg Subuh 04:09 ~ Terbit 05:22 ~ Dzuhur 11:27 ~ Ashar 14:44 ~ Maghrib 17:28 ~ Isya' 18:38
# 1409 mlg Subuh 04:08 ~ Terbit 05:22 ~ Dzuhur 11:27 ~ Ashar 14:43 ~ Maghrib 17:28 ~ Isya' 18:38
# 1509 mlg Subuh 04:08 ~ Terbit 05:21 ~ Dzuhur 11:27 ~ Ashar 14:43 ~ Maghrib 17:28 ~ Isya' 18:37
# 1609 mlg Subuh 04:07 ~ Terbit 05:21 ~ Dzuhur 11:26 ~ Ashar 14:42 ~ Maghrib 17:28 ~ Isya' 18:37
# 1709 mlg Subuh 04:07 ~ Terbit 05:20 ~ Dzuhur 11:26 ~ Ashar 14:41 ~ Maghrib 17:28 ~ Isya' 18:37
# 1809 mlg Subuh 04:06 ~ Terbit 05:20 ~ Dzuhur 11:26 ~ Ashar 14:41 ~ Maghrib 17:28 ~ Isya' 18:37
# 1909 mlg Subuh 04:06 ~ Terbit 05:19 ~ Dzuhur 11:25 ~ Ashar 14:40 ~ Maghrib 17:28 ~ Isya' 18:37
# 2009 mlg Subuh 04:05 ~ Terbit 05:18 ~ Dzuhur 11:25 ~ Ashar 14:39 ~ Maghrib 17:27 ~ Isya' 18:37
# 2109 mlg Subuh 04:05 ~ Terbit 05:18 ~ Dzuhur 11:25 ~ Ashar 14:39 ~ Maghrib 17:27 ~ Isya' 18:37
# 2209 mlg Subuh 04:04 ~ Terbit 05:17 ~ Dzuhur 11:24 ~ Ashar 14:38 ~ Maghrib 17:27 ~ Isya' 18:36
# 2309 mlg Subuh 04:03 ~ Terbit 05:17 ~ Dzuhur 11:24 ~ Ashar 14:37 ~ Maghrib 17:27 ~ Isya' 18:36
# 2409 mlg Subuh 04:03 ~ Terbit 05:16 ~ Dzuhur 11:23 ~ Ashar 14:36 ~ Maghrib 17:27 ~ Isya' 18:36
# 2509 mlg Subuh 04:02 ~ Terbit 05:16 ~ Dzuhur 11:23 ~ Ashar 14:36 ~ Maghrib 17:27 ~ Isya' 18:36
# 2609 mlg Subuh 04:02 ~ Terbit 05:15 ~ Dzuhur 11:23 ~ Ashar 14:35 ~ Maghrib 17:27 ~ Isya' 18:36
# 2709 mlg Subuh 04:01 ~ Terbit 05:15 ~ Dzuhur 11:22 ~ Ashar 14:34 ~ Maghrib 17:26 ~ Isya' 18:36
# 2809 mlg Subuh 04:00 ~ Terbit 05:14 ~ Dzuhur 11:22 ~ Ashar 14:33 ~ Maghrib 17:26 ~ Isya' 18:36
# 2909 mlg Subuh 04:00 ~ Terbit 05:13 ~ Dzuhur 11:22 ~ Ashar 14:32 ~ Maghrib 17:26 ~ Isya' 18:36
# 3009 mlg Subuh 03:59 ~ Terbit 05:13 ~ Dzuhur 11:21 ~ Ashar 14:32 ~ Maghrib 17:26 ~ Isya' 18:36

# 0110 mlg Subuh 03:59 ~ Terbit 05:12 ~ Dzuhur 11:21 ~ Ashar 14:31 ~ Maghrib 17:26 ~ Isya' 18:36
# 0210 mlg Subuh 03:58 ~ Terbit 05:12 ~ Dzuhur 11:21 ~ Ashar 14:30 ~ Maghrib 17:26 ~ Isya' 18:35
# 0310 mlg Subuh 03:57 ~ Terbit 05:11 ~ Dzuhur 11:20 ~ Ashar 14:29 ~ Maghrib 17:26 ~ Isya' 18:35
# 0410 mlg Subuh 03:57 ~ Terbit 05:11 ~ Dzuhur 11:20 ~ Ashar 14:28 ~ Maghrib 17:26 ~ Isya' 18:35
# 0510 mlg Subuh 03:56 ~ Terbit 05:10 ~ Dzuhur 11:20 ~ Ashar 14:27 ~ Maghrib 17:26 ~ Isya' 18:35
# 0610 mlg Subuh 03:56 ~ Terbit 05:10 ~ Dzuhur 11:19 ~ Ashar 14:27 ~ Maghrib 17:26 ~ Isya' 18:35
# 0710 mlg Subuh 03:55 ~ Terbit 05:09 ~ Dzuhur 11:19 ~ Ashar 14:26 ~ Maghrib 17:25 ~ Isya' 18:35
# 0810 mlg Subuh 03:55 ~ Terbit 05:09 ~ Dzuhur 11:19 ~ Ashar 14:25 ~ Maghrib 17:25 ~ Isya' 18:35
# 0910 mlg Subuh 03:54 ~ Terbit 05:08 ~ Dzuhur 11:19 ~ Ashar 14:24 ~ Maghrib 17:25 ~ Isya' 18:35
# 1010 mlg Subuh 03:53 ~ Terbit 05:08 ~ Dzuhur 11:18 ~ Ashar 14:23 ~ Maghrib 17:25 ~ Isya' 18:35
# 1110 mlg Subuh 03:53 ~ Terbit 05:07 ~ Dzuhur 11:18 ~ Ashar 14:22 ~ Maghrib 17:25 ~ Isya' 18:35
# 1210 mlg Subuh 03:52 ~ Terbit 05:07 ~ Dzuhur 11:18 ~ Ashar 14:21 ~ Maghrib 17:25 ~ Isya' 18:35
# 1310 mlg Subuh 03:52 ~ Terbit 05:06 ~ Dzuhur 11:18 ~ Ashar 14:20 ~ Maghrib 17:25 ~ Isya' 18:35
# 1410 mlg Subuh 03:51 ~ Terbit 05:06 ~ Dzuhur 11:17 ~ Ashar 14:20 ~ Maghrib 17:25 ~ Isya' 18:35
# 1510 mlg Subuh 03:51 ~ Terbit 05:05 ~ Dzuhur 11:17 ~ Ashar 14:19 ~ Maghrib 17:25 ~ Isya' 18:35
# 1610 mlg Subuh 03:50 ~ Terbit 05:05 ~ Dzuhur 11:17 ~ Ashar 14:20 ~ Maghrib 17:25 ~ Isya' 18:36
# 1710 mlg Subuh 03:50 ~ Terbit 05:04 ~ Dzuhur 11:17 ~ Ashar 14:21 ~ Maghrib 17:25 ~ Isya' 18:36
# 1810 mlg Subuh 03:49 ~ Terbit 05:04 ~ Dzuhur 11:16 ~ Ashar 14:21 ~ Maghrib 17:25 ~ Isya' 18:36
# 1910 mlg Subuh 03:49 ~ Terbit 05:03 ~ Dzuhur 11:16 ~ Ashar 14:22 ~ Maghrib 17:25 ~ Isya' 18:36
# 2010 mlg Subuh 03:48 ~ Terbit 05:03 ~ Dzuhur 11:16 ~ Ashar 14:22 ~ Maghrib 17:25 ~ Isya' 18:36
# 2110 mlg Subuh 03:48 ~ Terbit 05:03 ~ Dzuhur 11:16 ~ Ashar 14:23 ~ Maghrib 17:25 ~ Isya' 18:36
# 2210 mlg Subuh 03:47 ~ Terbit 05:02 ~ Dzuhur 11:16 ~ Ashar 14:23 ~ Maghrib 17:25 ~ Isya' 18:36
# 2310 mlg Subuh 03:47 ~ Terbit 05:02 ~ Dzuhur 11:16 ~ Ashar 14:24 ~ Maghrib 17:25 ~ Isya' 18:36
# 2410 mlg Subuh 03:46 ~ Terbit 05:02 ~ Dzuhur 11:15 ~ Ashar 14:24 ~ Maghrib 17:25 ~ Isya' 18:37
# 2510 mlg Subuh 03:46 ~ Terbit 05:01 ~ Dzuhur 11:15 ~ Ashar 14:25 ~ Maghrib 17:25 ~ Isya' 18:37
# 2610 mlg Subuh 03:45 ~ Terbit 05:01 ~ Dzuhur 11:15 ~ Ashar 14:26 ~ Maghrib 17:25 ~ Isya' 18:37
# 2710 mlg Subuh 03:45 ~ Terbit 05:01 ~ Dzuhur 11:15 ~ Ashar 14:26 ~ Maghrib 17:26 ~ Isya' 18:37
# 2810 mlg Subuh 03:44 ~ Terbit 05:00 ~ Dzuhur 11:15 ~ Ashar 14:27 ~ Maghrib 17:26 ~ Isya' 18:37
# 2910 mlg Subuh 03:44 ~ Terbit 05:00 ~ Dzuhur 11:15 ~ Ashar 14:27 ~ Maghrib 17:26 ~ Isya' 18:38
# 3010 mlg Subuh 03:43 ~ Terbit 05:00 ~ Dzuhur 11:15 ~ Ashar 14:28 ~ Maghrib 17:26 ~ Isya' 18:38
# 3110 mlg Subuh 03:43 ~ Terbit 04:59 ~ Dzuhur 11:15 ~ Ashar 14:28 ~ Maghrib 17:26 ~ Isya' 18:38

# 0111 mlg Subuh 03:43 ~ Terbit 04:59 ~ Dzuhur 11:15 ~ Ashar 14:29 ~ Maghrib 17:26 ~ Isya' 18:38
# 0211 mlg Subuh 03:42 ~ Terbit 04:59 ~ Dzuhur 11:15 ~ Ashar 14:29 ~ Maghrib 17:26 ~ Isya' 18:39
# 0311 mlg Subuh 03:42 ~ Terbit 04:59 ~ Dzuhur 11:15 ~ Ashar 14:30 ~ Maghrib 17:27 ~ Isya' 18:39
# 0411 mlg Subuh 03:42 ~ Terbit 04:58 ~ Dzuhur 11:15 ~ Ashar 14:30 ~ Maghrib 17:27 ~ Isya' 18:39
# 0511 mlg Subuh 03:41 ~ Terbit 04:58 ~ Dzuhur 11:15 ~ Ashar 14:31 ~ Maghrib 17:27 ~ Isya' 18:40
# 0611 mlg Subuh 03:41 ~ Terbit 04:58 ~ Dzuhur 11:15 ~ Ashar 14:31 ~ Maghrib 17:27 ~ Isya' 18:40
# 0711 mlg Subuh 03:41 ~ Terbit 04:58 ~ Dzuhur 11:15 ~ Ashar 14:32 ~ Maghrib 17:27 ~ Isya' 18:40
# 0811 mlg Subuh 03:40 ~ Terbit 04:58 ~ Dzuhur 11:15 ~ Ashar 14:32 ~ Maghrib 17:28 ~ Isya' 18:41
# 0911 mlg Subuh 03:40 ~ Terbit 04:58 ~ Dzuhur 11:15 ~ Ashar 14:33 ~ Maghrib 17:28 ~ Isya' 18:41
# 1011 mlg Subuh 03:40 ~ Terbit 04:58 ~ Dzuhur 11:15 ~ Ashar 14:33 ~ Maghrib 17:28 ~ Isya' 18:41
# 1111 mlg Subuh 03:40 ~ Terbit 04:57 ~ Dzuhur 11:15 ~ Ashar 14:34 ~ Maghrib 17:28 ~ Isya' 18:42
# 1211 mlg Subuh 03:39 ~ Terbit 04:57 ~ Dzuhur 11:15 ~ Ashar 14:34 ~ Maghrib 17:29 ~ Isya' 18:42
# 1311 mlg Subuh 03:39 ~ Terbit 04:57 ~ Dzuhur 11:15 ~ Ashar 14:35 ~ Maghrib 17:29 ~ Isya' 18:43
# 1411 mlg Subuh 03:39 ~ Terbit 04:57 ~ Dzuhur 11:15 ~ Ashar 14:35 ~ Maghrib 17:29 ~ Isya' 18:43
# 1511 mlg Subuh 03:39 ~ Terbit 04:57 ~ Dzuhur 11:15 ~ Ashar 14:36 ~ Maghrib 17:30 ~ Isya' 18:44
# 1611 mlg Subuh 03:39 ~ Terbit 04:57 ~ Dzuhur 11:16 ~ Ashar 14:37 ~ Maghrib 17:30 ~ Isya' 18:44
# 1711 mlg Subuh 03:38 ~ Terbit 04:57 ~ Dzuhur 11:16 ~ Ashar 14:37 ~ Maghrib 17:30 ~ Isya' 18:45
# 1811 mlg Subuh 03:38 ~ Terbit 04:57 ~ Dzuhur 11:16 ~ Ashar 14:38 ~ Maghrib 17:31 ~ Isya' 18:45
# 1911 mlg Subuh 03:38 ~ Terbit 04:57 ~ Dzuhur 11:16 ~ Ashar 14:38 ~ Maghrib 17:31 ~ Isya' 18:45
# 2011 mlg Subuh 03:38 ~ Terbit 04:57 ~ Dzuhur 11:16 ~ Ashar 14:39 ~ Maghrib 17:31 ~ Isya' 18:46
# 2111 mlg Subuh 03:38 ~ Terbit 04:57 ~ Dzuhur 11:17 ~ Ashar 14:39 ~ Maghrib 17:32 ~ Isya' 18:46
# 2211 mlg Subuh 03:38 ~ Terbit 04:58 ~ Dzuhur 11:17 ~ Ashar 14:40 ~ Maghrib 17:32 ~ Isya' 18:47
# 2311 mlg Subuh 03:38 ~ Terbit 04:58 ~ Dzuhur 11:17 ~ Ashar 14:40 ~ Maghrib 17:33 ~ Isya' 18:48
# 2411 mlg Subuh 03:38 ~ Terbit 04:58 ~ Dzuhur 11:17 ~ Ashar 14:41 ~ Maghrib 17:33 ~ Isya' 18:48
# 2511 mlg Subuh 03:38 ~ Terbit 04:58 ~ Dzuhur 11:18 ~ Ashar 14:41 ~ Maghrib 17:33 ~ Isya' 18:49
# 2611 mlg Subuh 03:38 ~ Terbit 04:58 ~ Dzuhur 11:18 ~ Ashar 14:42 ~ Maghrib 17:34 ~ Isya' 18:49
# 2711 mlg Subuh 03:38 ~ Terbit 04:58 ~ Dzuhur 11:18 ~ Ashar 14:43 ~ Maghrib 17:34 ~ Isya' 18:50
# 2811 mlg Subuh 03:38 ~ Terbit 04:58 ~ Dzuhur 11:19 ~ Ashar 14:43 ~ Maghrib 17:35 ~ Isya' 18:50
# 2911 mlg Subuh 03:38 ~ Terbit 04:59 ~ Dzuhur 11:19 ~ Ashar 14:44 ~ Maghrib 17:35 ~ Isya' 18:51
# 3011 mlg Subuh 03:38 ~ Terbit 04:59 ~ Dzuhur 11:19 ~ Ashar 14:44 ~ Maghrib 17:36 ~ Isya' 18:51

# 0112 mlg Subuh 03:38 ~ Terbit 04:59 ~ Dzuhur 11:20 ~ Ashar 14:45 ~ Maghrib 17:36 ~ Isya' 18:52
# 0212 mlg Subuh 03:39 ~ Terbit 04:59 ~ Dzuhur 11:20 ~ Ashar 14:45 ~ Maghrib 17:37 ~ Isya' 18:52
# 0312 mlg Subuh 03:39 ~ Terbit 05:00 ~ Dzuhur 11:20 ~ Ashar 14:46 ~ Maghrib 17:37 ~ Isya' 18:53
# 0412 mlg Subuh 03:39 ~ Terbit 05:00 ~ Dzuhur 11:21 ~ Ashar 14:47 ~ Maghrib 17:38 ~ Isya' 18:54
# 0512 mlg Subuh 03:39 ~ Terbit 05:00 ~ Dzuhur 11:21 ~ Ashar 14:47 ~ Maghrib 17:38 ~ Isya' 18:54
# 0612 mlg Subuh 03:39 ~ Terbit 05:01 ~ Dzuhur 11:22 ~ Ashar 14:48 ~ Maghrib 17:39 ~ Isya' 18:55
# 0712 mlg Subuh 03:40 ~ Terbit 05:01 ~ Dzuhur 11:22 ~ Ashar 14:48 ~ Maghrib 17:39 ~ Isya' 18:55
# 0812 mlg Subuh 03:40 ~ Terbit 05:01 ~ Dzuhur 11:22 ~ Ashar 14:49 ~ Maghrib 17:40 ~ Isya' 18:56
# 0912 mlg Subuh 03:40 ~ Terbit 05:02 ~ Dzuhur 11:23 ~ Ashar 14:49 ~ Maghrib 17:40 ~ Isya' 18:57
# 1012 mlg Subuh 03:40 ~ Terbit 05:02 ~ Dzuhur 11:23 ~ Ashar 14:50 ~ Maghrib 17:41 ~ Isya' 18:57
# 1112 mlg Subuh 03:41 ~ Terbit 05:02 ~ Dzuhur 11:24 ~ Ashar 14:50 ~ Maghrib 17:41 ~ Isya' 18:58
# 1212 mlg Subuh 03:41 ~ Terbit 05:03 ~ Dzuhur 11:24 ~ Ashar 14:51 ~ Maghrib 17:42 ~ Isya' 18:58
# 1312 mlg Subuh 03:41 ~ Terbit 05:03 ~ Dzuhur 11:25 ~ Ashar 14:52 ~ Maghrib 17:42 ~ Isya' 18:59
# 1412 mlg Subuh 03:42 ~ Terbit 05:04 ~ Dzuhur 11:25 ~ Ashar 14:52 ~ Maghrib 17:43 ~ Isya' 18:59
# 1512 mlg Subuh 03:42 ~ Terbit 05:04 ~ Dzuhur 11:26 ~ Ashar 14:53 ~ Maghrib 17:43 ~ Isya' 19:00
# 1612 mlg Subuh 03:42 ~ Terbit 05:04 ~ Dzuhur 11:26 ~ Ashar 14:53 ~ Maghrib 17:44 ~ Isya' 19:01
# 1712 mlg Subuh 03:43 ~ Terbit 05:05 ~ Dzuhur 11:27 ~ Ashar 14:54 ~ Maghrib 17:44 ~ Isya' 19:01
# 1812 mlg Subuh 03:43 ~ Terbit 05:05 ~ Dzuhur 11:27 ~ Ashar 14:54 ~ Maghrib 17:45 ~ Isya' 19:02
# 1912 mlg Subuh 03:44 ~ Terbit 05:06 ~ Dzuhur 11:28 ~ Ashar 14:55 ~ Maghrib 17:45 ~ Isya' 19:02
# 2012 mlg Subuh 03:44 ~ Terbit 05:06 ~ Dzuhur 11:28 ~ Ashar 14:55 ~ Maghrib 17:46 ~ Isya' 19:03
# 2112 mlg Subuh 03:45 ~ Terbit 05:07 ~ Dzuhur 11:28 ~ Ashar 14:56 ~ Maghrib 17:46 ~ Isya' 19:03
# 2212 mlg Subuh 03:45 ~ Terbit 05:07 ~ Dzuhur 11:29 ~ Ashar 14:56 ~ Maghrib 17:47 ~ Isya' 19:04
# 2312 mlg Subuh 03:46 ~ Terbit 05:08 ~ Dzuhur 11:29 ~ Ashar 14:57 ~ Maghrib 17:47 ~ Isya' 19:04
# 2412 mlg Subuh 03:46 ~ Terbit 05:08 ~ Dzuhur 11:30 ~ Ashar 14:57 ~ Maghrib 17:48 ~ Isya' 19:05
# 2512 mlg Subuh 03:47 ~ Terbit 05:09 ~ Dzuhur 11:30 ~ Ashar 14:58 ~ Maghrib 17:48 ~ Isya' 19:05
# 2612 mlg Subuh 03:47 ~ Terbit 05:09 ~ Dzuhur 11:31 ~ Ashar 14:58 ~ Maghrib 17:49 ~ Isya' 19:06
# 2712 mlg Subuh 03:48 ~ Terbit 05:10 ~ Dzuhur 11:31 ~ Ashar 14:59 ~ Maghrib 17:49 ~ Isya' 19:06
# 2812 mlg Subuh 03:48 ~ Terbit 05:10 ~ Dzuhur 11:32 ~ Ashar 14:59 ~ Maghrib 17:50 ~ Isya' 19:06
# 2912 mlg Subuh 03:49 ~ Terbit 05:11 ~ Dzuhur 11:32 ~ Ashar 15:00 ~ Maghrib 17:50 ~ Isya' 19:07
# 3012 mlg Subuh 03:49 ~ Terbit 05:11 ~ Dzuhur 11:33 ~ Ashar 15:00 ~ Maghrib 17:51 ~ Isya' 19:07
# 3112 mlg Subuh 03:50 ~ Terbit 05:12 ~ Dzuhur 11:33 ~ Ashar 15:01 ~ Maghrib 17:51 ~ Isya' 19:08


# JADWAL SHOLAT (Juni - Desember) 2014 KOTA TULUNGAGUNG
# Sumber: http://www.jadwalsholat.org/adzan/monthly.php?id=295
# ------------------------------------------------------------------------------------------
# 0106 tag Subuh 04:19 ~ Terbit 05:37 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:23 ~ Isya' 18:37
# 0206 tag Subuh 04:19 ~ Terbit 05:38 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:23 ~ Isya' 18:37
# 0306 tag Subuh 04:19 ~ Terbit 05:38 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:23 ~ Isya' 18:37
# 0406 tag Subuh 04:19 ~ Terbit 05:38 ~ Dzuhur 11:33 ~ Ashar 14:53 ~ Maghrib 17:23 ~ Isya' 18:37
# 0506 tag Subuh 04:19 ~ Terbit 05:38 ~ Dzuhur 11:33 ~ Ashar 14:53 ~ Maghrib 17:23 ~ Isya' 18:38
# 0606 tag Subuh 04:19 ~ Terbit 05:39 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:23 ~ Isya' 18:38
# 0706 tag Subuh 04:20 ~ Terbit 05:39 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:23 ~ Isya' 18:38
# 0806 tag Subuh 04:20 ~ Terbit 05:39 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:23 ~ Isya' 18:38
# 0906 tag Subuh 04:20 ~ Terbit 05:39 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:23 ~ Isya' 18:38
# 1006 tag Subuh 04:20 ~ Terbit 05:40 ~ Dzuhur 11:34 ~ Ashar 14:54 ~ Maghrib 17:24 ~ Isya' 18:38
# 1106 tag Subuh 04:20 ~ Terbit 05:40 ~ Dzuhur 11:34 ~ Ashar 14:54 ~ Maghrib 17:24 ~ Isya' 18:39
# 1206 tag Subuh 04:20 ~ Terbit 05:40 ~ Dzuhur 11:34 ~ Ashar 14:55 ~ Maghrib 17:24 ~ Isya' 18:39
# 1306 tag Subuh 04:21 ~ Terbit 05:40 ~ Dzuhur 11:34 ~ Ashar 14:55 ~ Maghrib 17:24 ~ Isya' 18:39
# 1406 tag Subuh 04:21 ~ Terbit 05:41 ~ Dzuhur 11:34 ~ Ashar 14:55 ~ Maghrib 17:24 ~ Isya' 18:39
# 1506 tag Subuh 04:21 ~ Terbit 05:41 ~ Dzuhur 11:35 ~ Ashar 14:55 ~ Maghrib 17:24 ~ Isya' 18:39
# 1606 tag Subuh 04:21 ~ Terbit 05:41 ~ Dzuhur 11:35 ~ Ashar 14:55 ~ Maghrib 17:25 ~ Isya' 18:40
# 1706 tag Subuh 04:22 ~ Terbit 05:41 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:25 ~ Isya' 18:40
# 1806 tag Subuh 04:22 ~ Terbit 05:42 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:25 ~ Isya' 18:40
# 1906 tag Subuh 04:22 ~ Terbit 05:42 ~ Dzuhur 11:36 ~ Ashar 14:56 ~ Maghrib 17:25 ~ Isya' 18:40
# 2006 tag Subuh 04:22 ~ Terbit 05:42 ~ Dzuhur 11:36 ~ Ashar 14:56 ~ Maghrib 17:25 ~ Isya' 18:41
# 2106 tag Subuh 04:22 ~ Terbit 05:42 ~ Dzuhur 11:36 ~ Ashar 14:56 ~ Maghrib 17:26 ~ Isya' 18:41
# 2206 tag Subuh 04:23 ~ Terbit 05:43 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:26 ~ Isya' 18:41
# 2306 tag Subuh 04:23 ~ Terbit 05:43 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:26 ~ Isya' 18:41
# 2406 tag Subuh 04:23 ~ Terbit 05:43 ~ Dzuhur 11:37 ~ Ashar 14:57 ~ Maghrib 17:26 ~ Isya' 18:41
# 2506 tag Subuh 04:23 ~ Terbit 05:43 ~ Dzuhur 11:37 ~ Ashar 14:57 ~ Maghrib 17:26 ~ Isya' 18:42
# 2606 tag Subuh 04:24 ~ Terbit 05:43 ~ Dzuhur 11:37 ~ Ashar 14:57 ~ Maghrib 17:27 ~ Isya' 18:42
# 2706 tag Subuh 04:24 ~ Terbit 05:44 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:27 ~ Isya' 18:42
# 2806 tag Subuh 04:24 ~ Terbit 05:44 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:27 ~ Isya' 18:42
# 2906 tag Subuh 04:24 ~ Terbit 05:44 ~ Dzuhur 11:38 ~ Ashar 14:58 ~ Maghrib 17:27 ~ Isya' 18:42
# 3006 tag Subuh 04:24 ~ Terbit 05:44 ~ Dzuhur 11:38 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:43

# 0107 tag Subuh 04:25 ~ Terbit 05:44 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:28 ~ Isya' 18:43
# 0207 tag Subuh 04:25 ~ Terbit 05:44 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:28 ~ Isya' 18:43
# 0307 tag Subuh 04:25 ~ Terbit 05:45 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:28 ~ Isya' 18:43
# 0407 tag Subuh 04:25 ~ Terbit 05:45 ~ Dzuhur 11:39 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 0507 tag Subuh 04:25 ~ Terbit 05:45 ~ Dzuhur 11:39 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:44
# 0607 tag Subuh 04:25 ~ Terbit 05:45 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:29 ~ Isya' 18:44
# 0707 tag Subuh 04:26 ~ Terbit 05:45 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:29 ~ Isya' 18:44
# 0807 tag Subuh 04:26 ~ Terbit 05:45 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:30 ~ Isya' 18:44
# 0907 tag Subuh 04:26 ~ Terbit 05:45 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:30 ~ Isya' 18:44
# 1007 tag Subuh 04:26 ~ Terbit 05:45 ~ Dzuhur 11:40 ~ Ashar 15:00 ~ Maghrib 17:30 ~ Isya' 18:45
# 1107 tag Subuh 04:26 ~ Terbit 05:45 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:30 ~ Isya' 18:45
# 1207 tag Subuh 04:26 ~ Terbit 05:45 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:30 ~ Isya' 18:45
# 1307 tag Subuh 04:26 ~ Terbit 05:46 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:31 ~ Isya' 18:45
# 1407 tag Subuh 04:27 ~ Terbit 05:46 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:31 ~ Isya' 18:45
# 1507 tag Subuh 04:27 ~ Terbit 05:46 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:31 ~ Isya' 18:45
# 1607 tag Subuh 04:27 ~ Terbit 05:46 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:31 ~ Isya' 18:45
# 1707 tag Subuh 04:27 ~ Terbit 05:46 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:31 ~ Isya' 18:45
# 1807 tag Subuh 04:27 ~ Terbit 05:46 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:32 ~ Isya' 18:46
# 1907 tag Subuh 04:27 ~ Terbit 05:46 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:32 ~ Isya' 18:46
# 2007 tag Subuh 04:27 ~ Terbit 05:45 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:32 ~ Isya' 18:46
# 2107 tag Subuh 04:27 ~ Terbit 05:45 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:32 ~ Isya' 18:46
# 2207 tag Subuh 04:27 ~ Terbit 05:45 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:32 ~ Isya' 18:46
# 2307 tag Subuh 04:27 ~ Terbit 05:45 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2407 tag Subuh 04:27 ~ Terbit 05:45 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2507 tag Subuh 04:27 ~ Terbit 05:45 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2607 tag Subuh 04:27 ~ Terbit 05:45 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2707 tag Subuh 04:27 ~ Terbit 05:45 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2807 tag Subuh 04:27 ~ Terbit 05:45 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2907 tag Subuh 04:27 ~ Terbit 05:45 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 3007 tag Subuh 04:27 ~ Terbit 05:44 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 3107 tag Subuh 04:27 ~ Terbit 05:44 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:34 ~ Isya' 18:46

# 0108 tag Subuh 04:27 ~ Terbit 05:44 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:34 ~ Isya' 18:46
# 0208 tag Subuh 04:27 ~ Terbit 05:44 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:34 ~ Isya' 18:46
# 0308 tag Subuh 04:27 ~ Terbit 05:44 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:34 ~ Isya' 18:46
# 0408 tag Subuh 04:27 ~ Terbit 05:43 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:34 ~ Isya' 18:46
# 0508 tag Subuh 04:26 ~ Terbit 05:43 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:34 ~ Isya' 18:46
# 0608 tag Subuh 04:26 ~ Terbit 05:43 ~ Dzuhur 11:40 ~ Ashar 15:02 ~ Maghrib 17:34 ~ Isya' 18:46
# 0708 tag Subuh 04:26 ~ Terbit 05:43 ~ Dzuhur 11:40 ~ Ashar 15:02 ~ Maghrib 17:34 ~ Isya' 18:46
# 0808 tag Subuh 04:26 ~ Terbit 05:42 ~ Dzuhur 11:40 ~ Ashar 15:02 ~ Maghrib 17:34 ~ Isya' 18:46
# 0908 tag Subuh 04:26 ~ Terbit 05:42 ~ Dzuhur 11:40 ~ Ashar 15:02 ~ Maghrib 17:34 ~ Isya' 18:46
# 1008 tag Subuh 04:26 ~ Terbit 05:42 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:34 ~ Isya' 18:46
# 1108 tag Subuh 04:25 ~ Terbit 05:41 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:34 ~ Isya' 18:46
# 1208 tag Subuh 04:25 ~ Terbit 05:41 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:34 ~ Isya' 18:46
# 1308 tag Subuh 04:25 ~ Terbit 05:41 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:34 ~ Isya' 18:46
# 1408 tag Subuh 04:25 ~ Terbit 05:40 ~ Dzuhur 11:39 ~ Ashar 15:01 ~ Maghrib 17:34 ~ Isya' 18:46
# 1508 tag Subuh 04:24 ~ Terbit 05:40 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:34 ~ Isya' 18:46
# 1608 tag Subuh 04:24 ~ Terbit 05:40 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:34 ~ Isya' 18:45
# 1708 tag Subuh 04:24 ~ Terbit 05:39 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:34 ~ Isya' 18:45
# 1808 tag Subuh 04:24 ~ Terbit 05:39 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:34 ~ Isya' 18:45
# 1908 tag Subuh 04:23 ~ Terbit 05:39 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:34 ~ Isya' 18:45
# 2008 tag Subuh 04:23 ~ Terbit 05:38 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:34 ~ Isya' 18:45
# 2108 tag Subuh 04:23 ~ Terbit 05:38 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:34 ~ Isya' 18:45
# 2208 tag Subuh 04:22 ~ Terbit 05:37 ~ Dzuhur 11:38 ~ Ashar 14:58 ~ Maghrib 17:34 ~ Isya' 18:45
# 2308 tag Subuh 04:22 ~ Terbit 05:37 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:34 ~ Isya' 18:45
# 2408 tag Subuh 04:22 ~ Terbit 05:36 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:34 ~ Isya' 18:44
# 2508 tag Subuh 04:21 ~ Terbit 05:36 ~ Dzuhur 11:37 ~ Ashar 14:57 ~ Maghrib 17:34 ~ Isya' 18:44
# 2608 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:37 ~ Ashar 14:57 ~ Maghrib 17:34 ~ Isya' 18:44
# 2708 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:34 ~ Isya' 18:44
# 2808 tag Subuh 04:20 ~ Terbit 05:34 ~ Dzuhur 11:36 ~ Ashar 14:56 ~ Maghrib 17:34 ~ Isya' 18:44
# 2908 tag Subuh 04:20 ~ Terbit 05:34 ~ Dzuhur 11:36 ~ Ashar 14:56 ~ Maghrib 17:34 ~ Isya' 18:44
# 3008 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:35 ~ Ashar 14:55 ~ Maghrib 17:33 ~ Isya' 18:44
# 3108 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:35 ~ Ashar 14:55 ~ Maghrib 17:33 ~ Isya' 18:43

# 0109 tag Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:35 ~ Ashar 14:54 ~ Maghrib 17:33 ~ Isya' 18:43
# 0209 tag Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:34 ~ Ashar 14:54 ~ Maghrib 17:33 ~ Isya' 18:43
# 0309 tag Subuh 04:17 ~ Terbit 05:31 ~ Dzuhur 11:34 ~ Ashar 14:53 ~ Maghrib 17:33 ~ Isya' 18:43
# 0409 tag Subuh 04:17 ~ Terbit 05:31 ~ Dzuhur 11:34 ~ Ashar 14:53 ~ Maghrib 17:33 ~ Isya' 18:43
# 0509 tag Subuh 04:17 ~ Terbit 05:30 ~ Dzuhur 11:34 ~ Ashar 14:52 ~ Maghrib 17:33 ~ Isya' 18:43
# 0609 tag Subuh 04:16 ~ Terbit 05:30 ~ Dzuhur 11:33 ~ Ashar 14:52 ~ Maghrib 17:33 ~ Isya' 18:42
# 0709 tag Subuh 04:16 ~ Terbit 05:29 ~ Dzuhur 11:33 ~ Ashar 14:51 ~ Maghrib 17:33 ~ Isya' 18:42
# 0809 tag Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:33 ~ Ashar 14:51 ~ Maghrib 17:32 ~ Isya' 18:42
# 0909 tag Subuh 04:15 ~ Terbit 05:28 ~ Dzuhur 11:32 ~ Ashar 14:50 ~ Maghrib 17:32 ~ Isya' 18:42
# 1009 tag Subuh 04:14 ~ Terbit 05:28 ~ Dzuhur 11:32 ~ Ashar 14:49 ~ Maghrib 17:32 ~ Isya' 18:42
# 1109 tag Subuh 04:13 ~ Terbit 05:27 ~ Dzuhur 11:31 ~ Ashar 14:49 ~ Maghrib 17:32 ~ Isya' 18:42
# 1209 tag Subuh 04:13 ~ Terbit 05:26 ~ Dzuhur 11:31 ~ Ashar 14:48 ~ Maghrib 17:32 ~ Isya' 18:41
# 1309 tag Subuh 04:12 ~ Terbit 05:26 ~ Dzuhur 11:31 ~ Ashar 14:48 ~ Maghrib 17:32 ~ Isya' 18:41
# 1409 tag Subuh 04:12 ~ Terbit 05:25 ~ Dzuhur 11:30 ~ Ashar 14:47 ~ Maghrib 17:32 ~ Isya' 18:41
# 1509 tag Subuh 04:11 ~ Terbit 05:25 ~ Dzuhur 11:30 ~ Ashar 14:46 ~ Maghrib 17:31 ~ Isya' 18:41
# 1609 tag Subuh 04:11 ~ Terbit 05:24 ~ Dzuhur 11:30 ~ Ashar 14:46 ~ Maghrib 17:31 ~ Isya' 18:41
# 1709 tag Subuh 04:10 ~ Terbit 05:24 ~ Dzuhur 11:29 ~ Ashar 14:45 ~ Maghrib 17:31 ~ Isya' 18:41
# 1809 tag Subuh 04:10 ~ Terbit 05:23 ~ Dzuhur 11:29 ~ Ashar 14:44 ~ Maghrib 17:31 ~ Isya' 18:40
# 1909 tag Subuh 04:09 ~ Terbit 05:22 ~ Dzuhur 11:29 ~ Ashar 14:44 ~ Maghrib 17:31 ~ Isya' 18:40
# 2009 tag Subuh 04:08 ~ Terbit 05:22 ~ Dzuhur 11:28 ~ Ashar 14:43 ~ Maghrib 17:31 ~ Isya' 18:40
# 2109 tag Subuh 04:08 ~ Terbit 05:21 ~ Dzuhur 11:28 ~ Ashar 14:42 ~ Maghrib 17:31 ~ Isya' 18:40
# 2209 tag Subuh 04:07 ~ Terbit 05:21 ~ Dzuhur 11:28 ~ Ashar 14:41 ~ Maghrib 17:31 ~ Isya' 18:40
# 2309 tag Subuh 04:07 ~ Terbit 05:20 ~ Dzuhur 11:27 ~ Ashar 14:41 ~ Maghrib 17:30 ~ Isya' 18:40
# 2409 tag Subuh 04:06 ~ Terbit 05:20 ~ Dzuhur 11:27 ~ Ashar 14:40 ~ Maghrib 17:30 ~ Isya' 18:40
# 2509 tag Subuh 04:06 ~ Terbit 05:19 ~ Dzuhur 11:27 ~ Ashar 14:39 ~ Maghrib 17:30 ~ Isya' 18:40
# 2609 tag Subuh 04:05 ~ Terbit 05:18 ~ Dzuhur 11:26 ~ Ashar 14:38 ~ Maghrib 17:30 ~ Isya' 18:39
# 2709 tag Subuh 04:04 ~ Terbit 05:18 ~ Dzuhur 11:26 ~ Ashar 14:38 ~ Maghrib 17:30 ~ Isya' 18:39
# 2809 tag Subuh 04:04 ~ Terbit 05:17 ~ Dzuhur 11:25 ~ Ashar 14:37 ~ Maghrib 17:30 ~ Isya' 18:39
# 2909 tag Subuh 04:03 ~ Terbit 05:17 ~ Dzuhur 11:25 ~ Ashar 14:36 ~ Maghrib 17:30 ~ Isya' 18:39
# 3009 tag Subuh 04:03 ~ Terbit 05:16 ~ Dzuhur 11:25 ~ Ashar 14:35 ~ Maghrib 17:30 ~ Isya' 18:39

# 0110 tag Subuh 04:02 ~ Terbit 05:16 ~ Dzuhur 11:24 ~ Ashar 14:34 ~ Maghrib 17:29 ~ Isya' 18:39
# 0210 tag Subuh 04:01 ~ Terbit 05:15 ~ Dzuhur 11:24 ~ Ashar 14:34 ~ Maghrib 17:29 ~ Isya' 18:39
# 0310 tag Subuh 04:01 ~ Terbit 05:15 ~ Dzuhur 11:24 ~ Ashar 14:33 ~ Maghrib 17:29 ~ Isya' 18:39
# 0410 tag Subuh 04:00 ~ Terbit 05:14 ~ Dzuhur 11:24 ~ Ashar 14:32 ~ Maghrib 17:29 ~ Isya' 18:39
# 0510 tag Subuh 04:00 ~ Terbit 05:13 ~ Dzuhur 11:23 ~ Ashar 14:31 ~ Maghrib 17:29 ~ Isya' 18:39
# 0610 tag Subuh 03:59 ~ Terbit 05:13 ~ Dzuhur 11:23 ~ Ashar 14:30 ~ Maghrib 17:29 ~ Isya' 18:39
# 0710 tag Subuh 03:58 ~ Terbit 05:12 ~ Dzuhur 11:23 ~ Ashar 14:29 ~ Maghrib 17:29 ~ Isya' 18:39
# 0810 tag Subuh 03:58 ~ Terbit 05:12 ~ Dzuhur 11:22 ~ Ashar 14:28 ~ Maghrib 17:29 ~ Isya' 18:39
# 0910 tag Subuh 03:57 ~ Terbit 05:11 ~ Dzuhur 11:22 ~ Ashar 14:28 ~ Maghrib 17:29 ~ Isya' 18:39
# 1010 tag Subuh 03:57 ~ Terbit 05:11 ~ Dzuhur 11:22 ~ Ashar 14:27 ~ Maghrib 17:29 ~ Isya' 18:39
# 1110 tag Subuh 03:56 ~ Terbit 05:10 ~ Dzuhur 11:21 ~ Ashar 14:26 ~ Maghrib 17:29 ~ Isya' 18:39
# 1210 tag Subuh 03:56 ~ Terbit 05:10 ~ Dzuhur 11:21 ~ Ashar 14:25 ~ Maghrib 17:29 ~ Isya' 18:39
# 1310 tag Subuh 03:55 ~ Terbit 05:09 ~ Dzuhur 11:21 ~ Ashar 14:24 ~ Maghrib 17:29 ~ Isya' 18:39
# 1410 tag Subuh 03:55 ~ Terbit 05:09 ~ Dzuhur 11:21 ~ Ashar 14:23 ~ Maghrib 17:29 ~ Isya' 18:39
# 1510 tag Subuh 03:54 ~ Terbit 05:09 ~ Dzuhur 11:20 ~ Ashar 14:23 ~ Maghrib 17:29 ~ Isya' 18:39
# 1610 tag Subuh 03:53 ~ Terbit 05:08 ~ Dzuhur 11:20 ~ Ashar 14:23 ~ Maghrib 17:29 ~ Isya' 18:39
# 1710 tag Subuh 03:53 ~ Terbit 05:08 ~ Dzuhur 11:20 ~ Ashar 14:24 ~ Maghrib 17:29 ~ Isya' 18:39
# 1810 tag Subuh 03:52 ~ Terbit 05:07 ~ Dzuhur 11:20 ~ Ashar 14:24 ~ Maghrib 17:29 ~ Isya' 18:39
# 1910 tag Subuh 03:52 ~ Terbit 05:07 ~ Dzuhur 11:20 ~ Ashar 14:25 ~ Maghrib 17:29 ~ Isya' 18:39
# 2010 tag Subuh 03:51 ~ Terbit 05:06 ~ Dzuhur 11:19 ~ Ashar 14:25 ~ Maghrib 17:29 ~ Isya' 18:39
# 2110 tag Subuh 03:51 ~ Terbit 05:06 ~ Dzuhur 11:19 ~ Ashar 14:26 ~ Maghrib 17:29 ~ Isya' 18:40
# 2210 tag Subuh 03:50 ~ Terbit 05:06 ~ Dzuhur 11:19 ~ Ashar 14:27 ~ Maghrib 17:29 ~ Isya' 18:40
# 2310 tag Subuh 03:50 ~ Terbit 05:05 ~ Dzuhur 11:19 ~ Ashar 14:27 ~ Maghrib 17:29 ~ Isya' 18:40
# 2410 tag Subuh 03:49 ~ Terbit 05:05 ~ Dzuhur 11:19 ~ Ashar 14:28 ~ Maghrib 17:29 ~ Isya' 18:40
# 2510 tag Subuh 03:49 ~ Terbit 05:05 ~ Dzuhur 11:19 ~ Ashar 14:28 ~ Maghrib 17:29 ~ Isya' 18:40
# 2610 tag Subuh 03:48 ~ Terbit 05:04 ~ Dzuhur 11:19 ~ Ashar 14:29 ~ Maghrib 17:29 ~ Isya' 18:40
# 2710 tag Subuh 03:48 ~ Terbit 05:04 ~ Dzuhur 11:18 ~ Ashar 14:29 ~ Maghrib 17:29 ~ Isya' 18:41
# 2810 tag Subuh 03:48 ~ Terbit 05:04 ~ Dzuhur 11:18 ~ Ashar 14:30 ~ Maghrib 17:29 ~ Isya' 18:41
# 2910 tag Subuh 03:47 ~ Terbit 05:03 ~ Dzuhur 11:18 ~ Ashar 14:30 ~ Maghrib 17:29 ~ Isya' 18:41
# 3010 tag Subuh 03:47 ~ Terbit 05:03 ~ Dzuhur 11:18 ~ Ashar 14:31 ~ Maghrib 17:29 ~ Isya' 18:41
# 3110 tag Subuh 03:46 ~ Terbit 05:03 ~ Dzuhur 11:18 ~ Ashar 14:31 ~ Maghrib 17:30 ~ Isya' 18:42

# 0111 tag Subuh 03:46 ~ Terbit 05:02 ~ Dzuhur 11:18 ~ Ashar 14:32 ~ Maghrib 17:30 ~ Isya' 18:42
# 0211 tag Subuh 03:46 ~ Terbit 05:02 ~ Dzuhur 11:18 ~ Ashar 14:33 ~ Maghrib 17:30 ~ Isya' 18:42
# 0311 tag Subuh 03:45 ~ Terbit 05:02 ~ Dzuhur 11:18 ~ Ashar 14:33 ~ Maghrib 17:30 ~ Isya' 18:43
# 0411 tag Subuh 03:45 ~ Terbit 05:02 ~ Dzuhur 11:18 ~ Ashar 14:34 ~ Maghrib 17:30 ~ Isya' 18:43
# 0511 tag Subuh 03:44 ~ Terbit 05:02 ~ Dzuhur 11:18 ~ Ashar 14:34 ~ Maghrib 17:30 ~ Isya' 18:43
# 0611 tag Subuh 03:44 ~ Terbit 05:01 ~ Dzuhur 11:18 ~ Ashar 14:35 ~ Maghrib 17:31 ~ Isya' 18:43
# 0711 tag Subuh 03:44 ~ Terbit 05:01 ~ Dzuhur 11:18 ~ Ashar 14:35 ~ Maghrib 17:31 ~ Isya' 18:44
# 0811 tag Subuh 03:44 ~ Terbit 05:01 ~ Dzuhur 11:18 ~ Ashar 14:36 ~ Maghrib 17:31 ~ Isya' 18:44
# 0911 tag Subuh 03:43 ~ Terbit 05:01 ~ Dzuhur 11:18 ~ Ashar 14:36 ~ Maghrib 17:31 ~ Isya' 18:45
# 1011 tag Subuh 03:43 ~ Terbit 05:01 ~ Dzuhur 11:18 ~ Ashar 14:37 ~ Maghrib 17:32 ~ Isya' 18:45
# 1111 tag Subuh 03:43 ~ Terbit 05:01 ~ Dzuhur 11:18 ~ Ashar 14:37 ~ Maghrib 17:32 ~ Isya' 18:45
# 1211 tag Subuh 03:43 ~ Terbit 05:01 ~ Dzuhur 11:18 ~ Ashar 14:38 ~ Maghrib 17:32 ~ Isya' 18:46
# 1311 tag Subuh 03:42 ~ Terbit 05:01 ~ Dzuhur 11:19 ~ Ashar 14:38 ~ Maghrib 17:33 ~ Isya' 18:46
# 1411 tag Subuh 03:42 ~ Terbit 05:01 ~ Dzuhur 11:19 ~ Ashar 14:39 ~ Maghrib 17:33 ~ Isya' 18:47
# 1511 tag Subuh 03:42 ~ Terbit 05:01 ~ Dzuhur 11:19 ~ Ashar 14:39 ~ Maghrib 17:33 ~ Isya' 18:47
# 1611 tag Subuh 03:42 ~ Terbit 05:01 ~ Dzuhur 11:19 ~ Ashar 14:40 ~ Maghrib 17:33 ~ Isya' 18:48
# 1711 tag Subuh 03:42 ~ Terbit 05:01 ~ Dzuhur 11:19 ~ Ashar 14:40 ~ Maghrib 17:34 ~ Isya' 18:48
# 1811 tag Subuh 03:42 ~ Terbit 05:01 ~ Dzuhur 11:19 ~ Ashar 14:41 ~ Maghrib 17:34 ~ Isya' 18:49
# 1911 tag Subuh 03:41 ~ Terbit 05:01 ~ Dzuhur 11:20 ~ Ashar 14:42 ~ Maghrib 17:35 ~ Isya' 18:49
# 2011 tag Subuh 03:41 ~ Terbit 05:01 ~ Dzuhur 11:20 ~ Ashar 14:42 ~ Maghrib 17:35 ~ Isya' 18:50
# 2111 tag Subuh 03:41 ~ Terbit 05:01 ~ Dzuhur 11:20 ~ Ashar 14:43 ~ Maghrib 17:35 ~ Isya' 18:50
# 2211 tag Subuh 03:41 ~ Terbit 05:01 ~ Dzuhur 11:20 ~ Ashar 14:43 ~ Maghrib 17:36 ~ Isya' 18:51
# 2311 tag Subuh 03:41 ~ Terbit 05:01 ~ Dzuhur 11:20 ~ Ashar 14:44 ~ Maghrib 17:36 ~ Isya' 18:51
# 2411 tag Subuh 03:41 ~ Terbit 05:01 ~ Dzuhur 11:21 ~ Ashar 14:44 ~ Maghrib 17:37 ~ Isya' 18:52
# 2511 tag Subuh 03:41 ~ Terbit 05:01 ~ Dzuhur 11:21 ~ Ashar 14:45 ~ Maghrib 17:37 ~ Isya' 18:52
# 2611 tag Subuh 03:41 ~ Terbit 05:01 ~ Dzuhur 11:21 ~ Ashar 14:45 ~ Maghrib 17:37 ~ Isya' 18:53
# 2711 tag Subuh 03:41 ~ Terbit 05:02 ~ Dzuhur 11:22 ~ Ashar 14:46 ~ Maghrib 17:38 ~ Isya' 18:53
# 2811 tag Subuh 03:41 ~ Terbit 05:02 ~ Dzuhur 11:22 ~ Ashar 14:47 ~ Maghrib 17:38 ~ Isya' 18:54
# 2911 tag Subuh 03:41 ~ Terbit 05:02 ~ Dzuhur 11:22 ~ Ashar 14:47 ~ Maghrib 17:39 ~ Isya' 18:54
# 3011 tag Subuh 03:41 ~ Terbit 05:02 ~ Dzuhur 11:23 ~ Ashar 14:48 ~ Maghrib 17:39 ~ Isya' 18:55

# 0112 tag Subuh 03:42 ~ Terbit 05:02 ~ Dzuhur 11:23 ~ Ashar 14:48 ~ Maghrib 17:40 ~ Isya' 18:55
# 0212 tag Subuh 03:42 ~ Terbit 05:03 ~ Dzuhur 11:23 ~ Ashar 14:49 ~ Maghrib 17:40 ~ Isya' 18:56
# 0312 tag Subuh 03:42 ~ Terbit 05:03 ~ Dzuhur 11:24 ~ Ashar 14:49 ~ Maghrib 17:41 ~ Isya' 18:57
# 0412 tag Subuh 03:42 ~ Terbit 05:03 ~ Dzuhur 11:24 ~ Ashar 14:50 ~ Maghrib 17:41 ~ Isya' 18:57
# 0512 tag Subuh 03:42 ~ Terbit 05:04 ~ Dzuhur 11:25 ~ Ashar 14:50 ~ Maghrib 17:42 ~ Isya' 18:58
# 0612 tag Subuh 03:43 ~ Terbit 05:04 ~ Dzuhur 11:25 ~ Ashar 14:51 ~ Maghrib 17:42 ~ Isya' 18:58
# 0712 tag Subuh 03:43 ~ Terbit 05:04 ~ Dzuhur 11:25 ~ Ashar 14:52 ~ Maghrib 17:43 ~ Isya' 18:59
# 0812 tag Subuh 03:43 ~ Terbit 05:04 ~ Dzuhur 11:26 ~ Ashar 14:52 ~ Maghrib 17:43 ~ Isya' 19:00
# 0912 tag Subuh 03:43 ~ Terbit 05:05 ~ Dzuhur 11:26 ~ Ashar 14:53 ~ Maghrib 17:44 ~ Isya' 19:00
# 1012 tag Subuh 03:44 ~ Terbit 05:05 ~ Dzuhur 11:27 ~ Ashar 14:53 ~ Maghrib 17:44 ~ Isya' 19:01
# 1112 tag Subuh 03:44 ~ Terbit 05:06 ~ Dzuhur 11:27 ~ Ashar 14:54 ~ Maghrib 17:45 ~ Isya' 19:01
# 1212 tag Subuh 03:44 ~ Terbit 05:06 ~ Dzuhur 11:28 ~ Ashar 14:54 ~ Maghrib 17:45 ~ Isya' 19:02
# 1312 tag Subuh 03:45 ~ Terbit 05:06 ~ Dzuhur 11:28 ~ Ashar 14:55 ~ Maghrib 17:46 ~ Isya' 19:02
# 1412 tag Subuh 03:45 ~ Terbit 05:07 ~ Dzuhur 11:28 ~ Ashar 14:56 ~ Maghrib 17:46 ~ Isya' 19:03
# 1512 tag Subuh 03:45 ~ Terbit 05:07 ~ Dzuhur 11:29 ~ Ashar 14:56 ~ Maghrib 17:47 ~ Isya' 19:04
# 1612 tag Subuh 03:46 ~ Terbit 05:08 ~ Dzuhur 11:29 ~ Ashar 14:57 ~ Maghrib 17:47 ~ Isya' 19:04
# 1712 tag Subuh 03:46 ~ Terbit 05:08 ~ Dzuhur 11:30 ~ Ashar 14:57 ~ Maghrib 17:48 ~ Isya' 19:05
# 1812 tag Subuh 03:47 ~ Terbit 05:09 ~ Dzuhur 11:30 ~ Ashar 14:58 ~ Maghrib 17:48 ~ Isya' 19:05
# 1912 tag Subuh 03:47 ~ Terbit 05:09 ~ Dzuhur 11:31 ~ Ashar 14:58 ~ Maghrib 17:49 ~ Isya' 19:06
# 2012 tag Subuh 03:47 ~ Terbit 05:10 ~ Dzuhur 11:31 ~ Ashar 14:59 ~ Maghrib 17:49 ~ Isya' 19:06
# 2112 tag Subuh 03:48 ~ Terbit 05:10 ~ Dzuhur 11:32 ~ Ashar 14:59 ~ Maghrib 17:50 ~ Isya' 19:07
# 2212 tag Subuh 03:48 ~ Terbit 05:10 ~ Dzuhur 11:32 ~ Ashar 15:00 ~ Maghrib 17:50 ~ Isya' 19:07
# 2312 tag Subuh 03:49 ~ Terbit 05:11 ~ Dzuhur 11:33 ~ Ashar 15:00 ~ Maghrib 17:51 ~ Isya' 19:08
# 2412 tag Subuh 03:49 ~ Terbit 05:11 ~ Dzuhur 11:33 ~ Ashar 15:01 ~ Maghrib 17:51 ~ Isya' 19:08
# 2512 tag Subuh 03:50 ~ Terbit 05:12 ~ Dzuhur 11:34 ~ Ashar 15:01 ~ Maghrib 17:52 ~ Isya' 19:09
# 2612 tag Subuh 03:50 ~ Terbit 05:12 ~ Dzuhur 11:34 ~ Ashar 15:02 ~ Maghrib 17:52 ~ Isya' 19:09
# 2712 tag Subuh 03:51 ~ Terbit 05:13 ~ Dzuhur 11:35 ~ Ashar 15:02 ~ Maghrib 17:53 ~ Isya' 19:10
# 2812 tag Subuh 03:51 ~ Terbit 05:14 ~ Dzuhur 11:35 ~ Ashar 15:03 ~ Maghrib 17:53 ~ Isya' 19:10
# 2912 tag Subuh 03:52 ~ Terbit 05:14 ~ Dzuhur 11:36 ~ Ashar 15:03 ~ Maghrib 17:54 ~ Isya' 19:10
# 3012 tag Subuh 03:53 ~ Terbit 05:15 ~ Dzuhur 11:36 ~ Ashar 15:03 ~ Maghrib 17:54 ~ Isya' 19:11
# 3112 tag Subuh 03:53 ~ Terbit 05:15 ~ Dzuhur 11:37 ~ Ashar 15:04 ~ Maghrib 17:55 ~ Isya' 19:11


# Imsakiyah Ramadhan 2014 / 1435 H ~ Kota Malang
# Sumber: http://www.rukyatulhilal.org/imsakiyah/index.php?id=210
# --------------------------------------------------------------------------------
# 2906 malang Imsak 04:11 ~ Subuh 04:21 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:25 ~ Isya' 18:40
# 3006 malang Imsak 04:12 ~ Subuh 04:22 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:25 ~ Isya' 18:40
# 0107 malang Imsak 04:12 ~ Subuh 04:22 ~ Dzuhur 11:35 ~ Ashar 14:56 ~ Maghrib 17:25 ~ Isya' 18:40
# 0207 malang Imsak 04:12 ~ Subuh 04:22 ~ Dzuhur 11:36 ~ Ashar 14:56 ~ Maghrib 17:26 ~ Isya' 18:41
# 0307 malang Imsak 04:12 ~ Subuh 04:22 ~ Dzuhur 11:36 ~ Ashar 14:56 ~ Maghrib 17:26 ~ Isya' 18:41
# 0407 malang Imsak 04:12 ~ Subuh 04:22 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:26 ~ Isya' 18:41
# 0507 malang Imsak 04:12 ~ Subuh 04:22 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:26 ~ Isya' 18:41
# 0607 malang Imsak 04:13 ~ Subuh 04:23 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:27 ~ Isya' 18:41
# 0707 malang Imsak 04:13 ~ Subuh 04:23 ~ Dzuhur 11:36 ~ Ashar 14:57 ~ Maghrib 17:27 ~ Isya' 18:41
# 0807 malang Imsak 04:13 ~ Subuh 04:23 ~ Dzuhur 11:37 ~ Ashar 14:57 ~ Maghrib 17:27 ~ Isya' 18:42
# 0907 malang Imsak 04:13 ~ Subuh 04:23 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:27 ~ Isya' 18:42
# 1007 malang Imsak 04:13 ~ Subuh 04:23 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:27 ~ Isya' 18:42
# 1107 malang Imsak 04:13 ~ Subuh 04:23 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:42
# 1207 malang Imsak 04:13 ~ Subuh 04:23 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:42
# 1307 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:42
# 1407 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:37 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:42
# 1507 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 1607 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 1707 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 1807 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 1907 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 2007 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 2107 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 2207 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 2307 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 2407 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 2507 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 2607 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:43
# 2707 malang Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:30 ~ Isya' 18:44


# Imsakiyah Ramadhan 2014 / 1435 H ~ Kota Tulungagung
# Sumber: http://www.rukyatulhilal.org/imsakiyah/index.php?id=466
# --------------------------------------------------------------------------------
# 2906 tulungagung Imsak 04:14 ~ Subuh 04:24 ~ Dzuhur 11:38 ~ Ashar 14:58 ~ Maghrib 17:28 ~ Isya' 18:43
# 3006 tulungagung Imsak 04:15 ~ Subuh 04:25 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:28 ~ Isya' 18:43
# 0107 tulungagung Imsak 04:15 ~ Subuh 04:25 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:28 ~ Isya' 18:43
# 0207 tulungagung Imsak 04:15 ~ Subuh 04:25 ~ Dzuhur 11:38 ~ Ashar 14:59 ~ Maghrib 17:28 ~ Isya' 18:43
# 0307 tulungagung Imsak 04:15 ~ Subuh 04:25 ~ Dzuhur 11:39 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:43
# 0407 tulungagung Imsak 04:15 ~ Subuh 04:25 ~ Dzuhur 11:39 ~ Ashar 14:59 ~ Maghrib 17:29 ~ Isya' 18:44
# 0507 tulungagung Imsak 04:15 ~ Subuh 04:25 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:29 ~ Isya' 18:44
# 0607 tulungagung Imsak 04:16 ~ Subuh 04:26 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:29 ~ Isya' 18:44
# 0707 tulungagung Imsak 04:16 ~ Subuh 04:26 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:30 ~ Isya' 18:44
# 0807 tulungagung Imsak 04:16 ~ Subuh 04:26 ~ Dzuhur 11:39 ~ Ashar 15:00 ~ Maghrib 17:30 ~ Isya' 18:44
# 0907 tulungagung Imsak 04:16 ~ Subuh 04:26 ~ Dzuhur 11:40 ~ Ashar 15:00 ~ Maghrib 17:30 ~ Isya' 18:45
# 1007 tulungagung Imsak 04:16 ~ Subuh 04:26 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:30 ~ Isya' 18:45
# 1107 tulungagung Imsak 04:16 ~ Subuh 04:26 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:30 ~ Isya' 18:45
# 1207 tulungagung Imsak 04:16 ~ Subuh 04:26 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:31 ~ Isya' 18:45
# 1307 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:31 ~ Isya' 18:45
# 1407 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:31 ~ Isya' 18:45
# 1507 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:40 ~ Ashar 15:01 ~ Maghrib 17:31 ~ Isya' 18:45
# 1607 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:40 ~ Ashar 15:02 ~ Maghrib 17:31 ~ Isya' 18:45
# 1707 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:32 ~ Isya' 18:46
# 1807 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:32 ~ Isya' 18:46
# 1907 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:32 ~ Isya' 18:46
# 2007 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:32 ~ Isya' 18:46
# 2107 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:32 ~ Isya' 18:46
# 2207 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2307 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2407 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2507 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2607 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
# 2707 tulungagung Imsak 04:17 ~ Subuh 04:27 ~ Dzuhur 11:41 ~ Ashar 15:02 ~ Maghrib 17:33 ~ Isya' 18:46
