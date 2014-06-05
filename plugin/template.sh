#!/bin/bash

# uncomment to include this plugin in main script tweet.sh, randomly executed
# aksi_array+=("twit_template")

# main method
# format: {aksi array name}_main --> twit_template_main
twit_template_main() {

  # functions
  someFunction() {
    somevalue="value"
  }

  # you can call ttyter and choose to update status from here,
  # but remember to exit after setting status to prevent multiple ttytter call
  ttyter -status="{tweet status}"
  exit 1

  # or you can 
  tweet_status="{tweet status here}"

}
