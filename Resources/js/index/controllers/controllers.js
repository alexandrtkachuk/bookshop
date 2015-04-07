
App.service('products', function($http) {
 	
	
	this.getItems= function(callback) { 
		
		  $http.get('api/books').success(callback);	
		
			
		
		
	}
  
});


App.controller('iControler',function(products, mCart ,$scope ,fLang ,$scope){
	
	 $scope.$on("$destroy", function(){
			mCart.setSer();
			
		});
	
	
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
