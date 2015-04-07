$(window).unload(function(e){ 
  return "Пока, пользователь!"; 
});




$(window).on('unload', function(){

         return "Пока, пользователь!"; 

});


window.onbeforeunload = function(e) {
  //return  'Dialog text here.';
};

$( window ).unload(function() {
  return "Bye now!";
});
