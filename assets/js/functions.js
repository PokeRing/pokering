// Browser detection for when you get desparate. A measure of last resort.
// http://rog.ie/post/9089341529/html5boilerplatejs

// var b = document.documentElement;
// b.setAttribute('data-useragent',  navigator.userAgent);
// b.setAttribute('data-platform', navigator.platform);

// sample CSS: html[data-useragent*='Chrome/13.0'] { ... }


(function($){

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
		
		$('a[href*=#]:not([href=#])').on('click', function() {
		
			topOffset = $('h1.prime').height() + 16;
		
			if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
				var target = $(this.hash);
				target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
				if (target.length) {
					$('html,body').animate({
						scrollTop: target.offset().top - topOffset
					}, 300);
				}
			}
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

})(window.jQuery);