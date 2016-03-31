#!/usr/bin/perl -w
# NOTE: This file is Puppet-managed. Any manual edits will be removed next run.
#
# <QUICK DESCRIPTION>
#

#-------------------------------#
# Modules                       #
#-------------------------------#
use File::Basename;
use Getopt::Long;
use POSIX;

#-------------------------------#
# Constants                     #
#-------------------------------#

#-------------------------------#
# Global Variables              #
#-------------------------------#
# Command Line (Defaults)
our ( %CLOption ) = (
  "option1"             => "ALL",
  "option2"             => "ALL",
  "option3"             => \$variable_set_via_getops,
);

# Human Defined
my $cmdUsage = basename($0)." [-dhv] -f <file>";
my $mapping_extention = ".map";

# Derived

# Boolean/Placeholders

# Command-Line Trigger Variables

#-------------------------------#
# Pre-Main Prep                 #
#-------------------------------#
verify_CommandLine();

#-------------------------------#
# Main                          #
#-------------------------------#
if ( $verboseLevel >= 2 ) { print_Debug_CommandLineHash(); }

if ( $variable_set_via_getops ) {
  print "variable_set_via_getops = ".$variable_set_via_getops."\n";
}

#-------------------------------#
# Functions                     #
#-------------------------------#
sub dash {
  my ( $count ) = @_;

  my ( $dashes ) = "-";
  for ( $n = 1; $n<$count; $n++ ) {
    $dashes .= "-";
  }

  return ( $dashes );
}
sub print_Debug_CommandLineHash {
  print "DEBUG:\nDEBUG: Command Line Hash Contents\nDEBUG:\n";
  printf ( "DEBUG: %-15s %-30s\n", "Key", "Data" );
  printf ( "DEBUG: %-15s %-30s\n", dash(15), dash(30) );
  foreach $key ( sort ( keys ( %CLOption ) ) ) {
    printf ( "DEBUG: %-15s %-30s\n", $key, $CLOption{$key} );
  }
  print "DEBUG:\n";
}
sub print_HelpAndExit {
  print "\n";
  print "NAME\n";
  print "\t".basename($0)." - <SHORT DESCRIPTION>\n";
  print "\n";
  print "SYNOPSYS\n"; 
  print "\t".$cmdUsage."\n";
  print "\n";
  print "DESCRIPTION\n"; 
  print "\t<LONG DESCRIPTION>\n";
  print "\n";
  print "   GENERAL OPTIONS\n";
  print "\n";
  print "\t-d, --debug\n";
  print "\t\tTurns on Debugging output.\n";
  print "\n";
  print "\t-h, --help\n";
  print "\t\tPrints this message and exits.\n";
  print "\n";
  print "\t-v, --verbose\n";
  print "\t\tTurns on Verbose output.\n";
  print "\n";
  print "   REQUIRED OPTIONS\n";
  print "\n";
  print "\t-f, --file FILE\n";
  print "\t\tFile to process. [REQUIRED]\n";
  print "\n";

  exit 0;
}
sub link_cmdOption {
  my ( $opt1, $opt2 ) = @_;
  if ( ! defined ( $CLOption{$opt1} ) && defined ( $CLOption{$opt2} ) ) {
    $CLOption{$opt1} = $CLOption{$opt2};
  }
}
sub timeStamp {
  return ( POSIX::strftime("%m/%d/%Y %H:%M:%S", localtime) );
};
sub verify_CommandLine {
  Getopt::Long::Configure ("bundling");
  GetOptions( \%CLOption,
    "debug", "d",
    "file=s", "f=s",
    "help", "h",
    "map:s", "m:s",
    "verbose+", "v+",
  );

  # Link Command-Line Options
  link_cmdOption ( "debug", "d" );
  link_cmdOption ( "file", "f" );
  link_cmdOption ( "help", "h" );
  link_cmdOption ( "map", "m" );
  link_cmdOption ( "verbose", "v" );

  # Set Verbosity
  our ( $verboseLevel ) = 0;
  if ( defined ( $CLOption{debug} ) ) {
    $verboseLevel = 10;
  }
  elsif ( defined ( $CLOption{verbose} ) ) {
    $verboseLevel = $CLOption{verbose};
  }
  if ( defined ( $CLOption{help} ) ) {
  if ( ! $verboseLevel ) {
      $verboseLevel = 1;
    }
    print_HelpAndExit();
  }

  # Option Verifications
  my ( $validRun ) = 1;
  if ( ! $validRun ) {
    print "Usage: ".$cmdUsage."\n";
    exit 1;
  }

  # Optional Opts
  if ( ( ! defined ( $CLOption{map} ) ) && ( defined ( $CLOption{file} ) ) ) {
    $CLOption{map} = $CLOption{file} . $mapping_extention;
  }
}
