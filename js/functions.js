// JavaScript Document

$(document).ready(function(){
	new formValidation("#contact-form");	
	
	// page scroller
	$("a[href*=#]").click(function() {
	
		if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) 
		{
			var myHash = this.hash;
		  	var $target = $(myHash);

		  	$target = $target.length && $target || $('[name=' + this.hash.slice(1) +']');
		
			if ($target.length) 
			{
				var targetOffset = $target.offset().top;
				var current = $('html,body').scrollTop();
				var distance = Math.abs(targetOffset - current);
				
				// if distance greater than 1000px, give it more time
				var myDuration =  distance > 1000 ? 2000 : 1000;
				
				function scrollComplete(){ window.location.hash = myHash; }
				//$('html,body').animate({scrollTop: targetOffset}, 900);				
				$('html,body').animate({scrollTop : targetOffset}, {duration: myDuration, easing: "easeInOutQuint", complete : scrollComplete});
				
				return false;
			}
		}
	  });
	
	// slideshow
	$('div.slideshow').css({overflow : 'hidden'}).
	find('div.slider').css({float : 'none'});
	$('a.nextSlide').click(function(){
		var $slider = $('div.slider');
		$slider.animate({left : -536}, {duration: 1000, easing: "easeInOutExpo"});
		
		return false;
	});
	
	// slideshow
	$('a.prevSlide').click(function(){
		//$('div#slider').animate({scrollTop : 100}, 100);
		var $slider = $('div.slider');
		$slider.animate({left : 0}, {duration: 1000, easing: "easeInOutExpo"});
		//tweenHolder('left');							   
		return false;
	});
});

function tweenHolder(direction){
	var $thumbs = $('#thumbs');
	
	if (direction == 'left'){
		$thumbs.css('left', '-100px');
	} else {
		$thumbs.css('left', '0px');
	}	
}