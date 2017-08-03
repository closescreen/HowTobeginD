#!/usr/bin/perl

my $asd = 4;

print even($asd);

sub even(){
 $_[0] % 2 ==0
}