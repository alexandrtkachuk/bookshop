App.factory('fLang', function($http) {
  
  
  var lang={"lang":0,
			"value": 0
	  };
  
  //this.temp=lang;
  
 
  if (lang.value==0){
	$http.get('api/lang').success(
				function(data, status, headers, config) {
					console.log(data);
					lang.value = data.ISTRING;
					console.log(lang.value);
				}
			);	
  }
	
	 lang.get = function() {
		$http.get('api/lang').success(
				function(data, status, headers, config) {
					console.log(data);
					lang.value = data.ISTRING;
				}
			);	
	 
	 }
	 
	 lang.set = function (lang) {
			return $http.get('api/setlang/?lang='+lang).success(
				function(data, status, headers, config) {
					console.log(data);
					return data;
					//lang.get();
				}
			);	
			
			
	 }
	
  return lang;
  
  
});
