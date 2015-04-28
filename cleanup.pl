#!/usr/bin/env perl

use strict;
use warnings;
use File::Basename;
use Cwd;
use Cwd 'abs_path';
use File::Copy;

my $starting_dir = getcwd();

my $dir = $ARGV[0];
chdir $dir;

opendir(DIR, $dir) || die "Can't open directory: $!\n";
while (readdir(DIR)) {
  next if ($_ =~ m/^\./);
  my $full_name = abs_path($_);
  my ($file, $dir, $ext) = fileparse($full_name, qr/((\.[^.\s]+)+)$/); # regex needs improvement

  if (length $ext > 0) {
    my $new_dir = substr $ext, 1;
    unless (-d $new_dir) {
      print "Creating new directory $new_dir\n";
      mkdir $new_dir;
    }
    if ((substr $ext, 1) eq $new_dir) {
      move($full_name, abs_path($new_dir));
    }
  }
}
closedir(DIR);

chdir $starting_dir;