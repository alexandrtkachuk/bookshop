


App.controller('iControler',function( fBooks, mCart ,$scope ,fLang ,$scope ,$http){
	
	 $scope.$on("$destroy", function(){
			mCart.setSer();
			
		});
	
	fBooks.get();
	this.me=fBooks;
	
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
			
		
	console.log(fLang.value);
	
	
	this.getAuthors = function(id)
	{
				
        fBooks.getA(id);
	}
	this.getGenres = function(id)
	{
				
        fBooks.getG(id);
	}

	
	this.buy=function(ind)
	{		
			mCart.add(this.me.items[ind],1);
			//console.log(this.me.value[ind]);	
	}
	
});
