App.controller('cLang',function(fLang){
	
		
		this.lang=fLang;
		
		this.ru = function ()
		{
			console.log('go ru');
			fLang.set('ru').then( function(data)
			{
				//console.log('ru');
				fLang.get();
			},
			
			function(reason) {
				console.log('errr');
			
			});
		}
		
		this.en= function ()
		{
			console.log('go en');
			fLang.set('en').then( function(data)
			{
					//console.log(data);
					//console.log('no me');
					fLang.get();
			},function(reason) {
			//failure - log and/or display `reason` as an error message
			//console.log('meee');
			
			}
			
			) ;
		}
	
	
});
