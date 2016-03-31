#!/bin/bash
# NOTE: This file is Puppet-managed. Any manual edits will be removed next run.
#
# <QUICK DESCRIPTION>
#

#-------------------------------#
# Functions                     #
#-------------------------------#
load_boku_cfg () {
  BOKU_CFG_FILE=$HOME/boku.cfg
  if [ -r $BOKU_CFG_FILE ]; then
    source $BOKU_CFG_FILE
  else
    echo "Boku configuration file ($BOKU_CFG_FILE) not present."
    exit 1
  fi
}
print_help_and_exit () {
  echo ""
  echo "NAME"
  echo "        <SCRIPT> - <QUICK DESCRIPTION>"
  echo ""
  echo "SYNOPSIS"
  echo "        <SCRIPT> [OPTION]"
  echo ""
  echo "DESCRIPTION"
  echo "        <DESCRIBE IN DETAIL>"
  echo ""
  echo "        -d"
  echo "            print debugging information."
  echo ""
  echo "        -h"
  echo "            print this page."
  echo ""
  echo "        -t"
  echo "            dry-run through process, but do nothing."
  echo ""
  echo "        -v"
  echo "            verbose output."
  echo ""

  exit 0
}

#-------------------------------#
# Varaibles                     #
#-------------------------------#
load_boku_cfg

#-------------------------------#
# Command-Line Processing       #
#-------------------------------#
while getopts "dhtv" arg; do
  case $arg in
    d)
      DEBUG=1
      VERBOSE=1
      ;;
    h)
      print_help_and_exit
      ;;
    t)
      TEST_RUN=1
      VERBOSE=1
      ;;
    v)
      VERBOSE=1
      ;;
  esac
done
INVALID_RUN=0
#
# --- Put your input verification code here ---
#
if (( $INVALID_RUN )); then
  exit 1;
fi

#-------------------------------#
# MAIN                          #
#-------------------------------#
