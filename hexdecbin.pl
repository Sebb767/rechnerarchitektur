#!/usr/bin/perl
use strict;
use utf8;
use warnings qw(all);

die("Not enough values.\nUsage: /hexdecbin.pl [mode] number") if ($#ARGV < 0);

my $mode = "hex";
$mode = shift unless $#ARGV < 2;

sub binfix {
	my $bin = shift;

	return ("0"x (8-((length $bin) %8))) . $bin;
}

sub bin2dec {
	my $full = shift;

	die("$full is not a valid binary number!") unless $full =~ m/(0|1)+/;

	my @bin = split //, $full;
	my $count = 0;
	my $result = 0;
	my $sign = pop @bin;

	while (shift @bin)
	{
		$result += 1 << $count if($_ =~ m/1/);
		$count++;
	}

	return -(1<<$count) + $result if $sign =~ m/1/;
	return $result;
}

sub dec2hex {
	return 0;
}

foreach (@ARGV)  {
	print bin2dec($_);
}