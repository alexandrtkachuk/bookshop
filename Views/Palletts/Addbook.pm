package Views::Palletts::Addbook;


use warnings;
use strict;


#три строчки которые делают наследие 
use vars qw(@ISA); 
our @ISA = qw(Views::Palletts::Index);
require Views::Palletts::Index;
use Config::Config;
use Models::Performers::Authors;
use Models::Performers::Genre;
use Data::Dumper;



my $data = Models::Utilits::Date->new();


sub createHash
{
    
    my ($self)=@_;

    $self->{'title'}='Добавить книгу';
    $self->{'baseurl'}=Config::Config->getBaseUrl() ;
    $self->{'getHeader'}=$self->loadTemplate('Header');
    $self->{'getFooter'}=$self->loadTemplate('Footer');
    #$self->{'getContent'}=$self->loadTemplate($data->{'pageparam'});
    #print $data->{'pageparam'};
}



sub warings
{
    my $mess='';

    
    if($data->{'warnings'}==1)
    {
         $mess = 'неверный логин или пароль при входе';
    }
    elsif($data->{'warnings'}==2 )
    {
        $mess = 'не все поля заполнены в форме';
    }
    elsif($data->{'warnings'}==4 )
    {
        $mess = 'ошибка записи';
    }
    elsif($data->{'warnings'}==5 )
    {
        $mess = 'запись успешно добавлена';
    }



    return $mess;

}


sub Authors
{
    #return list authors
    my $author = Models::Performers::Authors->new();
    my $res = $author->getAll();
    my $str='';

    for(@$res )
    {
        $str.='<option value="'.$_->{'id'}.';" >'.$_->{'name'}.'</option>';
    } 
    #print Dumper $res;

    return $str;


}



sub Genres
{
    #return list authors
    my $genre = Models::Performers::Genre->new();
    my $res = $genre->getAll();
    my $str='';

    for(@$res )
    {
        $str.='<option value="'.$_->{'id'}.';" >'.$_->{'name'}.'</option>';
    } 
    #print Dumper $res;

    return $str;


}

1;
