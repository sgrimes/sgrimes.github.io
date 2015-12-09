#!/usr/local/bin/perl

# First, get the CGI variables into a list of strings
%cgivars= &getcgivars ;
print "Content-type: text/html\n\n" ;

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


print <<EOF ;
<html><head><title>Hungarian Pronunciation 
Dictionary</title></head><body><h2>Your Query</h1>Your CGI input variables 
were:<ul>
EOF

foreach (keys %cgivars) {
    print "<li>[$_] = [$cgivars{$_}]\n" ;
}

print <<EOF ;
</ul></body></html>
EOF

print "<h2>Search Results</h2>";
print "<table border=1><tr><td>WORD</td><td>PRON</td><td>FREQ</td></tr><tr><td>";
print "$cgivars{'word'}";
print "</td><td>";
print "$dict{$cgivars{'word'}}{'PRON'}";
print "</td><td>";
print "$dict{$cgivars{'word'}}{'FREQ'}";
print "</td></tr></table>";




exit ;


#----------------- start of &getcgivars() module ----------------------

# Read all CGI vars into an associative array.
# If multiple input fields have the same name, they are concatenated into
#   one array element and delimited with the \0 character (which fails if
#   the input has any \0 characters, very unlikely but conceivably possible).
# Currently only supports Content-Type of application/x-www-form-urlencoded.
sub getcgivars {
    local($in, %in) ;
    local($name, $value) ;


    # First, read entire string of CGI vars into $in
    if ( ($ENV{'REQUEST_METHOD'} eq 'GET') ||
         ($ENV{'REQUEST_METHOD'} eq 'HEAD') ) {
        $in= $ENV{'QUERY_STRING'} ;

    } elsif ($ENV{'REQUEST_METHOD'} eq 'POST') {
        if ($ENV{'CONTENT_TYPE'}=~ m#^application/x-www-form-urlencoded$#i) {
            length($ENV{'CONTENT_LENGTH'})
                || &HTMLdie("No Content-Length sent with the POST request.") ;
            read(STDIN, $in, $ENV{'CONTENT_LENGTH'}) ;

        } else { 
            &HTMLdie("Unsupported Content-Type: $ENV{'CONTENT_TYPE'}") ;
        }

    } else {
        &HTMLdie("Script was called with unsupported REQUEST_METHOD.") ;
    }
    
    # Resolve and unencode name/value pairs into %in
    foreach (split(/[&;]/, $in)) {
        s/\+/ /g ;
        ($name, $value)= split('=', $_, 2) ;
        $name=~ s/%([0-9A-Fa-f]{2})/chr(hex($1))/ge ;
        $value=~ s/%([0-9A-Fa-f]{2})/chr(hex($1))/ge ;
        $in{$name}.= "\0" if defined($in{$name}) ;  # concatenate multiple vars
        $in{$name}.= $value ;
    }

    return %in ;

}


# Die, outputting HTML error page
# If no $title, use a default title
sub HTMLdie {
    local($msg,$title)= @_ ;
    $title= "CGI Error" if $title eq '' ;
    print <<EOF ;
Content-type: text/html

<html>
<head>
<title>$title</title>
</head>
<body>
<h1>$title</h1>
<h3>$msg</h3>
</body>
</html>
EOF

    exit ;
}

