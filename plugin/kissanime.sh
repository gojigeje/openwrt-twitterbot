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
        status="[kissanime] Episode terbaru Anime Bokura wa Minna Kawaisou udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Detective Conan"* ]]; then
        status="[kissanime] Episode terbaru Anime Detective Conan udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Detective Conan Movie 18"* ]]; then
        status="[kissanime] Episode terbaru Anime Detective Conan Movie 18 udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Gokukoku no Brynhildr"* ]]; then
        status="[kissanime] Episode terbaru Anime Gokukoku no Brynhildr udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Hunter x Hunter"* ]]; then
        status="[kissanime] Episode terbaru Anime Hunter x Hunter udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Isshuukan Friends"* ]]; then
        status="[kissanime] Episode terbaru Anime Isshuukan Friends udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Kindaichi Case Files R"* ]]; then
        status="[kissanime] Episode terbaru Anime Kindaichi Case Files R udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Knights of Sidonia"* ]]; then
        status="[kissanime] Episode terbaru Anime Knights of Sidonia udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Lupin III vs. Detective Conan"* ]]; then
        status="[kissanime] Episode terbaru Anime Lupin III vs. Detective Conan udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Mekakucity Actors"* ]]; then
        status="[kissanime] Episode terbaru Anime Mekakucity Actors udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Mushishi Zoku Shou"* ]]; then
        status="[kissanime] Episode terbaru Anime Mushishi Zoku Shou udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Yowamushi Pedal"* ]]; then
        status="[kissanime] Episode terbaru Anime Yowamushi Pedal udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Barakamon"* ]]; then
        status="[kissanime] Episode terbaru Anime Barakamon udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje @ulinzulfa"
      fi
      if [[ "$line" == *"Glasslip"* ]]; then
        status="[kissanime] Episode terbaru Anime Glasslip udah rilis..! Liat + Download di kissanime :D ~ cc. @gojigeje @ulinzulfa"
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
