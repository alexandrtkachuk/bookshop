package Models::Validators::ValidForm;
use Data::Dumper;


sub new
{  
    my $class = ref($_[0])||$_[0];
    return bless({      },$class);
}

sub validForm
{
    my ($fname) = $_[1];
    my ($lname) = $_[2];
    my ($email) = $_[3];
    my ($pass) = $_[4];
    my ($conf_pass) = $_[5];
    my ($phone) = $_[6];

    %err = {};
	if ($fname ne '' && $lname ne '' && $pass ne '' && $conf_pass ne '' && $email ne '' && $phone != '')
	{
		if ($pass == $conf_pass)
		{
			if($email =~ /^([a-z0-9\._-]{3,25})+@([a-z0-9]{2,15})+\.([a-z]{2,4})/i)
            {
                if($phone =~ /([0-9]{10})/)
                {
                    return 1;
                }
                else
                {
                    $err{'phone'} = 'not correct phone number';
                }
            }
            else
            {
                $err{'email'} = 'not correct email';
            }
	    }
        else 
        {
            $err{'pass'} = 'passwords must match';
        }
    }
	else 
	{
		$err{'fields'}= 'enter all fields';
	}	
}


1;
