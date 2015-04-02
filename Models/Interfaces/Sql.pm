package Models::Interfaces::Sql;
#user7

use warnings;
use strict;
use DBI; 
use Data::Dumper;
use Models::Validators::Varibles;




my($database, $host,$user, $pass,$dbh,$sth );

#setQuery



#конструктор
sub new
{

    $database=$_[1]; 
    $host=$_[2];
    $user=$_[3];
    $pass=$_[4];

    my $class = ref($_[0])||$_[0];
    return bless(
        {
            'sql'=>undef, #string quvery
            'table'=>undef, #имя таблици 
            'where'=>undef

        },$class);

}



sub getError
{   
    return 'error connrct to DB' unless($dbh);
    return 'error qerty string' unless($sth);
    return $dbh->errstr() || $sth->errstr() || undef ;   
    #return 0 || 1; 
}

sub connect
{

    my $data_source= "DBI:mysql:database=$database;host=$host";

    $dbh = DBI->connect($data_source, $user, $pass, 
        {PrintError=>0, RaiseError=>0} #отключаем принт ошибок
    );
    
    
    return 1 if($dbh);
    return 0;

}


sub where
{
    return 0 unless($dbh);
    my($self,$val1,$val2,$sign, $union) = @_;
    
    unless($sign)
    {
        $sign='=';
    }
    
    unless($union)
    {
        $union='AND';
    }

    
    if($self->{'where'})
    {
       $self->{'where'}.=" $union $val1 $sign ".$dbh->quote($val2).' ';
    }
    else
    {
        $self->{'where'}="$val1 $sign ".$dbh->quote($val2).' ';
    
    }
    
    return 1;


}


sub select
{
    return 0 unless($dbh);
    my($self,$arr) = @_;
    
    $self->{'sql'}='SELECT '; 
    
    for(@$arr){
         $self->{'sql'}.= $_;
        if(\$_ != \$$arr[-1])
        {
             $self->{'sql'}.= ', ';
        }

    }

    $self->{'sql'}.=' FROM %tabname% ';
    #print $self->{'sql'};


    #return $sth = $dbh->prepare($str);
    #    or die $dbh->errstr;
    return 1;
    

}


sub insert
{

    return 0 unless($dbh);
    my($self,$hash) = @_;
    

    #print Dumper $hash;
    #my %t=%$hash;
    

    $self->{'sql'}='INSERT INTO %tabname%  (';
    my $left= keys %$hash; 
    foreach my  $k (keys %$hash )
    {
        #print   $$hash{$ky};
        $self->{'sql'}.= $k;
        if(0 < --$left  )
        {
            $self->{'sql'}.=', ';

        }    
    }
    
    $self->{'sql'}.=')   VALUES (';
    $left= keys %$hash;
    foreach my  $k (keys %$hash )
    {
        #print   $$hash{$ky};
        $self->{'sql'}.= $dbh->quote($$hash{$k});
        if(0 < --$left  )
        {
            $self->{'sql'}.=', ';

        }    
    }

    $self->{'sql'}.=')   ';



    #Models::Validators::Varibles->isNumeric();
    
    #print $self->{'sql'};
    return 1;
    
}


sub setTable
{
    my($self,$name) = @_;
    unless($name)
    {
        return 0;
    }
    
    $self->{'table'} = $name;
    return 1;
}



sub setQuery
{   
    return 0 unless($dbh);
    my($self,$str) = @_;
    return 0  unless($str);
    $self->{'sql'}=$str;
    return 1;
    
    
}





sub execute
{   

    my($self) = @_;
    unless($self->{'sql'})
    {
        return 0;
    }
    
    #$self->{'sql'}= $dbh->quote( $self->{'sql'});

    
    unless($self->{'table'})
    {
        return 0;
    }    
    
   $self->{'sql'} =~s/%tabname%/$self->{'table'}/;
    

    if($self->{'where'} )
    {
        $self->{'sql'}.=' WHERE '.$self->{'where'};
    }

    #print $self->{'sql'};
    unless($sth = $dbh->prepare($self->{'sql'} ))
    {
        return 0;
    }
    
    return 0 unless($sth);
    return $sth->execute();
}

sub getRows
{
    return 0 unless($sth);
    return $sth->rows;
}

sub getResult
{
    return 0 unless($sth);
    #выходные данные
    my @arr; 

    while (my $row = $sth->fetchrow_hashref()) 
    {    
        push @arr , $row;
       
    }     

    $sth->finish();
    
    return \@arr;

}



sub DESTROY 
{
    my($self) = @_;
    if($dbh ){
        $dbh->disconnect();
    }

}

1;
