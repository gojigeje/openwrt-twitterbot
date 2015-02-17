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

  tgl=$(date +%m%d);
  tgl2=$(date +%b/%d); 
  jadwal=$(cat "plugin/imsakiyah.sh" | grep "$key" | grep $tgl | sed 's/# '$tgl' '$key' //')

  # set tweet_status
  status="[$prefix] Kota $kota hari ini [$tgl2]: $jadwal"
  echo "[twit] : $status"
  twit -s "$status"
  # ttytter -status="$status"
  
  #sleep 5
  #status2="[$prefix] Kota $kota diambil dari $url ~ $ayosholat"
  #echo "[ttytter] : $status2"
  #ttytter -status="$status2"

  echo "- done -"
  exit 1
}

# JADWAL SHOLAT 2015 KOTA MALANG
# Sumber: http://www.jadwalsholat.org/adzan/monthly.php?id=141
# ------------------------------------------------------------------------------------------
# 0101 mlg Subuh 03:51 ~ Terbit 05:13 ~ Dzuhur 11:34 ~ Ashar 15:01 ~ Maghrib 17:51 ~ Isya' 19:08
# 0102 mlg Subuh 03:51 ~ Terbit 05:13 ~ Dzuhur 11:35 ~ Ashar 15:01 ~ Maghrib 17:52 ~ Isya' 19:09
# 0103 mlg Subuh 03:52 ~ Terbit 05:14 ~ Dzuhur 11:35 ~ Ashar 15:02 ~ Maghrib 17:52 ~ Isya' 19:09
# 0104 mlg Subuh 03:52 ~ Terbit 05:14 ~ Dzuhur 11:35 ~ Ashar 15:02 ~ Maghrib 17:53 ~ Isya' 19:09
# 0105 mlg Subuh 03:53 ~ Terbit 05:15 ~ Dzuhur 11:36 ~ Ashar 15:02 ~ Maghrib 17:53 ~ Isya' 19:10
# 0106 mlg Subuh 03:54 ~ Terbit 05:15 ~ Dzuhur 11:36 ~ Ashar 15:03 ~ Maghrib 17:53 ~ Isya' 19:10
# 0107 mlg Subuh 03:54 ~ Terbit 05:16 ~ Dzuhur 11:37 ~ Ashar 15:03 ~ Maghrib 17:54 ~ Isya' 19:10
# 0108 mlg Subuh 03:55 ~ Terbit 05:16 ~ Dzuhur 11:37 ~ Ashar 15:03 ~ Maghrib 17:54 ~ Isya' 19:10
# 0109 mlg Subuh 03:55 ~ Terbit 05:17 ~ Dzuhur 11:38 ~ Ashar 15:04 ~ Maghrib 17:55 ~ Isya' 19:11
# 0110 mlg Subuh 03:56 ~ Terbit 05:17 ~ Dzuhur 11:38 ~ Ashar 15:04 ~ Maghrib 17:55 ~ Isya' 19:11
# 0111 mlg Subuh 03:57 ~ Terbit 05:18 ~ Dzuhur 11:38 ~ Ashar 15:04 ~ Maghrib 17:55 ~ Isya' 19:11
# 0112 mlg Subuh 03:57 ~ Terbit 05:18 ~ Dzuhur 11:39 ~ Ashar 15:04 ~ Maghrib 17:55 ~ Isya' 19:11
# 0113 mlg Subuh 03:58 ~ Terbit 05:19 ~ Dzuhur 11:39 ~ Ashar 15:04 ~ Maghrib 17:56 ~ Isya' 19:11
# 0114 mlg Subuh 03:59 ~ Terbit 05:19 ~ Dzuhur 11:40 ~ Ashar 15:05 ~ Maghrib 17:56 ~ Isya' 19:12
# 0115 mlg Subuh 03:59 ~ Terbit 05:20 ~ Dzuhur 11:40 ~ Ashar 15:05 ~ Maghrib 17:56 ~ Isya' 19:12
# 0116 mlg Subuh 04:00 ~ Terbit 05:20 ~ Dzuhur 11:40 ~ Ashar 15:05 ~ Maghrib 17:56 ~ Isya' 19:12
# 0117 mlg Subuh 04:00 ~ Terbit 05:21 ~ Dzuhur 11:41 ~ Ashar 15:05 ~ Maghrib 17:57 ~ Isya' 19:12
# 0118 mlg Subuh 04:01 ~ Terbit 05:21 ~ Dzuhur 11:41 ~ Ashar 15:05 ~ Maghrib 17:57 ~ Isya' 19:12
# 0119 mlg Subuh 04:02 ~ Terbit 05:22 ~ Dzuhur 11:41 ~ Ashar 15:05 ~ Maghrib 17:57 ~ Isya' 19:12
# 0120 mlg Subuh 04:02 ~ Terbit 05:22 ~ Dzuhur 11:42 ~ Ashar 15:05 ~ Maghrib 17:57 ~ Isya' 19:12
# 0121 mlg Subuh 04:03 ~ Terbit 05:23 ~ Dzuhur 11:42 ~ Ashar 15:05 ~ Maghrib 17:57 ~ Isya' 19:12
# 0122 mlg Subuh 04:03 ~ Terbit 05:23 ~ Dzuhur 11:42 ~ Ashar 15:05 ~ Maghrib 17:58 ~ Isya' 19:12
# 0123 mlg Subuh 04:04 ~ Terbit 05:23 ~ Dzuhur 11:43 ~ Ashar 15:05 ~ Maghrib 17:58 ~ Isya' 19:12
# 0124 mlg Subuh 04:04 ~ Terbit 05:24 ~ Dzuhur 11:43 ~ Ashar 15:05 ~ Maghrib 17:58 ~ Isya' 19:12
# 0125 mlg Subuh 04:05 ~ Terbit 05:24 ~ Dzuhur 11:43 ~ Ashar 15:05 ~ Maghrib 17:58 ~ Isya' 19:12
# 0126 mlg Subuh 04:05 ~ Terbit 05:25 ~ Dzuhur 11:43 ~ Ashar 15:05 ~ Maghrib 17:58 ~ Isya' 19:12
# 0127 mlg Subuh 04:06 ~ Terbit 05:25 ~ Dzuhur 11:44 ~ Ashar 15:05 ~ Maghrib 17:58 ~ Isya' 19:12
# 0128 mlg Subuh 04:07 ~ Terbit 05:25 ~ Dzuhur 11:44 ~ Ashar 15:05 ~ Maghrib 17:58 ~ Isya' 19:12
# 0129 mlg Subuh 04:07 ~ Terbit 05:26 ~ Dzuhur 11:44 ~ Ashar 15:04 ~ Maghrib 17:58 ~ Isya' 19:12
# 0130 mlg Subuh 04:08 ~ Terbit 05:26 ~ Dzuhur 11:44 ~ Ashar 15:04 ~ Maghrib 17:58 ~ Isya' 19:12
# 0131 mlg Subuh 04:08 ~ Terbit 05:26 ~ Dzuhur 11:44 ~ Ashar 15:04 ~ Maghrib 17:58 ~ Isya' 19:12

