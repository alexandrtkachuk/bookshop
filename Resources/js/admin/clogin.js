App.controller('cLogin',function(){
	
	   this.error=''; //типо ошибок нет пока
	   
	   
	   this.email='';
	   this.pass='';
	  
	   	
	   this.send = function (form)
	   {
			//проверка 
		   if(form.$valid){
				
				console.log(this.pass);
				console.log(this.email);
				
				//this.sps='Спасибо! В скором врмени мы с Вами свяжемся';
				
				
			}
		}
	   
	   
		
});
