package Models::Validators::Varibles;

use warnings;
use strict;



sub isNumeric
{
    my($self,$temp) = @_;
    #($temp~=/([0-9])/) || (print 'test');  
     unless($temp =~ /^\d+$/)
     {
        return 0;
     }

     return 1;

}





1;
