$file = 'alumni.html';
open(INFO, $file);              # Open the file
@lines = <INFO>;                # Read it into an array
close(INFO);  

foreach (@lines) {
s/>//g;
s/<//g;
}

$fileout = 'outfile.html';
open(OUTFO, ">$fileout");   # Open for output
print OUTFO @lines;
close(OUTFO);

