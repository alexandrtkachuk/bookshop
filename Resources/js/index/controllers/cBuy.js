App.controller('cBuy',function(mCart , $http){
	
	   this.error=''; //типо ошибок нет пока
	   
	   this.name='test';
	   this.email='';
	   this.male='m';
	   this.phone;
	   this.sps='';
	   this.payment = 1;
	   var  temp={items: null};
	   	
	   
	   this.arr= temp;	
	   	
	   $http.get('api/payment').success(function (data, status, headers, config) {
			
			//console.log(data);
			temp.items=data;
			
        });	
	   
	   	
	   	
	   this.send = function (form)
	   {
			//проверка 
		   if(form.$valid){
				
				console.log(this.payment);
				$http.get('api/addorder/?payment='+this.payment).success(function (data, status, headers, config) {
					
					console.log(data);
					
				});	
				
				//console.log(this.email);
				//console.log(this.male);
				//console.log(this.phone);
				//this.sps='Спасибо! В скором врмени мы с Вами свяжемся';
				//mCart.clear();
				
			}
		}
	   
	   
		
});
