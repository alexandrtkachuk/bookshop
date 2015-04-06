App.directive('shopHeader', function() {
  return {
      restrict: 'AE',
      replace: 'true',
      templateUrl: "Resources/html/partials/header.html"
  };
});

App.directive('shopProducts', function() {
	
	
	
  return {
      restrict: 'AE',
      replace: 'true',
      controller: "iControler as ic",
      templateUrl: "Resources/html/partials/products.html"
  };
});



App.directive('shopOneProducts', function() {
	return {
      restrict: 'AE',
      replace: 'true', 
	  templateUrl: "Resources/html/partials/oneProduct.html"
  };
});

