#!/bin/bash

# aksi_array+=("twit_kissanime")

# main method
twit_kissanime_main() {

  getJam
  # ambil feed gmail
  echo "[kissanime] [$getjam] ambil feed gmail"
  curl -s -u *USER*:*PASSWORD* --silent "https://mail.google.com/mail/feed/atom" > "temp/gmail_feed"
  sed 's/<[a-zA-Z]/\n&/g' "temp/gmail_feed" | grep "<summary>" | grep -i "hello gojigeje new episode of anime" | sed 's/<[^>]\+>/ /g' | perl -MHTML::Entities -le 'while(<>) {print decode_entities($_);}' | sed '/^[ \t]*$/d;s/^ * //g' | uniq > "temp/gmail_kissanime"

  # echo "- filter !gojibox "
  baris=$(cat "temp/gmail_kissanime" | wc -l)

  if [[ "$baris" -gt 0 ]]; then
    max=$(( $baris + 1 ))
    num=1
    while [[ $num -lt $max ]]; do
      line="`sed -n "$num"p "temp/gmail_kissanime"`"

      if [[ "$line" == *"Bokura wa Minna Kawaisou"* ]]; then
        status="[kissanime] Episode baru Anime Bokura wa Minna Kawaisou dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fBokura-wa-Minna-Kawaisou ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Detective Conan"* ]]; then
        status="[kissanime] Episode baru Anime Detective Conan dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fDetective-Conan ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Detective Conan Movie 18"* ]]; then
        status="[kissanime] Episode baru Anime Detective Conan Movie 18 dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fDetective-Conan-Movie-18-The-Sniper-from-Another-Dimension ~ cc. @gojigeje @putrinawa"
      fi
      if [[ "$line" == *"Gokukoku no Brynhildr"* ]]; then
        status="[kissanime] Episode baru Anime Gokukoku no Brynhildr dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fGokukoku-no-Brynhildr ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Hunter x Hunter"* ]]; then
        status="[kissanime] Episode baru Anime Hunter x Hunter Last Mission dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fHunter-x-Hunter-The-Last-Mission ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Isshuukan Friends"* ]]; then
        status="[kissanime] Episode baru Anime Isshuukan Friends dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fIsshuukan-Friends ~ cc. @gojigeje @ulinzulfa"
      fi
      if [[ "$line" == *"Kindaichi Case Files R"* ]]; then
        status="[kissanime] Episode baru Anime Kindaichi Case Files R dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fKindaichi-Shounen-no-Jikenbo-Returns ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Knights of Sidonia"* ]]; then
        status="[kissanime] Episode baru Anime Knights of Sidonia dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fSidonia-no-Kishi ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Lupin III vs. Detective Conan"* ]]; then
        status="[kissanime] Episode baru Anime Lupin III vs. Detective Conan dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fLupin-III-vs-Detective-Conan-The-Movie ~ cc. @gojigeje @putrinawa"
      fi
      if [[ "$line" == *"Mekakucity Actors"* ]]; then
        status="[kissanime] Episode baru Anime Mekakucity Actors dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fMekakucity-Actors ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Mushishi Zoku Shou"* ]]; then
        status="[kissanime] Episode baru Anime Mushishi Zoku Shou dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fMushishi-Zoku-Shou ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Yowamushi Pedal"* ]]; then
        status="[kissanime] Episode baru Anime Yowamushi Pedal dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fYowamushi-Pedal ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Barakamon"* ]]; then
        status="[kissanime] Episode baru Anime Barakamon dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fBarakamon ~ cc. @gojigeje @ulinzulfa"
      fi
      if [[ "$line" == *"Glasslip"* ]]; then
        status="[kissanime] Episode baru Anime Glasslip dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fGlasslip ~ cc. @gojigeje @ulinzulfa"
      fi
      if [[ "$line" == *"One Piece"* ]]; then
        status="[kissanime] Episode baru Anime One Piece dh rilis..! ~ Liat + Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fOne-Piece ~ cc. @EKOSUHARTONOcom @yunushadi"
      fi

      # safety :)
      if [[ ! -z "$status" ]]; then
        getJam
        echo " -[ttytter] : $status"
        ttytter -status="$status"
      fi

      let num++;
    done

  else
    echo "[kissanime] sepertinya nggak ada episode baru di email"
  fi
  

  echo "- done -"
  exit 1
}