# 0201 mlg Subuh 04:09 ~ Terbit 05:27 ~ Dzuhur 11:44 ~ Ashar 15:04 ~ Maghrib 17:58 ~ Isya' 19:11
# 0202 mlg Subuh 04:09 ~ Terbit 05:27 ~ Dzuhur 11:45 ~ Ashar 15:03 ~ Maghrib 17:58 ~ Isya' 19:11
# 0203 mlg Subuh 04:09 ~ Terbit 05:27 ~ Dzuhur 11:45 ~ Ashar 15:03 ~ Maghrib 17:58 ~ Isya' 19:11
# 0204 mlg Subuh 04:10 ~ Terbit 05:28 ~ Dzuhur 11:45 ~ Ashar 15:03 ~ Maghrib 17:58 ~ Isya' 19:11
# 0205 mlg Subuh 04:10 ~ Terbit 05:28 ~ Dzuhur 11:45 ~ Ashar 15:02 ~ Maghrib 17:58 ~ Isya' 19:11
# 0206 mlg Subuh 04:11 ~ Terbit 05:28 ~ Dzuhur 11:45 ~ Ashar 15:02 ~ Maghrib 17:58 ~ Isya' 19:10
# 0207 mlg Subuh 04:11 ~ Terbit 05:29 ~ Dzuhur 11:45 ~ Ashar 15:02 ~ Maghrib 17:58 ~ Isya' 19:10
# 0208 mlg Subuh 04:12 ~ Terbit 05:29 ~ Dzuhur 11:45 ~ Ashar 15:01 ~ Maghrib 17:57 ~ Isya' 19:10
# 0209 mlg Subuh 04:12 ~ Terbit 05:29 ~ Dzuhur 11:45 ~ Ashar 15:01 ~ Maghrib 17:57 ~ Isya' 19:10
# 0210 mlg Subuh 04:12 ~ Terbit 05:29 ~ Dzuhur 11:45 ~ Ashar 15:00 ~ Maghrib 17:57 ~ Isya' 19:09
# 0211 mlg Subuh 04:13 ~ Terbit 05:29 ~ Dzuhur 11:45 ~ Ashar 15:00 ~ Maghrib 17:57 ~ Isya' 19:09
# 0212 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:45 ~ Ashar 14:59 ~ Maghrib 17:57 ~ Isya' 19:09
# 0213 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:45 ~ Ashar 14:58 ~ Maghrib 17:56 ~ Isya' 19:08
# 0214 mlg Subuh 04:14 ~ Terbit 05:30 ~ Dzuhur 11:45 ~ Ashar 14:58 ~ Maghrib 17:56 ~ Isya' 19:08
# 0215 mlg Subuh 04:14 ~ Terbit 05:30 ~ Dzuhur 11:45 ~ Ashar 14:57 ~ Maghrib 17:56 ~ Isya' 19:08
# 0216 mlg Subuh 04:14 ~ Terbit 05:30 ~ Dzuhur 11:45 ~ Ashar 14:57 ~ Maghrib 17:56 ~ Isya' 19:07
# 0217 mlg Subuh 04:15 ~ Terbit 05:31 ~ Dzuhur 11:45 ~ Ashar 14:56 ~ Maghrib 17:55 ~ Isya' 19:07
# 0218 mlg Subuh 04:15 ~ Terbit 05:31 ~ Dzuhur 11:45 ~ Ashar 14:55 ~ Maghrib 17:55 ~ Isya' 19:07
# 0219 mlg Subuh 04:15 ~ Terbit 05:31 ~ Dzuhur 11:45 ~ Ashar 14:54 ~ Maghrib 17:55 ~ Isya' 19:06
# 0220 mlg Subuh 04:15 ~ Terbit 05:31 ~ Dzuhur 11:45 ~ Ashar 14:54 ~ Maghrib 17:55 ~ Isya' 19:06
# 0221 mlg Subuh 04:16 ~ Terbit 05:31 ~ Dzuhur 11:45 ~ Ashar 14:53 ~ Maghrib 17:54 ~ Isya' 19:05
# 0222 mlg Subuh 04:16 ~ Terbit 05:31 ~ Dzuhur 11:45 ~ Ashar 14:52 ~ Maghrib 17:54 ~ Isya' 19:05
# 0223 mlg Subuh 04:16 ~ Terbit 05:31 ~ Dzuhur 11:45 ~ Ashar 14:51 ~ Maghrib 17:54 ~ Isya' 19:04
# 0224 mlg Subuh 04:16 ~ Terbit 05:31 ~ Dzuhur 11:44 ~ Ashar 14:50 ~ Maghrib 17:53 ~ Isya' 19:04
# 0225 mlg Subuh 04:16 ~ Terbit 05:31 ~ Dzuhur 11:44 ~ Ashar 14:49 ~ Maghrib 17:53 ~ Isya' 19:04
# 0226 mlg Subuh 04:17 ~ Terbit 05:32 ~ Dzuhur 11:44 ~ Ashar 14:48 ~ Maghrib 17:53 ~ Isya' 19:03
# 0227 mlg Subuh 04:17 ~ Terbit 05:32 ~ Dzuhur 11:44 ~ Ashar 14:47 ~ Maghrib 17:52 ~ Isya' 19:03
# 0228 mlg Subuh 04:17 ~ Terbit 05:32 ~ Dzuhur 11:44 ~ Ashar 14:46 ~ Maghrib 17:52 ~ Isya' 19:02

