$(document).ready(function() {
	var max = $('div#poweredby ul li').length;
	var counter = 1;

	setInterval(function() {
		$('div#poweredby ul li:nth-child(' + counter + ')').animate({
			opacity: '0.0',
			top: '-3.6em'
		}, function() {
			$(this).css({
				top: '1.2em'
			});
		});

		counter++; if (counter > max) {counter = 1;}

		$('div#poweredby ul li:nth-child(' + counter + ')').css({
			top: '1.2em'
		}).animate({
			opacity: '1.0',
			top: 0
		});
	}, 2000);
});
