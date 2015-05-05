package Models::Validators::Varibles;

use warnings;
use strict;



sub isNumeric
{
    my($self,$temp) = @_;
    
     unless($temp =~ /^[+-]?\d+$/)
     {
        return 0;
     }

     return 1;

}


sub isNumeric2
{
    my($self,$temp) = @_;
    unless($temp =~ /^[+-]?\d+\.?\d+$/)
    {
        return 0;
    }

     return 1;
}




1;