# 0301 mlg Subuh 04:17 ~ Terbit 05:32 ~ Dzuhur 11:44 ~ Ashar 14:45 ~ Maghrib 17:51 ~ Isya' 19:02
# 0302 mlg Subuh 04:17 ~ Terbit 05:32 ~ Dzuhur 11:43 ~ Ashar 14:46 ~ Maghrib 17:51 ~ Isya' 19:01
# 0303 mlg Subuh 04:17 ~ Terbit 05:32 ~ Dzuhur 11:43 ~ Ashar 14:46 ~ Maghrib 17:51 ~ Isya' 19:01
# 0304 mlg Subuh 04:17 ~ Terbit 05:32 ~ Dzuhur 11:43 ~ Ashar 14:47 ~ Maghrib 17:50 ~ Isya' 19:00
# 0305 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:43 ~ Ashar 14:47 ~ Maghrib 17:50 ~ Isya' 19:00
# 0306 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:43 ~ Ashar 14:48 ~ Maghrib 17:49 ~ Isya' 18:59
# 0307 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:42 ~ Ashar 14:48 ~ Maghrib 17:49 ~ Isya' 18:59
# 0308 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:42 ~ Ashar 14:48 ~ Maghrib 17:48 ~ Isya' 18:58
# 0309 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:42 ~ Ashar 14:49 ~ Maghrib 17:48 ~ Isya' 18:58
# 0310 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:42 ~ Ashar 14:49 ~ Maghrib 17:47 ~ Isya' 18:57
# 0311 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:41 ~ Ashar 14:49 ~ Maghrib 17:47 ~ Isya' 18:57
# 0312 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:41 ~ Ashar 14:50 ~ Maghrib 17:46 ~ Isya' 18:56
# 0313 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:41 ~ Ashar 14:50 ~ Maghrib 17:46 ~ Isya' 18:55
# 0314 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:41 ~ Ashar 14:50 ~ Maghrib 17:45 ~ Isya' 18:55
# 0315 mlg Subuh 04:18 ~ Terbit 05:32 ~ Dzuhur 11:40 ~ Ashar 14:50 ~ Maghrib 17:45 ~ Isya' 18:54
# 0316 mlg Subuh 04:18 ~ Terbit 05:31 ~ Dzuhur 11:40 ~ Ashar 14:51 ~ Maghrib 17:44 ~ Isya' 18:54
# 0317 mlg Subuh 04:18 ~ Terbit 05:31 ~ Dzuhur 11:40 ~ Ashar 14:51 ~ Maghrib 17:44 ~ Isya' 18:53
# 0318 mlg Subuh 04:18 ~ Terbit 05:31 ~ Dzuhur 11:39 ~ Ashar 14:51 ~ Maghrib 17:43 ~ Isya' 18:53
# 0319 mlg Subuh 04:18 ~ Terbit 05:31 ~ Dzuhur 11:39 ~ Ashar 14:51 ~ Maghrib 17:43 ~ Isya' 18:52
# 0320 mlg Subuh 04:18 ~ Terbit 05:31 ~ Dzuhur 11:39 ~ Ashar 14:51 ~ Maghrib 17:42 ~ Isya' 18:52
# 0321 mlg Subuh 04:18 ~ Terbit 05:31 ~ Dzuhur 11:39 ~ Ashar 14:51 ~ Maghrib 17:42 ~ Isya' 18:51
# 0322 mlg Subuh 04:18 ~ Terbit 05:31 ~ Dzuhur 11:38 ~ Ashar 14:51 ~ Maghrib 17:41 ~ Isya' 18:51
# 0323 mlg Subuh 04:18 ~ Terbit 05:31 ~ Dzuhur 11:38 ~ Ashar 14:52 ~ Maghrib 17:41 ~ Isya' 18:50
# 0324 mlg Subuh 04:17 ~ Terbit 05:31 ~ Dzuhur 11:38 ~ Ashar 14:52 ~ Maghrib 17:40 ~ Isya' 18:50
# 0325 mlg Subuh 04:17 ~ Terbit 05:31 ~ Dzuhur 11:37 ~ Ashar 14:52 ~ Maghrib 17:40 ~ Isya' 18:49
# 0326 mlg Subuh 04:17 ~ Terbit 05:31 ~ Dzuhur 11:37 ~ Ashar 14:52 ~ Maghrib 17:39 ~ Isya' 18:49
# 0327 mlg Subuh 04:17 ~ Terbit 05:31 ~ Dzuhur 11:37 ~ Ashar 14:52 ~ Maghrib 17:39 ~ Isya' 18:48
# 0328 mlg Subuh 04:17 ~ Terbit 05:31 ~ Dzuhur 11:36 ~ Ashar 14:52 ~ Maghrib 17:38 ~ Isya' 18:48
# 0329 mlg Subuh 04:17 ~ Terbit 05:30 ~ Dzuhur 11:36 ~ Ashar 14:52 ~ Maghrib 17:38 ~ Isya' 18:47
# 0330 mlg Subuh 04:17 ~ Terbit 05:30 ~ Dzuhur 11:36 ~ Ashar 14:52 ~ Maghrib 17:37 ~ Isya' 18:47
# 0331 mlg Subuh 04:17 ~ Terbit 05:30 ~ Dzuhur 11:36 ~ Ashar 14:52 ~ Maghrib 17:37 ~ Isya' 18:46

