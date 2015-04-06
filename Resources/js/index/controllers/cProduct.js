
App.service('getproduct', function($http) {
 	
	
	this.getItem= function(id,callback) { 
		
		  $http.get('api/books/?num='+id).success(callback);	
	
	}
  
});


App.controller('cProduct',function(getproduct, $stateParams, mCart){
	
	
	
	this.value=1;
	
	var  temp={value: ''}
	this.item=temp;
	
		getproduct.getItem($stateParams.id, function (data, status, headers, config) {
			temp.value=data;
        });
	
	
	this.buy=function(count){

			mCart.add(this.item.value,count);
			
	}
	
	
});
