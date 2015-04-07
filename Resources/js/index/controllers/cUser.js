App.controller('cUser',function(mCart, $http ,fLang){
	
	this.user;
	var  temp={value: '',
		link: '',
		value2: ''
		};
		
	this.text=temp;
	$http.get('api/user').success(function (data, status, headers, config) {
			this.user=data;
			
			//console.log(this.user);
			if(this.user.id) 
			{
				temp.value=  this.user.name;
				temp.value2=  '\  Выход';
				temp.link='logout';
                mCart.user=true;
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
	
	
		
	
	
});