# 0401 mlg Subuh 04:17 ~ Terbit 05:30 ~ Dzuhur 11:35 ~ Ashar 14:52 ~ Maghrib 17:36 ~ Isya' 18:46
# 0402 mlg Subuh 04:17 ~ Terbit 05:30 ~ Dzuhur 11:35 ~ Ashar 14:52 ~ Maghrib 17:36 ~ Isya' 18:45
# 0403 mlg Subuh 04:17 ~ Terbit 05:30 ~ Dzuhur 11:35 ~ Ashar 14:52 ~ Maghrib 17:35 ~ Isya' 18:45
# 0404 mlg Subuh 04:16 ~ Terbit 05:30 ~ Dzuhur 11:34 ~ Ashar 14:52 ~ Maghrib 17:35 ~ Isya' 18:44
# 0405 mlg Subuh 04:16 ~ Terbit 05:30 ~ Dzuhur 11:34 ~ Ashar 14:52 ~ Maghrib 17:34 ~ Isya' 18:44
# 0406 mlg Subuh 04:16 ~ Terbit 05:30 ~ Dzuhur 11:34 ~ Ashar 14:52 ~ Maghrib 17:34 ~ Isya' 18:43
# 0407 mlg Subuh 04:16 ~ Terbit 05:30 ~ Dzuhur 11:34 ~ Ashar 14:52 ~ Maghrib 17:33 ~ Isya' 18:43
# 0408 mlg Subuh 04:16 ~ Terbit 05:30 ~ Dzuhur 11:33 ~ Ashar 14:52 ~ Maghrib 17:33 ~ Isya' 18:42
# 0409 mlg Subuh 04:16 ~ Terbit 05:30 ~ Dzuhur 11:33 ~ Ashar 14:52 ~ Maghrib 17:32 ~ Isya' 18:42
# 0410 mlg Subuh 04:16 ~ Terbit 05:30 ~ Dzuhur 11:33 ~ Ashar 14:52 ~ Maghrib 17:32 ~ Isya' 18:41
# 0411 mlg Subuh 04:16 ~ Terbit 05:30 ~ Dzuhur 11:32 ~ Ashar 14:51 ~ Maghrib 17:31 ~ Isya' 18:41
# 0412 mlg Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:32 ~ Ashar 14:51 ~ Maghrib 17:31 ~ Isya' 18:41
# 0413 mlg Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:32 ~ Ashar 14:51 ~ Maghrib 17:30 ~ Isya' 18:40
# 0414 mlg Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:32 ~ Ashar 14:51 ~ Maghrib 17:30 ~ Isya' 18:40
# 0415 mlg Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:31 ~ Ashar 14:51 ~ Maghrib 17:29 ~ Isya' 18:39
# 0416 mlg Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:31 ~ Ashar 14:51 ~ Maghrib 17:29 ~ Isya' 18:39
# 0417 mlg Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:31 ~ Ashar 14:51 ~ Maghrib 17:28 ~ Isya' 18:39
# 0418 mlg Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:31 ~ Ashar 14:51 ~ Maghrib 17:28 ~ Isya' 18:38
# 0419 mlg Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:30 ~ Ashar 14:51 ~ Maghrib 17:28 ~ Isya' 18:38
# 0420 mlg Subuh 04:15 ~ Terbit 05:29 ~ Dzuhur 11:30 ~ Ashar 14:51 ~ Maghrib 17:27 ~ Isya' 18:38
# 0421 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:30 ~ Ashar 14:51 ~ Maghrib 17:27 ~ Isya' 18:37
# 0422 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:30 ~ Ashar 14:50 ~ Maghrib 17:26 ~ Isya' 18:37
# 0423 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:30 ~ Ashar 14:50 ~ Maghrib 17:26 ~ Isya' 18:37
# 0424 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:26 ~ Isya' 18:36
# 0425 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:25 ~ Isya' 18:36
# 0426 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:25 ~ Isya' 18:36
# 0427 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:25 ~ Isya' 18:36
# 0428 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:24 ~ Isya' 18:35
# 0429 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:29 ~ Ashar 14:50 ~ Maghrib 17:24 ~ Isya' 18:35
# 0430 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:28 ~ Ashar 14:50 ~ Maghrib 17:24 ~ Isya' 18:35

# 0501 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:28 ~ Ashar 14:50 ~ Maghrib 17:23 ~ Isya' 18:35
# 0502 mlg Subuh 04:14 ~ Terbit 05:29 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:23 ~ Isya' 18:34
# 0503 mlg Subuh 04:13 ~ Terbit 05:29 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:23 ~ Isya' 18:34
# 0504 mlg Subuh 04:13 ~ Terbit 05:29 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:22 ~ Isya' 18:34
# 0505 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:22 ~ Isya' 18:34
# 0506 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:22 ~ Isya' 18:34
# 0507 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:22 ~ Isya' 18:34
# 0508 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:21 ~ Isya' 18:33
# 0509 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:21 ~ Isya' 18:33
# 0510 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:21 ~ Isya' 18:33
# 0511 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:21 ~ Isya' 18:33
# 0512 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:21 ~ Isya' 18:33
# 0513 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:20 ~ Isya' 18:33
# 0514 mlg Subuh 04:13 ~ Terbit 05:30 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:20 ~ Isya' 18:33
# 0515 mlg Subuh 04:13 ~ Terbit 05:31 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:20 ~ Isya' 18:33
# 0516 mlg Subuh 04:13 ~ Terbit 05:31 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:20 ~ Isya' 18:33
# 0517 mlg Subuh 04:13 ~ Terbit 05:31 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:20 ~ Isya' 18:33
# 0518 mlg Subuh 04:14 ~ Terbit 05:31 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:20 ~ Isya' 18:33
# 0519 mlg Subuh 04:14 ~ Terbit 05:31 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:20 ~ Isya' 18:33
# 0520 mlg Subuh 04:14 ~ Terbit 05:31 ~ Dzuhur 11:27 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0521 mlg Subuh 04:14 ~ Terbit 05:32 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0522 mlg Subuh 04:14 ~ Terbit 05:32 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0523 mlg Subuh 04:14 ~ Terbit 05:32 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0524 mlg Subuh 04:14 ~ Terbit 05:32 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0525 mlg Subuh 04:14 ~ Terbit 05:32 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0526 mlg Subuh 04:14 ~ Terbit 05:33 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0527 mlg Subuh 04:14 ~ Terbit 05:33 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0528 mlg Subuh 04:14 ~ Terbit 05:33 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0529 mlg Subuh 04:15 ~ Terbit 05:33 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0530 mlg Subuh 04:15 ~ Terbit 05:33 ~ Dzuhur 11:28 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:33
# 0531 mlg Subuh 04:15 ~ Terbit 05:34 ~ Dzuhur 11:29 ~ Ashar 14:49 ~ Maghrib 17:19 ~ Isya' 18:34


