$(document).ready(function(){
	function build_comments_list(comments_list) {
		var html = '';
		var i;

		html += '<ul>';
		for(i = 0; i < comments_list.length; i++) {
			html += build_comment(comments_list[i]);
		}
		html += '</ul>';

		return html;
	}

	function build_comment(comment) {
		var html = '' +
		'<li data-id="'+ comment["id"] +'">' +
			'<div class="vote_control"><i class="fa fa-chevron-circle-up upvote"></i>'+ comment["votes"] +'<i class="fa fa-chevron-circle-down downvote"></i></div>' +
			'<header>' +
				'<span class="comment-author">'+ comment["username"] +'</span>' +
				'<span class="comment-date">'+ comment["date"] +'</span>' +
				'<i class="fa fa-plus-square add_comment"></i>' +
			'</header>' +
			'<div class="comment-text">' + comment["text"] + '</div>';
		
		if(typeof comment["comments"] != 'undefined' && comment["comments"].length > 0) {
			html += build_comments_list(comment["comments"]);
		}

		html += '</li>';

		return html;
	}

	$('.post-comments').append(build_comments_list(comments));
});