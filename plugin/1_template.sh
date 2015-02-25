#!/bin/bash
#
# super basic and unclean sctructure of the plugin

# uncomment to enable/include this plugin in main script tweet.sh so it will randomly executed
#   along with other enabled plugin
#
# aksi_array+=("twit_template") # <--------
#                                         |
# main function                           |
# naming MUST follow this format: {aksi array name}_main --> twit_template_main
#
twit_template_main() {

  # your code goes here
  # ...
  # ...


  # you can call "twit.py" and choose to update status from here,
  # but remember to exit after setting status to prevent multiple tweet posts
  twit -s "{tweet status}"
  exit 1


  # or you can just set the status text as "tweet_status" variable.
  # normally, a plugin only generate some status text and the main script will do the 
  # tweeting (tweet.sh), remember to always limit this text to <= 140 character
  tweet_status="{tweet status here}"

}