# JADWAL SHOLAT (Juni - Desember) 2014 KOTA TULUNGAGUNG
# Sumber: http://www.jadwalsholat.org/adzan/monthly.php?id=295
# ------------------------------------------------------------------------------------------
# 0101 tag Subuh 03:54 ~ Terbit 05:16 ~ Dzuhur 11:37 ~ Ashar 15:04 ~ Maghrib 17:55 ~ Isya' 19:12
# 0102 tag Subuh 03:54 ~ Terbit 05:16 ~ Dzuhur 11:38 ~ Ashar 15:05 ~ Maghrib 17:55 ~ Isya' 19:12
# 0103 tag Subuh 03:55 ~ Terbit 05:17 ~ Dzuhur 11:38 ~ Ashar 15:05 ~ Maghrib 17:56 ~ Isya' 19:12
# 0104 tag Subuh 03:56 ~ Terbit 05:17 ~ Dzuhur 11:39 ~ Ashar 15:06 ~ Maghrib 17:56 ~ Isya' 19:13
# 0105 tag Subuh 03:56 ~ Terbit 05:18 ~ Dzuhur 11:39 ~ Ashar 15:06 ~ Maghrib 17:57 ~ Isya' 19:13
# 0106 tag Subuh 03:57 ~ Terbit 05:18 ~ Dzuhur 11:40 ~ Ashar 15:06 ~ Maghrib 17:57 ~ Isya' 19:13
# 0107 tag Subuh 03:57 ~ Terbit 05:19 ~ Dzuhur 11:40 ~ Ashar 15:06 ~ Maghrib 17:57 ~ Isya' 19:14
# 0108 tag Subuh 03:58 ~ Terbit 05:19 ~ Dzuhur 11:41 ~ Ashar 15:07 ~ Maghrib 17:58 ~ Isya' 19:14
# 0109 tag Subuh 03:59 ~ Terbit 05:20 ~ Dzuhur 11:41 ~ Ashar 15:07 ~ Maghrib 17:58 ~ Isya' 19:14
# 0110 tag Subuh 03:59 ~ Terbit 05:20 ~ Dzuhur 11:41 ~ Ashar 15:07 ~ Maghrib 17:58 ~ Isya' 19:14
# 0111 tag Subuh 04:00 ~ Terbit 05:21 ~ Dzuhur 11:42 ~ Ashar 15:07 ~ Maghrib 17:59 ~ Isya' 19:15
# 0112 tag Subuh 04:01 ~ Terbit 05:22 ~ Dzuhur 11:42 ~ Ashar 15:08 ~ Maghrib 17:59 ~ Isya' 19:15
# 0113 tag Subuh 04:01 ~ Terbit 05:22 ~ Dzuhur 11:43 ~ Ashar 15:08 ~ Maghrib 17:59 ~ Isya' 19:15
# 0114 tag Subuh 04:02 ~ Terbit 05:23 ~ Dzuhur 11:43 ~ Ashar 15:08 ~ Maghrib 18:00 ~ Isya' 19:15
# 0115 tag Subuh 04:02 ~ Terbit 05:23 ~ Dzuhur 11:43 ~ Ashar 15:08 ~ Maghrib 18:00 ~ Isya' 19:15
# 0116 tag Subuh 04:03 ~ Terbit 05:23 ~ Dzuhur 11:44 ~ Ashar 15:08 ~ Maghrib 18:00 ~ Isya' 19:15
# 0117 tag Subuh 04:04 ~ Terbit 05:24 ~ Dzuhur 11:44 ~ Ashar 15:08 ~ Maghrib 18:00 ~ Isya' 19:16
# 0118 tag Subuh 04:04 ~ Terbit 05:24 ~ Dzuhur 11:44 ~ Ashar 15:08 ~ Maghrib 18:00 ~ Isya' 19:16
# 0119 tag Subuh 04:05 ~ Terbit 05:25 ~ Dzuhur 11:45 ~ Ashar 15:09 ~ Maghrib 18:01 ~ Isya' 19:16
# 0120 tag Subuh 04:05 ~ Terbit 05:25 ~ Dzuhur 11:45 ~ Ashar 15:09 ~ Maghrib 18:01 ~ Isya' 19:16
# 0121 tag Subuh 04:06 ~ Terbit 05:26 ~ Dzuhur 11:45 ~ Ashar 15:09 ~ Maghrib 18:01 ~ Isya' 19:16
# 0122 tag Subuh 04:06 ~ Terbit 05:26 ~ Dzuhur 11:46 ~ Ashar 15:09 ~ Maghrib 18:01 ~ Isya' 19:16
# 0123 tag Subuh 04:07 ~ Terbit 05:27 ~ Dzuhur 11:46 ~ Ashar 15:09 ~ Maghrib 18:01 ~ Isya' 19:16
# 0124 tag Subuh 04:08 ~ Terbit 05:27 ~ Dzuhur 11:46 ~ Ashar 15:08 ~ Maghrib 18:01 ~ Isya' 19:16
# 0125 tag Subuh 04:08 ~ Terbit 05:27 ~ Dzuhur 11:46 ~ Ashar 15:08 ~ Maghrib 18:01 ~ Isya' 19:16
# 0126 tag Subuh 04:09 ~ Terbit 05:28 ~ Dzuhur 11:47 ~ Ashar 15:08 ~ Maghrib 18:01 ~ Isya' 19:16
# 0127 tag Subuh 04:09 ~ Terbit 05:28 ~ Dzuhur 11:47 ~ Ashar 15:08 ~ Maghrib 18:01 ~ Isya' 19:16
# 0128 tag Subuh 04:10 ~ Terbit 05:29 ~ Dzuhur 11:47 ~ Ashar 15:08 ~ Maghrib 18:02 ~ Isya' 19:16
# 0129 tag Subuh 04:10 ~ Terbit 05:29 ~ Dzuhur 11:47 ~ Ashar 15:08 ~ Maghrib 18:02 ~ Isya' 19:15
# 0130 tag Subuh 04:11 ~ Terbit 05:29 ~ Dzuhur 11:48 ~ Ashar 15:08 ~ Maghrib 18:02 ~ Isya' 19:15
# 0131 tag Subuh 04:11 ~ Terbit 05:30 ~ Dzuhur 11:48 ~ Ashar 15:07 ~ Maghrib 18:02 ~ Isya' 19:15

