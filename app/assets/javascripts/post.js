$(document).ready(function(){
	function sort_comments_by_popularity(comments_list) {
		var i;

		comments_list.sort(function(a,b) {
			return b["votes"] - a["votes"];
		});

		var new_comment_list = [];
		for(i = 0; i < comments_list.length; i++) {
			if(typeof comments_list[i]["comments"] != 'undefined' && comments_list[i]["comments"].length > 0) {
				comments_list[i]["comments"] = sort_comments_by_popularity(comments_list[i]["comments"]);
			}
			new_comment_list.push(comments_list[i]);
		}

		return new_comment_list;
	}

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

	$('.post-comments').append(build_comments_list(sort_comments_by_popularity(comments)));
});