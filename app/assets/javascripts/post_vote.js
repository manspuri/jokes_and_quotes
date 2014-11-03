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

$(document).on('click','.vote_control i', function(e){
	var current_highlight_class = $(e.target).closest('.vote_control').find('.highlight').first();
	if(current_highlight_class.length > 0) {
		current_highlight_class = current_highlight_class.hasClass('upvote') ? 'upvote' : 'downvote';
	}
	var current_class = $(e.target).hasClass('upvote') ? 'upvote' : 'downvote';
	if(current_class != current_highlight_class) {
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
				if(clicked.closest('.vote_control').find('.highlight').length) {
					clicked.closest('.vote_control').find('i').removeClass('highlight');
				} else {
					clicked.closest('.vote_control').find('i').removeClass('highlight');
					clicked.addClass('highlight');
				}
				var span = clicked.closest('.vote_control').find('span').first();
				var span_val = span.text() * 1;
				span.text(span_val + value);
			}, error: function(response) {
				console.log(response);
			}
		});
	}
});