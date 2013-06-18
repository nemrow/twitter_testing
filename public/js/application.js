$(document).ready(function() {
	$('.tweet-it').submit(function(event){
		event.preventDefault();
		$('img.waiting-cow').slideDown(300);
		$.post('/tweet', $(this).serialize(), function(data){
			$('.tweet-list').html(data)
			$('img.waiting-cow').slideUp(300);
		})
	})
});
