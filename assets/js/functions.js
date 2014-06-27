// Browser detection for when you get desparate. A measure of last resort.
// http://rog.ie/post/9089341529/html5boilerplatejs

// var b = document.documentElement;
// b.setAttribute('data-useragent',  navigator.userAgent);
// b.setAttribute('data-platform', navigator.platform);

// sample CSS: html[data-useragent*='Chrome/13.0'] { ... }


(function($){

	$(window).load(function (){
		
		var nav = '<nav class="prime"><ol>';

		$.each($("article[id]"), function() {
			
			thisID = $(this).attr('id');
			thisTitle = $(this).children('h1').html();
		
			nav += '<li><a href="#' + thisID + '">' + thisTitle + '</a></li>';
		});

		nav += '</ol></nav>';
	
		$('body').append(nav);
		
		$('nav').on('click', 'a', function() {
		
			topOffset = $('h1.prime').height() + 16;
		
			if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
				var target = $(this.hash);
				target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
				if (target.length) {
					$('html,body').animate({
						scrollTop: target.offset().top - topOffset
					}, 500);
				}
			}
		});
		
		$.wait(function() { $('body').addClass('activated') }, .5);

		
	});

	$(document).ready(function (){
	
		$('.badge-count[data-demoable]').on('click', function() {
			
			updateCount($(this), 1);
			
		});
	
		$('.red-chip[data-demoable]').on('click', function() {
			
			$(this).toggleClass('active');
			
		});
		
		$('div.sample').each(function() {
			
			sample = $(this).html();
			
			sample = sample.replace(/ data-demoable=""/g, '');
			
			sample = sample.replace(/ data-standalone=""/g, '');
			
			sample = sample.replace(/\t/g, '');
			
			sample = sample.replace(/</g, '&lt;');
			
			$(this).after('<pre class="sample">' + sample + '</pre>');
			
		});
		
		$('.open-star[data-rating-value]').on('click', function() {
		
			// call the function that makes the server call for the rating here
			
			$('.open-star[data-rating-value]').removeClass('lit half-lit users-rating');
			
			$(this).addClass('users-rating');
			
		});
	
	});

function updateCount(which, changeValue) {
	
	console.log('clicked');
	
	currentValue = parseInt(which.html());
	
	newValue = currentValue + changeValue;
	
	which.addClass('flash').html(newValue);
	
	which.on('webkitAnimationEnd', function() {
		which.removeClass('flash');
	});
	
}

$.wait = function( callback, seconds){
   return window.setTimeout( callback, seconds * 1000 );
}

})(window.jQuery);