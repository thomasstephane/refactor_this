var TodoList = function(name) {
  this.name = name;
  this.id = this.name.replace(' ', '');
}

TodoList.prototype.render = function() {
  return HandlebarsTemplates['todo-list']({name: this.name, id: this.id});
}

TodoList.prototype.addTodo = function(todo) {
  $('#'+this.id).append(todo);
}
