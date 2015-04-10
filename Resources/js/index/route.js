App.config(function($stateProvider, $urlRouterProvider) {
	  //
	  // For any unmatched url, redirect to /state1
	  //urlRouterProvider.otherwise("/");
	  $urlRouterProvider.otherwise("/");
	  
	
	  
	  $urlRouterProvider.when('/cart', [ 'mCart',function (mCart) {
            
            
           
            
            
            
            mCart.getSer();
            if(mCart.count==0)
            {
					return '/'; //куда перенапрвить если корзина пуста
			}
            
            return false; 
            
            
		}]);
	
	
	$urlRouterProvider.when('/user', [ 'mCart',function (mCart) {
            //console.log(mCart);
            mCart.getSer();
            
            if(mCart.user<1)
            {
					return '/'; //куда перенапрвить если корзина пуста
			}
            
            return false;
		}]);
		
		
	$urlRouterProvider.when('/order/*', [ 'mCart',function (mCart) {
            //console.log(mCart);
            mCart.getSer();
            
            if(mCart.user<1)
            {
					return '/'; //куда перенапрвить если корзина пуста
			}
            
            return false;
		}]);	
	
	$urlRouterProvider.when('/buy', [ 'mCart',function (mCart) {
            //console.log(mCart);
            mCart.getSer();
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
		
		.state('user', {			
		  url: "/user",
		  controller: "cUser as cU",
		  templateUrl: "Resources/html/partials/user.html"
		})
		
		.state('order', {			
		  url: "/order/{id}",
		  controller: "cOrder as cO",
		  templateUrl: "Resources/html/partials/order.html"
		})
		  

  });
