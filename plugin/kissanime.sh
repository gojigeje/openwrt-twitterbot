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

      if [[ "$line" == *"Detective Conan"* ]]; then
        status="[kissanime] Eps. baru Anime Detective Conan dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fDetective-Conan ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Detective Conan Movie 18"* ]]; then
        status="[kissanime] Eps. baru Anime Detective Conan Movie 18 dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fDetective-Conan-Movie-18-The-Sniper-from-Another-Dimension ~ cc. @gojigeje @putrinawa"
      fi
      if [[ "$line" == *"Hunter x Hunter"* ]]; then
        status="[kissanime] Eps. baru Anime Hunter x Hunter Last Mission dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fHunter-x-Hunter-The-Last-Mission ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Kindaichi Case Files R"* ]]; then
        status="[kissanime] Eps. baru Anime Kindaichi Case Files R dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fKindaichi-Shounen-no-Jikenbo-Returns ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Barakamon"* ]]; then
        status="[kissanime] Eps. baru Anime Barakamon dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fBarakamon ~ cc. @gojigeje @ulinzulfa"
      fi
      if [[ "$line" == *"Glasslip"* ]]; then
        status="[kissanime] Eps. baru Anime Glasslip dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fGlasslip ~ cc. @gojigeje @ulinzulfa"
      fi
      if [[ "$line" == *"One Piece"* ]]; then
        status="[kissanime] Eps. baru Anime One Piece dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fOne-Piece ~ cc. @EKOSUHARTONOcom @yunushadi"
      fi
      if [[ "$line" == *"Sword Art Online"* ]]; then
        status="[kissanime] Eps. baru Anime Sword Art Online II dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fSword-Art-Online-II ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Eternal Summer"* ]]; then
        status="[kissanime] Eps. baru Anime Free!: Eternal Summer dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fFree-Eternal-Summer ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Rail Wars"* ]]; then
        status="[kissanime] Eps. baru Anime Rail Wars! dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fRail-Wars ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Tokyo Ghoul"* ]]; then
        status="[kissanime] Eps. baru Anime Tokyo Ghoul dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fTokyo-Ghoul ~ cc. @gojigeje"
      fi
      if [[ "$line" == *"Zankyou no Terror"* ]]; then
        status="[kissanime] Eps. baru Anime Zankyou no Terror dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fZankyou-no-Terror ~ cc. @gojigeje"
      fi

      # completed
      # 
      # if [[ "$line" == *"Bokura wa Minna Kawaisou"* ]]; then
      #   status="[kissanime] Eps. baru Anime Bokura wa Minna Kawaisou dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fBokura-wa-Minna-Kawaisou ~ cc. @gojigeje"
      # fi
      # if [[ "$line" == *"Gokukoku no Brynhildr"* ]]; then
      #   status="[kissanime] Eps. baru Anime Gokukoku no Brynhildr dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fGokukoku-no-Brynhildr ~ cc. @gojigeje"
      # fi
      # if [[ "$line" == *"Isshuukan Friends"* ]]; then
      #   status="[kissanime] Eps. baru Anime Isshuukan Friends dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fIsshuukan-Friends ~ cc. @gojigeje @ulinzulfa"
      # fi
      # if [[ "$line" == *"Knights of Sidonia"* ]]; then
      #   status="[kissanime] Eps. baru Anime Knights of Sidonia dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fSidonia-no-Kishi ~ cc. @gojigeje"
      # fi
      # if [[ "$line" == *"Lupin III vs. Detective Conan"* ]]; then
      #   status="[kissanime] Eps. baru Anime Lupin III vs. Detective Conan dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fLupin-III-vs-Detective-Conan-The-Movie ~ cc. @gojigeje @putrinawa"
      # fi
      # if [[ "$line" == *"Mekakucity Actors"* ]]; then
      #   status="[kissanime] Eps. baru Anime Mekakucity Actors dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fMekakucity-Actors ~ cc. @gojigeje"
      # fi
      # if [[ "$line" == *"Mushishi Zoku Shou"* ]]; then
      #   status="[kissanime] Eps. baru Anime Mushishi Zoku Shou dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fMushishi-Zoku-Shou ~ cc. @gojigeje"
      # fi
      # if [[ "$line" == *"Yowamushi Pedal"* ]]; then
      #   status="[kissanime] Eps. baru Anime Yowamushi Pedal dah rilis..! ~ Download di http://kissanime.com/G/5726?l=http%3a%2f%2fkissanime.com%2fAnime%2fYowamushi-Pedal ~ cc. @gojigeje"
      # fi

      if [[ ! -z "$status" ]]; then
        getJam
        echo " -[ttytter] : $status"
        ttytter -status="$status"
      fi

      let num++;
    done

  else
    echo "[kissanime] sepertinya nggak ada eps. baru di email"
  fi
  

  echo "- done -"
  exit 1
}
