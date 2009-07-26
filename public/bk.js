Event.observe(document, 'dom:loaded', function() {
	$$('.desc').invoke('hide');
	$('overview').show();
	$$('.letter').each(function(item){
		item.observe('mouseover', revealDesc);
	});
});

function revealDesc(event) {
	var elt = this
	elt.className.split(' ').each(function(item){
		if (item != 'letter' && item != 'code') {
			$$('.desc').invoke('hide');
			$$('.vertical').invoke('hide');
			$(item, 'u' + item, 'l' + item).invoke('show');
			elt.setStyle('color: #7f2643;')
		}
	})
};