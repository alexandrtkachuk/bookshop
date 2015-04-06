App.controller('cCart',function(mCart){
	
	   
	   mCart.getLS();
	   
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
			return total;
		}
		
		this.remove = function (index){
			
			mCart.del(index);
			if(0==mCart.count) {
				document.location.href = 'index.html#/';
			}
			//console.log(index);
		}
		
});
