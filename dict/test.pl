$word = shift @ARGV || die "Incorrect number of parameters\n";

$file = "output.txt";
open (DICT, "<$file") || print "Could not open dictionary database.\n";

$i=0;
while (<DICT>) {
        if ($i==0) {@names = split ("\t");}
        else {@fields = split ("\t");
        for ($j=1;$j<=$#names;$j++) {
                $dict{$fields[0]}{$names[$j]} = $fields[$j];
        }}
$i=1;}

print "One word is $dict{'ablak'}{'PRON'}.\n";
 
print "$word is pronounced $dict{$word}{'PRON'}.\n";

