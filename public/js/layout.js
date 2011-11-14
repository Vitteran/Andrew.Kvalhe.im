var length;
var counter;
$(document).ready(function() {
	length = $('div#poweredby ul li').length;
	counter = 1;

	all = $('div#poweredby ul li');
	all.css('top', '1.2em');
	all.css('opacity', '0.0');
	all.css('visibility', 'hidden');

	first = $('div#poweredby ul li:first');
	first.css('top', '0em');
	first.css('opacity', '1.0');
	first.css('visibility', 'visible');

	function rotate() {
		current = $('div#poweredby ul li:nth-child(' + counter + ')');
		current.animate({top: '-3.6em', opacity: '0.0'}, 500, function() {
			current.css('top', '1.2em');
			current.css('visibility', 'hidden');
		});

		next = $('div#poweredby ul li:nth-child(' + (counter == length ? 1 : counter + 1) + ')');
		next.css('visibility', 'visible')
		next.animate({top: '0em', opacity: '1.0'}, 500);

		counter++;
		if (counter > length) {counter = 1;}
	}

	interval = setInterval(rotate, 2000);
});
