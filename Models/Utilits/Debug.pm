package Models::Utilits::Debug;
use warnings;
use strict;



my $self;
#конструктор
sub new
{
    
    
    my $class = ref($_[0])||$_[0];
    $self||=bless({
            'msg'=>[]
        },$class);

    return $self;
}


sub setMsg
{
    my ($self,$msg)=@_;
    my $count = @{$self->{'msg'}}; 
    #print 'Count:'.$count.'!';
     $self->{'msg'}[$count]=$msg;
    return 1;
}

sub getMsg
{
    my ($self)=@_;
    
    return $self->{'msg'};

}




1;
