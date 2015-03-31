package Models::Utilits::File;
use Data::Dumper;

#user7 Ткачук


sub new
{
    my $class = ref($_[0])||$_[0];
    return bless({      },$class);
}



sub isfile
{
     
        
    
    

    my($self,$file) = @_;
    if (-e $file) 
    {   
        #print  $tdir.$file;
        return 1;
    } 
    #print  "<br>no file:".$tdir.$file;
    return 0; 


}


sub getFile
{
    my($self,$file) = @_;
    
    unless($self->isfile($file))
    {
        
        return 0;
    }

    local $/=undef;
    open my $fh , "<$file" or return 0;
    my $text = <$fh>;
    close $fh;
    return $text;
}


1;
