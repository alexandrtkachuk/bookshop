package Models::Utilits::UseClass;
#user7
#для того чтобы подключить нужный нам класс 
#функия getCls будет возвращять нам нужный класс
#методы c _ будут статичныны
use Models::Utilits::File;
use Encode;
use Models::Utilits::Debug;
my $debug = Models::Utilits::Debug->new();

sub _getCls($$$) 
{
    
    my ($self,$path,$name,$param)=@_;
    my $tdir = Config::Config->getDir(); 
    
    split /\//, $test; 
    
    my $f= Models::Utilits::File->new();
    
    #$me=decode('utf8',$me);   
    my $me= $path.$name.'.pm';
    
    unless($f->isfile($tdir.'/'.$me))
    {
      $debug->setMsg('no file'); 
      return 0;
    }
    
    my $filepath=decode('utf8',$tdir.'/'.$me);
    
    #print $filepath."\n";
    eval{ require $filepath ;};#подключаем файл
    if($@)
    {   
        $debug->setMsg($@);
    }
        

       
    $me=~s/\//::/g;
    $me=~s/.pm//;
    my $r; 
    eval { $r= $me->new($param);}; #передаем параметр  
    if($@)
    {   
        $debug->setMsg($@);
    }
    
    return $r;

}






1;
