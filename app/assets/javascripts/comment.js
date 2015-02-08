function showCommentInputForm(response, buttonID, button){
  $('#comment-' + buttonID + '-input').append(response);
  button.hide();
}

$(document).ready(function(){
  
  $('.add-comment').on('click', function(e){
    var button, url, request;

    e.preventDefault();
    button = $(this);
    
    url = button.find('a').attr('href');
    request = $.get( url );

    request.done(function(response){
      $('#main-add-comment-input').append(response);
      button.hide();
      if ( $('.edit_post_button') ) {
       $('.edit_post_button').hide();
      }
    });
  });

  $('#main-add-comment-input').on('submit', '.add-comment', function(e){
    var url, comment, form;
    e.preventDefault();
    form = $(this);
    url = form.attr('action');
    comment = form.serialize();
    request = $.post( url, comment );

    request.done(function(response){
      form.hide();
      $('.main_add_comment_btn').show();
      $('#comments-container').append(response);
    });
    return false;
  });

  $('#comments-container').on('click', '.sub-comment-link', function(e){
    var button, url, request;
    e.preventDefault();

    button = $(this);

    var buttonID = button.attr('id');
    url = button.find('a').attr('href');
    request = $.get( url );

    request.done(function(response){
      showCommentInputForm(response, buttonID, button);
    });
  });

  $('#comments-container').on('submit', '.add-comment', function(e){
    var url, comment, form;
    e.preventDefault();
    form = $(this);
    url = form.attr('action');
    comment = form.serialize();

    request = $.post( url, comment );

    request.done(function(response){
      console.log(form.siblings());
      form.hide();
      $('.sub_add_comment_link').show();
      form.parent().parent().siblings('ul').append(response);
    });
    return false;
  });

});