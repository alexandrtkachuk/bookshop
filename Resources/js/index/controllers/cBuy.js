App.controller('cBuy',function(mCart){
	
	   this.error=''; //типо ошибок нет пока
	   
	   this.name='test';
	   this.email='';
	   this.male='m';
	   this.phone;
	   this.sps='';
	   	
	   this.send = function (form)
	   {
			//проверка 
		   if(form.$valid){
				
				console.log(this.name);
				console.log(this.email);
				console.log(this.male);
				console.log(this.phone);
				this.sps='Спасибо! В скором врмени мы с Вами свяжемся';
				mCart.clear();
				
			}
		}
	   
	   
		
});
