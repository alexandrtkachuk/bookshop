var App=angular.module('myshop',['ui.router']);



App.factory('mCart', function() {
  
  
  var cart={"count":0,
	  "arr": new Array(),
	  "add": null,
	  "del": null,
	  "setLS": null,
	  "getLS": null
	  };
  
  
  
  cart.add=function (el,count){
		
		
			var obj={
				'el':el,
				'count': count
				}
			
	  
		var test=true;
		
		this.arr.forEach(function(entry) {
			if(null!==entry){
				if(entry.el.id==obj.el.id){ 
					if(entry.count==obj.count) {
						test=false;
						return;
					}
					else {
						entry.count=obj.count;
						test=false;
						return;
					}
				}
			}
		});
		
		if(test===true){
		
			this.arr.push(obj);
		}
		
		
		
		
		this.count=this.arr.length;	
		
		//console.log(this.arr);
		//in store
		//
		this.setLS();
	  
	  }
  
	cart.del= function (index)
	{
			this.arr.splice(index,1);
			this.count=this.arr.length;
			this.setLS();
	}
	
	cart.setLS = function ()
	{	//вносим в локал сторе
		var temp={
			"count":this.count,
			"arr":this.arr
			}
		window.localStorage.taishop=JSON.stringify(temp);	
	}
	
	cart.getLS = function () {
		//console.log('get');
		if(this.count>0){return;}
		
		//console.log('get');
		
		if( typeof(window.localStorage.taishop) == "string"){
			var temp=$.parseJSON('[' + window.localStorage.taishop+ ']');
			if(typeof(temp[0].count)=="number"){
				//this.count=temp[0].count;
				//this.arr=temp[0].arr;
				//console.log(temp[0].arr);
				temp[0].arr.forEach(function(entry) {
				   cart.add(entry.el, entry.count);
					//console.log(entry);
				});
				
				
				
			}
			
		}	
		
	} //end get
	
	
	cart.clear= function(){
		this.arr= new Array();
		this.count=0;
		this.setLS();
	}
	
	
  return cart;
  
  
});




//глобальная корзина
App.controller('gCart',function($scope ,mCart){
		
	
	
	
	
	
	/*
	var t;
	
	if( typeof(window.localStorage.taishop) == "string")
		{
			var arr= $.parseJSON('[' + window.localStorage.taishop+ ']');
			//console.log(vCart);
			
			if(arr!=0) {
				vCart.total=arr[0].total;
				vCart.arr=arr[0].arr;
			}
			//console.log(arr[0]);
		}
		
	window.localStorage.taishop=0;
	
	*/
	
	
	//
	//window.localStorage.tai=JSON.stringify(vCart);
	
});
