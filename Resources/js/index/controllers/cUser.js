App.controller('cUser',function(mCart, $http ,fLang){
	this.lang =fLang;
	this.user;
	var  temp={value: '',
		link: '',
		value2: '',
		orders:null
		};
	this.me = mCart;
	this.text=temp;
	
	this.test = function(val)
	{
		console.log('val='+val);
		if (val==0)
		{
			return this.lang.value.LANG_nosendmoney.VALUE;
		}
		else
		{
			return this.lang.value.LANG_sendmoney.VALUE;
		}
		
	}
	$http.get('api/user').success(function (data, status, headers, config) {
			this.user=data;
			
			//console.log(this.user);
			if(this.user.id) 
			{
				temp.value=  this.user.name;
				temp.value2=  '\  Выход';
				temp.link='logout';
                //mCart.user=true;
			}
			else
			{
					//temp.value='<a href="login">Вход</a>';
				temp.value2=  'Вход';
				temp.link='login';
			}
			
			//console.log(this.user);
			//console.log(temp.value);
			
        });	
	
	
	
	
	if(mCart.user>0)
	{
		$http.get('api/getorders').success(function (data, status, headers, config) {
			
			temp.items = data;
			
			
			
        });	
	}
	
	
});
