App.factory('fLang', function($http) {
  
  
  var lang={"lang":0,
			"value": 0
	  };
  
  //this.temp=lang;
  
 
  
  $http.get('api/lang').success(
				function(data, status, headers, config) {

					console.log(data);
					lang.value = data.ISTRING;
					console.log(lang.value);
				}
			);	
  
	
	 lang.get = function() {
		$http.get('api/lang').success(
				function(data, status, headers, config) {

					//console.log(data);
					lang = data.ISTRING;
				}
			);	
	 
	 }
	 
	 lang.set = function () {
	 
	 
	 }
	
  return lang;
  
  
});
