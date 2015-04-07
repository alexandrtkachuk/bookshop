App.controller('cCart',function(mCart , $scope){
		
		mCart.getSer();
		
		$scope.$on("$destroy", function(){
			//console.log('!exit!');
			mCart.setSer();
			
		});
	   
	   //mCart.getLS();
	   
	   this.cart=mCart;
	   this.name="Корзина";
	   
	   this.items=mCart.arr;
		
		
		this.total= function ()
		{
			var total = 0;
			this.items.forEach(function(item) {
				total += item.el.price * item.count;
			})
			mCart.setLS();
			console.log('cart');
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