# 0201 tag Subuh 04:12 ~ Terbit 05:30 ~ Dzuhur 11:48 ~ Ashar 15:07 ~ Maghrib 18:02 ~ Isya' 19:15
# 0202 tag Subuh 04:12 ~ Terbit 05:30 ~ Dzuhur 11:48 ~ Ashar 15:07 ~ Maghrib 18:01 ~ Isya' 19:15
# 0203 tag Subuh 04:13 ~ Terbit 05:31 ~ Dzuhur 11:48 ~ Ashar 15:06 ~ Maghrib 18:01 ~ Isya' 19:15
# 0204 tag Subuh 04:13 ~ Terbit 05:31 ~ Dzuhur 11:48 ~ Ashar 15:06 ~ Maghrib 18:01 ~ Isya' 19:14
# 0205 tag Subuh 04:14 ~ Terbit 05:31 ~ Dzuhur 11:48 ~ Ashar 15:06 ~ Maghrib 18:01 ~ Isya' 19:14
# 0206 tag Subuh 04:14 ~ Terbit 05:32 ~ Dzuhur 11:48 ~ Ashar 15:05 ~ Maghrib 18:01 ~ Isya' 19:14
# 0207 tag Subuh 04:14 ~ Terbit 05:32 ~ Dzuhur 11:48 ~ Ashar 15:05 ~ Maghrib 18:01 ~ Isya' 19:14
# 0208 tag Subuh 04:15 ~ Terbit 05:32 ~ Dzuhur 11:49 ~ Ashar 15:04 ~ Maghrib 18:01 ~ Isya' 19:13
# 0209 tag Subuh 04:15 ~ Terbit 05:32 ~ Dzuhur 11:49 ~ Ashar 15:04 ~ Maghrib 18:01 ~ Isya' 19:13
# 0210 tag Subuh 04:16 ~ Terbit 05:33 ~ Dzuhur 11:49 ~ Ashar 15:03 ~ Maghrib 18:01 ~ Isya' 19:13
# 0211 tag Subuh 04:16 ~ Terbit 05:33 ~ Dzuhur 11:49 ~ Ashar 15:03 ~ Maghrib 18:00 ~ Isya' 19:13
# 0212 tag Subuh 04:16 ~ Terbit 05:33 ~ Dzuhur 11:49 ~ Ashar 15:02 ~ Maghrib 18:00 ~ Isya' 19:12
# 0213 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:49 ~ Ashar 15:02 ~ Maghrib 18:00 ~ Isya' 19:12
# 0214 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:49 ~ Ashar 15:01 ~ Maghrib 18:00 ~ Isya' 19:12
# 0215 tag Subuh 04:17 ~ Terbit 05:34 ~ Dzuhur 11:49 ~ Ashar 15:01 ~ Maghrib 17:59 ~ Isya' 19:11
# 0216 tag Subuh 04:18 ~ Terbit 05:34 ~ Dzuhur 11:49 ~ Ashar 15:00 ~ Maghrib 17:59 ~ Isya' 19:11
# 0217 tag Subuh 04:18 ~ Terbit 05:34 ~ Dzuhur 11:48 ~ Ashar 14:59 ~ Maghrib 17:59 ~ Isya' 19:10
# 0218 tag Subuh 04:18 ~ Terbit 05:34 ~ Dzuhur 11:48 ~ Ashar 14:58 ~ Maghrib 17:59 ~ Isya' 19:10
# 0219 tag Subuh 04:18 ~ Terbit 05:34 ~ Dzuhur 11:48 ~ Ashar 14:58 ~ Maghrib 17:58 ~ Isya' 19:10
# 0220 tag Subuh 04:19 ~ Terbit 05:34 ~ Dzuhur 11:48 ~ Ashar 14:57 ~ Maghrib 17:58 ~ Isya' 19:09
# 0221 tag Subuh 04:19 ~ Terbit 05:34 ~ Dzuhur 11:48 ~ Ashar 14:56 ~ Maghrib 17:58 ~ Isya' 19:09
# 0222 tag Subuh 04:19 ~ Terbit 05:35 ~ Dzuhur 11:48 ~ Ashar 14:55 ~ Maghrib 17:57 ~ Isya' 19:08
# 0223 tag Subuh 04:19 ~ Terbit 05:35 ~ Dzuhur 11:48 ~ Ashar 14:54 ~ Maghrib 17:57 ~ Isya' 19:08
# 0224 tag Subuh 04:20 ~ Terbit 05:35 ~ Dzuhur 11:48 ~ Ashar 14:53 ~ Maghrib 17:57 ~ Isya' 19:07
# 0225 tag Subuh 04:20 ~ Terbit 05:35 ~ Dzuhur 11:48 ~ Ashar 14:53 ~ Maghrib 17:56 ~ Isya' 19:07
# 0226 tag Subuh 04:20 ~ Terbit 05:35 ~ Dzuhur 11:47 ~ Ashar 14:52 ~ Maghrib 17:56 ~ Isya' 19:07
# 0227 tag Subuh 04:20 ~ Terbit 05:35 ~ Dzuhur 11:47 ~ Ashar 14:51 ~ Maghrib 17:56 ~ Isya' 19:06
# 0228 tag Subuh 04:20 ~ Terbit 05:35 ~ Dzuhur 11:47 ~ Ashar 14:50 ~ Maghrib 17:55 ~ Isya' 19:06

