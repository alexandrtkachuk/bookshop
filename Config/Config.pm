package Config::Config;

use constant DBUSER => 'user7';
use constant DBPASS => 'tuser7';
use constant DBHOST => 'localhost';
use constant DBNAME => 'user7';



my $tdir;
my $baseUrl= 'http://'.$ENV{'SERVER_NAME'}.$ENV{'SCRIPT_NAME'};
$baseUrl=~s/index.cgi//;
sub getDir
{
    return $tdit;
}

sub setDir
{
     $tdit=$_[1];
}

sub getBaseUrl
{
    return $baseUrl;
}

#sub setBaseUrl
#{
#    $baseUrl=$_[1];
#}


1;

