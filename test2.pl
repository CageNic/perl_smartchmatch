#!/usr/bin/perl
use strict;
use warnings;

# dont mix strings and numbers
# smartmatch unreliable and experimertal
# use either or
# eq string == number

my @search = qw/2112 211/;
my @codes;
my @pats;
my $start_date = 2017;

my $file = "test.txt";
open (my $fh, '<', $file) or die $!;
my $header = <$fh>;
chomp $header;
while (my $lines = <$fh>) {
  chomp $lines;
  my @array = split (/,/,$lines);
  my ($year, $month, $day) = split (/-/,$array[3]);
  if ($array[1] ~~ @search && $year >= 2017) {
    push (@codes, $array[1]);
    push (@pats, $array[0]);
  }
}
close $fh;

# deduplicate the code and pat arrays
# for codes that means all the matched data from @search
# with this subroutine

sub uniq_counter {
    my  @sub_array = (@_);
    my $counts = {};
    $counts->{$_}++ for @sub_array;
    return scalar keys %$counts;
}

sub counter_per_item {
    my  @sub_array = (@_);
    my %counts;
    $counts{$_}++ for @sub_array;
    foreach my $key (keys %counts) {
      print "code: $key - frequency of occurence: $counts{$key}\n";
    }
    return;    
}

# report

print "Total codes from code list found in data: ", scalar @codes , "\n";
print "Unique codes from code list found in data: ", uniq_counter(@codes) , "\n";
print "Total patient search count: ", scalar @pats, "\n";
print "Unique patient count: ", uniq_counter(@pats) , "\n";
print "\n";
print "Code counts per item" , "\n";
print "Per item total to match total codes found\n";
counter_per_item(@codes);
print "\n";

#### without smartmatch ###
#
# list::util module
# use List::Util 'any';