# 0301 tag Subuh 04:20 ~ Terbit 05:35 ~ Dzuhur 11:47 ~ Ashar 14:49 ~ Maghrib 17:55 ~ Isya' 19:05
# 0302 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:47 ~ Ashar 14:50 ~ Maghrib 17:54 ~ Isya' 19:05
# 0303 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:47 ~ Ashar 14:50 ~ Maghrib 17:54 ~ Isya' 19:04
# 0304 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:46 ~ Ashar 14:50 ~ Maghrib 17:54 ~ Isya' 19:04
# 0305 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:46 ~ Ashar 14:51 ~ Maghrib 17:53 ~ Isya' 19:03
# 0306 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:46 ~ Ashar 14:51 ~ Maghrib 17:53 ~ Isya' 19:03
# 0307 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:46 ~ Ashar 14:52 ~ Maghrib 17:52 ~ Isya' 19:02
# 0308 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:45 ~ Ashar 14:52 ~ Maghrib 17:52 ~ Isya' 19:02
# 0309 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:45 ~ Ashar 14:52 ~ Maghrib 17:51 ~ Isya' 19:01
# 0310 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:45 ~ Ashar 14:53 ~ Maghrib 17:51 ~ Isya' 19:01
# 0311 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:45 ~ Ashar 14:53 ~ Maghrib 17:50 ~ Isya' 19:00
# 0312 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:44 ~ Ashar 14:53 ~ Maghrib 17:50 ~ Isya' 18:59
# 0313 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:44 ~ Ashar 14:53 ~ Maghrib 17:49 ~ Isya' 18:59
# 0314 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:44 ~ Ashar 14:54 ~ Maghrib 17:49 ~ Isya' 18:58
# 0315 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:44 ~ Ashar 14:54 ~ Maghrib 17:48 ~ Isya' 18:58
# 0316 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:43 ~ Ashar 14:54 ~ Maghrib 17:48 ~ Isya' 18:57
# 0317 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:43 ~ Ashar 14:54 ~ Maghrib 17:47 ~ Isya' 18:57
# 0318 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:43 ~ Ashar 14:54 ~ Maghrib 17:47 ~ Isya' 18:56
# 0319 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:43 ~ Ashar 14:55 ~ Maghrib 17:46 ~ Isya' 18:56
# 0320 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:42 ~ Ashar 14:55 ~ Maghrib 17:46 ~ Isya' 18:55
# 0321 tag Subuh 04:21 ~ Terbit 05:35 ~ Dzuhur 11:42 ~ Ashar 14:55 ~ Maghrib 17:45 ~ Isya' 18:55
# 0322 tag Subuh 04:21 ~ Terbit 05:34 ~ Dzuhur 11:42 ~ Ashar 14:55 ~ Maghrib 17:45 ~ Isya' 18:54
# 0323 tag Subuh 04:21 ~ Terbit 05:34 ~ Dzuhur 11:41 ~ Ashar 14:55 ~ Maghrib 17:44 ~ Isya' 18:54
# 0324 tag Subuh 04:21 ~ Terbit 05:34 ~ Dzuhur 11:41 ~ Ashar 14:55 ~ Maghrib 17:44 ~ Isya' 18:53
# 0325 tag Subuh 04:21 ~ Terbit 05:34 ~ Dzuhur 11:41 ~ Ashar 14:55 ~ Maghrib 17:43 ~ Isya' 18:53
# 0326 tag Subuh 04:21 ~ Terbit 05:34 ~ Dzuhur 11:40 ~ Ashar 14:55 ~ Maghrib 17:43 ~ Isya' 18:52
# 0327 tag Subuh 04:21 ~ Terbit 05:34 ~ Dzuhur 11:40 ~ Ashar 14:55 ~ Maghrib 17:42 ~ Isya' 18:51
# 0328 tag Subuh 04:21 ~ Terbit 05:34 ~ Dzuhur 11:40 ~ Ashar 14:55 ~ Maghrib 17:42 ~ Isya' 18:51
# 0329 tag Subuh 04:20 ~ Terbit 05:34 ~ Dzuhur 11:40 ~ Ashar 14:55 ~ Maghrib 17:41 ~ Isya' 18:50
# 0330 tag Subuh 04:20 ~ Terbit 05:34 ~ Dzuhur 11:39 ~ Ashar 14:55 ~ Maghrib 17:41 ~ Isya' 18:50
# 0331 tag Subuh 04:20 ~ Terbit 05:34 ~ Dzuhur 11:39 ~ Ashar 14:55 ~ Maghrib 17:40 ~ Isya' 18:49

