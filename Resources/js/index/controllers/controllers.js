
App.service('products', function($http) {
 	
	
	this.getItems= function(callback) { 
		
		  $http.get('api/books').success(callback);	
		
			
		
		
	}
  
});


App.controller('iControler',function(products, mCart ,$scope ,fLang){
	
	this.meclass='';
	this.bname='по 4 элемена';
	
	
	this.setClass = function () {
		if(this.meclass==''){ this.meclass='width20'; this.bname='по 3 элемена';}
		else {this.meclass=''; this.bname='по 4 элемена';}
	}
	
	
	var  temp={value: ''}
	this.me=temp;
	
		products.getItems( function(data, status, headers, config) {
			temp.value=data;
			//console.log(data[0]);
        });
	
	
	console.log(fLang.value);
	
	
	
	this.buy=function(ind)
	{		
			mCart.add(this.me.value[ind],1);
			//console.log(this.me.value[ind]);	
	}
	
});
