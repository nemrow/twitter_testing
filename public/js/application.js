$(document).ready(function() {
	$('.tweet-it').submit(function(event){
		event.preventDefault();
    var job_id;
		$.ajax({
      type: "POST",
      url: '/tweet',
      data: $(this).serialize(),
      beforeSend: function(){
        $('input[name="tweet"]').val('');
        $('img.waiting-cow').slideDown(300);
      },
      success: function(data){
        job_id = data;
        looper = setTimeout(function(){
          $.get('status/'+job_id, function(data){
            if (data === 'true'){
              $.post('/display_tweets',function(data){
                $('.tweet-list').html(data);
                $('img.waiting-cow').slideUp(300);
              });
              clearTimeout(looper);
            }
          });
        },500);
      }
    });
	});
});
