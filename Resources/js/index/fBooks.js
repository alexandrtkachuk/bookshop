App.factory('fBooks', function($http) {
  
  
  var Books={
      items:null,
      get:null
	  };
  
  //this.temp=lang;
  
 
  
    
	
	 Books.get = function() 
     {
		$http.get('api/books').success(
				function(data, status, headers, config) {

					//console.log(data);
					Books.items = data;
				}
			);	
	 
	 }
	 
	 Books.getA = function (id) {
	    $http.get('api/getbookforauthor/?num='+id).success(
				function(data, status, headers, config) {
					//console.log(data);
					Books.items = data;
				}
			);	
	 }

	Books.getG = function (id) {
	    $http.get('api/getbookforgenre/?num='+id).success(
				function(data, status, headers, config) {
					//console.log(data);
					Books.items = data;
				}
			);	
	 }

  return Books;
  
  
});
