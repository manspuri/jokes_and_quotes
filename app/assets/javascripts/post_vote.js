/*
on click .vote_control
	get class of button being clicked
	get id of element being voted on
	submit ajax vote create request with special param to branch
		failed_upvote
			alert('You have already upvoted!')
		failed_downvote
			alert('You have already downvoted!')
		success_upvote
			increase vote number
			if bg default
				make bg green
			else
				make bg default
		success_downvote
			decrease vote number
			if bg default
				make bg red
			else
				make bg default
*/

// function Vote() {

// }

// function voteView() {
	
// }

// function VoteController() {

// }

$(document).on('click','.vote_control', function(e){
	var value = 0;
	if($(e.target).hasClass('upvote')) {
		value = 1;
	} else {
		value = -1;
	}
	var id = $(e.target).closest('li').data('id');
	var clicked = $(e.target);
	$.ajax({
		url: '/comments/'+id+'/votes',
		type: 'post',
		dataType: 'json',
		data: 'vote[value]='+value+'&vote[voteable_id]='+id+'&vote[voteable_type]=Comment',
		success: function(response) {
			clicked.closest('.vote_control').find('i').removeClass('highlight');
			clicked.addClass('highlight');
			var span = clicked.closest('.vote_control').find('span').first();
			var span_val = span.text() * 1;
			span.text(span_val + value);
		}, error: function(response) {
			console.log(response);
		}
	});
});