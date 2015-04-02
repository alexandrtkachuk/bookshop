App.config(function($stateProvider, $urlRouterProvider) {
	  //
	  // For any unmatched url, redirect to /state1
	  //urlRouterProvider.otherwise("/");
	  $urlRouterProvider.otherwise("/");
	  
	  
		$stateProvider
		.state('index', {
		  url: "/",
		  templateUrl: "Resources/html/Login.html",
		  controller: "cLogin as cL",
		})
	  
});
