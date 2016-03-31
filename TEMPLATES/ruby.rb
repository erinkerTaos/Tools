#!/usr/bin/ruby
#
# <QUICK DESCRIPTION>
#

#-------------------------------#
# Modules                       #
#-------------------------------#
require 'getoptlong'

#-------------------------------#
# Functions                     #
#-------------------------------#
def print_help_and_exit()
  puts ""
  puts "NAME"
  puts "        <SCRIPT> - <QUICK DESCRIPTION>"
  puts ""
  puts "SYNOPSIS"
  puts "        <SCRIPT> [OPTION]"
  puts ""
  puts "DESCRIPTION"
  puts "        <DESCRIBE IN DETAIL>"
  puts ""
  puts "        -d, --debug"
  puts "            print debugging information."
  puts ""
  puts "        -h, --help"
  puts "            print this page."
  puts ""
  puts "        -v, --verbose"
  puts "            verbose output."
  puts ""

  exit 0
end

#-------------------------------#
# Varaibles                     #
#-------------------------------#
verboseLevel = 0

#-------------------------------#
# Command-Line Processing       #
#-------------------------------#
opts = GetoptLong.new(
  [ '--debug', '-d', GetoptLong::NO_ARGUMENT ],
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--verbose', '-v', GetoptLong::NO_ARGUMENT ]
)

opts.each do |opt, arg|
  case opt
    when '--debug'
      verboseLevel = 10
    when '--help'
      print_help_and_exit()
    when '--verbose'
      verboseLevel = 1
  end
end

#-------------------------------#
# MAIN                          #
#-------------------------------#
puts "Do what this script does."
