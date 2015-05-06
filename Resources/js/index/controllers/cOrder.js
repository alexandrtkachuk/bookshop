App.controller('cOrder',function($stateParams, mCart, $http, fLang){
	this.lang = fLang;
	var  temp={items:null};
	
	
	this.temp = temp;
	
	$http.get('api/getorders/?num='+$stateParams.id).success(function (data, status, headers, config) {
			
			temp.items = data;
			console.log(data);
			
			
      });	
	
	
});
