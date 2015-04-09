
App.service('products', function($http) {
 	
	
	this.getItems= function(callback) { 
		
		  $http.get('api/books').success(callback);	
		
			
		
		
	}
	
	
	this.getItems2= function(id,callback) { 
		
		  $http.get('api/getbookforauthor/?num='+id).success(callback);	
		
			
		
		
	}
  
});


App.controller('iControler',function(products, mCart ,$scope ,fLang ,$scope ,$http){
	
	 $scope.$on("$destroy", function(){
			mCart.setSer();
			
		});
	
	
	var  temp={value: ''}
	this.me=temp;
	
	var authors = 
	{
			items:null
	};
	
	
	////////////////
	this.author =authors;
	$http.get('api/getauthors').success(function (data, status, headers, config) {
			
			authors.items = data;		
			
        });	


	var genres = 
	{
			items:null
	};
	
	this.genre = genres;	
	
	$http.get('api/getgenres').success(function (data, status, headers, config) {
			
			genres.items = data;		
			
        });	
	/******************/
		products.getItems( function(data, status, headers, config) {
			temp.value=data;
			//console.log(data[0]);
        });
	
		
	console.log(fLang.value);
	
	
	this.getAuthors = function(id)
	{
		products.getItems2(id , function(data, status, headers, config) {
			temp.value=data;
			//console.log(data[0]);
        });
		
	}
	
	
	this.buy=function(ind)
	{		
			mCart.add(this.me.value[ind],1);
			//console.log(this.me.value[ind]);	
	}
	
});
