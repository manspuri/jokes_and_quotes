$(document).ready(function(){
	function Comment() {
		this.formSubmit = function(view) {
			var text = view.formInputValue();
			if(text !== '') {
				var data = 'comment[text]=' + encodeURIComponent(text);
				data += '&comment[commentable_id]=' + view.formId();
				data += '&comment[commentable_type]=Comment';
				$.ajax({
					url: '/comments',
					type: 'post',
					data: data,
					dataType: 'json',
					success: function(response) {
						view.appendComment(response);
						view.deleteForm();
					},
					error: function(response) {
						console.log(response);
						view.deleteForm();
					}
				});
			}
			else {
				view.deleteForm();
			}
		};
	}

	function CommentView() {
		this.commentButton = function() {
			return $('.add_comment');
		};

		this.formInjectionPoint = function(e) {
			return $(e.target).closest('li').children('.comment-text').first();
		};

		this.createCommentForm = function() {
			var html = '' +
				'<div class="comment-wrapper">' +
					'<textarea id="sub-add-comment-input"></textarea>' +
					'<br><div class="sub-add-comment-btn">Add Comment</div>' +
				'</div>';
			return html;
		};

		this.document = function() {
			return $(document);
		};

		this.submitButtonIdentifier = function() {
			return '.sub-add-comment-btn';
		};

		this.formInputValue = function() {
			return this.root().find('textarea').val();
		};

		this.formId = function() {
			return this.root().closest('li').data('id');
		};

		this.commentInjectionPoint = function() {
			return this.root().closest('li').children('ul').first();
		};

		this.secondaryInjectionPoint = function() {
			return this.root().closest('li');
		};

		this.appendComment = function(comment) {
			var html = '' +
			'<li data-id="'+ comment["id"] +'">' +
				'<div class="vote_control"><i class="fa fa-chevron-circle-up upvote"></i>'+ comment["votes"] +'<i class="fa fa-chevron-circle-down downvote"></i></div>' +
				'<header>' +
					'<span class="comment-author">'+ comment["username"] +'</span>' +
					'<span class="comment-date">'+ comment["date"] +'</span>' +
					'<i class="fa fa-plus-square add_comment"></i>' +
				'</header>' +
				'<div class="comment-text">' + comment["text"] + '</div>' +
			'</li>';
			var injectionPoint = this.commentInjectionPoint();
			if(injectionPoint.length !== 0) {
				injectionPoint.append(html);
			}
			else {
				console.log('second');
				this.secondaryInjectionPoint().append('<ul>'+html+'</ul>');
			}
		};

		this.root = function() {
			return $('.comment-wrapper');
		};

		this.deleteForm = function() {
			this.root().remove();
		};
	}

	function CommentController() {
		var comment = new Comment();
		var view = new CommentView();

		this.run = function() {
			view.commentButton().on('click', function(e){
				console.log('button clicked');
				view.formInjectionPoint(e).after(view.createCommentForm());
			});

			view.document().on('click',view.submitButtonIdentifier(),function(e){
				comment.formSubmit(view);
			});
		};
	}

	function Post() {
		this.sort_comments_by_popularity = function(comments_list) {
			var i;

			comments_list.sort(function(a,b) {
				return b["votes"] - a["votes"];
			});

			var new_comment_list = [];
			for(i = 0; i < comments_list.length; i++) {
				if(typeof comments_list[i]["comments"] != 'undefined' && comments_list[i]["comments"].length > 0) {
					comments_list[i]["comments"] = this.sort_comments_by_popularity(comments_list[i]["comments"]);
				}
				new_comment_list.push(comments_list[i]);
			}

			return new_comment_list;
		};
	}

	function PostView() {
		this.appendComments = function(comments_list) {
			var html = build_comments_list(comments_list);
			$('.post-comments').append(html);
		};

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
	}

	function PostController() {
		var post = new Post();
		var view = new PostView();

		this.run = function(comments_list) {
			view.appendComments(post.sort_comments_by_popularity(comments_list));
		};
	}

	function CommentForm() {
		this.mainFormSubmit = function(view) {
			var text = view.mainFormInputValue();
			if(text !== '') {
				var data = 'comment[text]=' + encodeURIComponent(text);
				data += '&comment[commentable_id]=' + view.mainFormId();
				data += '&comment[commentable_type]=Post';
				$.ajax({
					url: '/comments',
					type: 'post',
					data: data,
					dataType: 'json',
					success: function(response) {
						view.appendComment(response);
					},
					error: function(response) {
						console.log(response);
					}
				});
			}
			view.clearMainFormInput();
		};
	}

	function CommentFormView() {
		this.mainFormButton = function() {
			return $('.main_add_comment_btn');
		};

		this.mainFormInput = function() {
			return $('#main-add-comment-input');
		};

		this.toggleMainForm = function(e) {
			this.mainFormInput().toggleClass('hidden');
			$target = $(e.target);
			if($target.text() == 'Add Comment') {
				$target.text('Submit');
			} else {
				$target.text('Add Comment');
			}
		};

		this.mainFormInputValue = function() {
			return this.mainFormInput().val().trim();
		};

		this.mainFormIsVisible = function() {
			return !this.mainFormInput().hasClass('hidden');
		};

		this.clearMainFormInput = function() {
			this.mainFormInput().val('');
		};

		this.mainFormId = function() {
			return this.mainFormInput().data('id');
		};

		this.commentsList = function() {
			return $('.post-comments').children('ul').first();
		};

		this.appendComment = function(comment) {
			var html = '' +
			'<li data-id="'+ comment["id"] +'">' +
				'<div class="vote_control"><i class="fa fa-chevron-circle-up upvote"></i>'+ comment["votes"] +'<i class="fa fa-chevron-circle-down downvote"></i></div>' +
				'<header>' +
					'<span class="comment-author">'+ comment["username"] +'</span>' +
					'<span class="comment-date">'+ comment["date"] +'</span>' +
					'<i class="fa fa-plus-square add_comment"></i>' +
				'</header>' +
				'<div class="comment-text">' + comment["text"] + '</div>' +
			'</li>';
			this.commentsList().append(html);
		};
	}

	function CommentFormController() {
		var view = new CommentFormView();
		var form = new CommentForm();

		this.run = function() {
			view.mainFormButton().on('click', function(e){
				if(view.mainFormIsVisible()) {
					form.mainFormSubmit(view);
				}
				view.toggleMainForm(e);
			});
		};
	}

	if(window.location.href.match(/\/posts\/\d+/,'i')) {
		new PostController().run(comments);
		new CommentFormController().run();
		new CommentController().run();
	}
});
