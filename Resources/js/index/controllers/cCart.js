App.controller('cCart',function(mCart ,fLang, $scope){
		
		mCart.getSer();
		this.lang = fLang;
		$scope.$on("$destroy", function(){
			//console.log('!exit!');
			mCart.setSer();
			
		});
	   
	   //mCart.getLS();
	   
	   this.cart=mCart;
	   this.name="Корзина";
	   
	   this.items=mCart.arr;
		
		this.totalsale = function()
		{
			var total = 0;
			this.items.forEach(function(item) {
				total += item.el.price * item.count;
			})
			//mCart.setLS();
			//console.log('cart');
			total -= total* (mCart.sale/100);
			
			return total;	
		}
		
		this.total= function ()
		{
			var total = 0;
			this.items.forEach(function(item) {
				total += item.el.price * item.count;
			})
			mCart.setLS();
			//console.log('cart');
			return total;
		}
		
		this.remove = function (index){
			
			mCart.del(index);
			if(0==mCart.count) {
				document.location.href = '#/';
			}
			//console.log(index);
		}
		
});
