App.config(function($stateProvider, $urlRouterProvider) {
	  //
	  // For any unmatched url, redirect to /state1
	  //urlRouterProvider.otherwise("/");
	  $urlRouterProvider.otherwise("/");
	  $urlRouterProvider.when('/cart', [ 'mCart',function (mCart) {
            //console.log(mCart);
            mCart.getLS();
            if(mCart.count==0)
            {
					return '/'; //кула перенапрвить если корзина пуста
			}
            
            return false;
		}]);
	
	
	$urlRouterProvider.when('/buy', [ 'mCart',function (mCart) {
            //console.log(mCart);
            mCart.getLS();
            if(mCart.count==0)
            {
					return '/'; //куда перенапрвить если корзина пуста
			}
            
            return false;
		}]);
	
	$stateProvider
		.state('index', {
		  url: "/",
		  templateUrl: "Resources/html/partials/index.html"
		})
	
	
		.state('product', {
		  url: "/product/{id}",
		  controller: "cProduct as cP",
		  templateUrl: "Resources/html/partials/product.html"
		})
  
		.state('cart', {			
		  url: "/cart",
		  controller: "cCart as cC",
		  templateUrl: "Resources/html/partials/cart.html"
		})
		
		.state('buy', {			
		  url: "/buy",
		  controller: "cBuy as cB",
		  templateUrl: "Resources/html/partials/buy.html"
		})
		

  });
