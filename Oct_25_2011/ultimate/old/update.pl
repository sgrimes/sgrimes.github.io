# usage: perl update.pl

#======================================================

if (@ARGV) {
  $in = 'ultimate.txt';
  open (IN,"$in");
  $call = $ARGV[0];
  &$call; }
else {
  system("perl","update.pl","all",">","all.lst");
  system("perl","update.pl","men",">","men.lst");
  system("perl","update.pl","women",">","women.lst");
}


#======================================================


sub all { open (ALL, ">all.lst");
  while (<IN>) {
      last if /MUDSHARKS/}
  while (<IN>) {
      if (/<([A-Za-z0-9._-]*?@[A-Za-z0-9._-]*?)>[^*]/g) { print ALL "$1\n"}} close
ALL;
}

sub men { open (MEN, ">men.lst");
while (<IN>) {last if /MUDSHARKS/}
while (<IN>) { last if /PEACE FROGS/; if
(/<([A-Za-z0-9._-]*?@[A-Za-z0-9._-]*?)>[^*]/g) {print MEN "$1\n"}} close MEN;}


sub women { open (WOMEN, ">women.lst");
   while (<IN>) {
      last if /PEACE FROGS/} 
   while (<IN>) { 
      if (/<([A-Za-z0-9._-]*?@[A-Za-z0-9._-]*?)>[^*]/g) {print WOMEN "$1\n" }
}close WOMEN;}