# 0401 tag Subuh 04:20 ~ Terbit 05:34 ~ Dzuhur 11:39 ~ Ashar 14:55 ~ Maghrib 17:40 ~ Isya' 18:49
# 0402 tag Subuh 04:20 ~ Terbit 05:34 ~ Dzuhur 11:38 ~ Ashar 14:55 ~ Maghrib 17:39 ~ Isya' 18:48
# 0403 tag Subuh 04:20 ~ Terbit 05:34 ~ Dzuhur 11:38 ~ Ashar 14:55 ~ Maghrib 17:39 ~ Isya' 18:48
# 0404 tag Subuh 04:20 ~ Terbit 05:33 ~ Dzuhur 11:38 ~ Ashar 14:55 ~ Maghrib 17:38 ~ Isya' 18:48
# 0405 tag Subuh 04:20 ~ Terbit 05:33 ~ Dzuhur 11:37 ~ Ashar 14:55 ~ Maghrib 17:37 ~ Isya' 18:47
# 0406 tag Subuh 04:20 ~ Terbit 05:33 ~ Dzuhur 11:37 ~ Ashar 14:55 ~ Maghrib 17:37 ~ Isya' 18:47
# 0407 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:37 ~ Ashar 14:55 ~ Maghrib 17:36 ~ Isya' 18:46
# 0408 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:37 ~ Ashar 14:55 ~ Maghrib 17:36 ~ Isya' 18:46
# 0409 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:36 ~ Ashar 14:55 ~ Maghrib 17:36 ~ Isya' 18:45
# 0410 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:36 ~ Ashar 14:55 ~ Maghrib 17:35 ~ Isya' 18:45
# 0411 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:36 ~ Ashar 14:55 ~ Maghrib 17:35 ~ Isya' 18:44
# 0412 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:36 ~ Ashar 14:55 ~ Maghrib 17:34 ~ Isya' 18:44
# 0413 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:35 ~ Ashar 14:55 ~ Maghrib 17:34 ~ Isya' 18:44
# 0414 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:35 ~ Ashar 14:55 ~ Maghrib 17:33 ~ Isya' 18:43
# 0415 tag Subuh 04:19 ~ Terbit 05:33 ~ Dzuhur 11:35 ~ Ashar 14:55 ~ Maghrib 17:33 ~ Isya' 18:43
# 0416 tag Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:35 ~ Ashar 14:54 ~ Maghrib 17:32 ~ Isya' 18:42
# 0417 tag Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:34 ~ Ashar 14:54 ~ Maghrib 17:32 ~ Isya' 18:42
# 0418 tag Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:34 ~ Ashar 14:54 ~ Maghrib 17:31 ~ Isya' 18:42
# 0419 tag Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:34 ~ Ashar 14:54 ~ Maghrib 17:31 ~ Isya' 18:41
# 0420 tag Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:34 ~ Ashar 14:54 ~ Maghrib 17:31 ~ Isya' 18:41
# 0421 tag Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:30 ~ Isya' 18:41
# 0422 tag Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:30 ~ Isya' 18:40
# 0423 tag Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:29 ~ Isya' 18:40
# 0424 tag Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:33 ~ Ashar 14:54 ~ Maghrib 17:29 ~ Isya' 18:40
# 0425 tag Subuh 04:18 ~ Terbit 05:33 ~ Dzuhur 11:33 ~ Ashar 14:53 ~ Maghrib 17:29 ~ Isya' 18:39
# 0426 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:28 ~ Isya' 18:39
# 0427 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:28 ~ Isya' 18:39
# 0428 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:27 ~ Isya' 18:39
# 0429 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:27 ~ Isya' 18:38
# 0430 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:27 ~ Isya' 18:38

# 0501 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:27 ~ Isya' 18:38
# 0502 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:26 ~ Isya' 18:38
# 0503 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:31 ~ Ashar 14:53 ~ Maghrib 17:26 ~ Isya' 18:38
# 0504 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:31 ~ Ashar 14:53 ~ Maghrib 17:26 ~ Isya' 18:37
# 0505 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:31 ~ Ashar 14:53 ~ Maghrib 17:25 ~ Isya' 18:37
# 0506 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:25 ~ Isya' 18:37
# 0507 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:25 ~ Isya' 18:37
# 0508 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:25 ~ Isya' 18:37
# 0509 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:24 ~ Isya' 18:37
# 0510 tag Subuh 04:17 ~ Terbit 05:33 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:24 ~ Isya' 18:37
# 0511 tag Subuh 04:17 ~ Terbit 05:34 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:24 ~ Isya' 18:36
# 0512 tag Subuh 04:17 ~ Terbit 05:34 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:24 ~ Isya' 18:36
# 0513 tag Subuh 04:17 ~ Terbit 05:34 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:24 ~ Isya' 18:36
# 0514 tag Subuh 04:17 ~ Terbit 05:34 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0515 tag Subuh 04:17 ~ Terbit 05:34 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0516 tag Subuh 04:17 ~ Terbit 05:34 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0517 tag Subuh 04:17 ~ Terbit 05:34 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0518 tag Subuh 04:17 ~ Terbit 05:35 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0519 tag Subuh 04:17 ~ Terbit 05:35 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0520 tag Subuh 04:17 ~ Terbit 05:35 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0521 tag Subuh 04:17 ~ Terbit 05:35 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0522 tag Subuh 04:17 ~ Terbit 05:35 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0523 tag Subuh 04:17 ~ Terbit 05:36 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0524 tag Subuh 04:17 ~ Terbit 05:36 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0525 tag Subuh 04:18 ~ Terbit 05:36 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:36
# 0526 tag Subuh 04:18 ~ Terbit 05:36 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:22 ~ Isya' 18:36
# 0527 tag Subuh 04:18 ~ Terbit 05:36 ~ Dzuhur 11:31 ~ Ashar 14:52 ~ Maghrib 17:22 ~ Isya' 18:36
# 0528 tag Subuh 04:18 ~ Terbit 05:37 ~ Dzuhur 11:32 ~ Ashar 14:52 ~ Maghrib 17:23 ~ Isya' 18:37
# 0529 tag Subuh 04:18 ~ Terbit 05:37 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:23 ~ Isya' 18:37
# 0530 tag Subuh 04:18 ~ Terbit 05:37 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:23 ~ Isya' 18:37
# 0531 tag Subuh 04:18 ~ Terbit 05:37 ~ Dzuhur 11:32 ~ Ashar 14:53 ~ Maghrib 17:23 ~ Isya' 18:37


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


