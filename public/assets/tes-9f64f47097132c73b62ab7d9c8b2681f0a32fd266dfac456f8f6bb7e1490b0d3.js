$('.grid').masonry({
  itemSelector: '.grid-item',
  columnWidth: '.grid-sizer',
  percentPosition: true
});

$(window).on('load', function(){
	$('div.container').masonry({
	columnWidth: 'div.block',
	itemSelector: 'div.block'
	});
});
