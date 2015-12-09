# usage: perl parse.pl


$in = 'ultimate.txt';
open (IN,"$in");
&slackers;
close IN;
open (IN,"$in");
&slackeremail;
close IN;
open (IN,"$in");
&good;
close IN;
open (IN,"$in");
&bad;
close IN;


sub slackers {open (ALLSLACKERS, ">allslackers.txt");
  while (<IN>) {
      last if /MUDSHARKS/}
  while (<IN>) {last if /PEACE FROGS/; 
      if (/(.*?)<.*[*]/) {}
      elsif (/(.*?)<.*[#]/) {}
      elsif (/(.*?)</) {print ALLSLACKERS "$1\n"}}
  close ALLSLACKERS;
}

sub slackeremail {open (S, ">slackeremail.txt");
  while (<IN>) {
      last if /MUDSHARKS/}
  while (<IN>) {last if /PEACE FROGS/; 
      if (/(.*?)<.*[*]/) {}
      elsif (/(.*?)<.*[#]/) {}
      elsif (/<(.*?)>/) {print S "$1, "}}
  close ALLSLACKERS;
}
  
sub good {open (ALLGOOD, ">allgood.txt");
  while (<IN>) {
      last if /MUDSHARKS/}
  while (<IN>) {
      last if /PEACE FROGS/; 
      if (/(.*?)<.*[*]/) {}
      elsif (/(.*?)<.*[#]/) {print ALLGOOD "$1\n"}}
close ALLGOOD;
}

sub bad { 
	  open (ALLBAD, ">allbad.txt");
  while (<IN>) {
      last if /MUDSHARKS/}
  while (<IN>) {
      last if /PEACE FROGS/;
      if (/(.*?)<.*[*]/) { print ALLBAD "$1\n"}
      if (/(\w+ \w+[^<>]*)$/) { print ALLBAD "$1"}}
close ALLBAD;
}
