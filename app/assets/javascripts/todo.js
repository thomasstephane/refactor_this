$(document).ready(function() {
  $('a.new-todo').on('click', function(e) {
    e.preventDefault();
    if ($('.new-form').html()) {
      $('.new-form').toggleClass('hidden');
    } else {
      var form = '<form accept-charset="UTF-8" action="/todos" class="new_todo" id="new_todo" method="post">'+
                 '<label for="todo_title">Title</label>' +
                 '<input id="todo_title" name="todo[title]" size="30" type="text">' +
                 '<label for="todo_body">Body</label>' +
                 '<input id="todo_body" name="todo[body]" size="30" type="text">' +
                 '<label for="todo_list_name">List name</label>' +
                 '<input id="todo_list_name" name="todo[list_name]" size="30" type="text" value="">' +
                 '<input name="commit" type="submit" value="Create Todo">' +
                 '</form>'
      $('.new-form').html(form);
    }

    $('form.new_todo').on('submit', function(e) {
      e.preventDefault();
      $form = $(this);
      $('.new-form').addClass('hidden');
      $.ajax({
        url: $form.attr('action'),
        method: $form.attr('method'),
        data: $form.serialize(),
        dataType: 'json'
      })
        .done(function(data) {
          $form.find('input[type="text"]').val("");
          var nameId = data.list_name.replace(' ', '');
          var template = '<li><a href="/todos/'+data.id+'">'+data.title+':'+data.body+'</a></li>'
          var list = $('#'+nameId);
          if (list.length > 0) {
            list.append(template);
          } else {
            var template = '<li><a href="/todos/'+data.id+'">'+data.title+':'+data.body+'</a></li>'
            var list = '<h2>'+data.list_name+'</h2><ul id="'+nameId+'">'+template+'</ul>'
            $('.todos').append(list);
          }
          var todo = $("a[href='/todos/"+ data.id +"']");
          $('html,body').animate({scrollTop: todo.offset().top},'slow');

        })
        .fail(function(data) {

        })
        .always(function(data) {

        });
    })
  });

  $('.todos h2').on('click', function(e){
      $(this).next('ul').toggle();
  });

  $('.todos li a')
    .mouseenter(function(e) {
      $('.tooltip').html($(this).text().split(':')[1].replace(' ', '')).addClass('active');
    })
    .mouseleave(function(e) {
      $('.tooltip').empty().removeClass('active');
    });
});
