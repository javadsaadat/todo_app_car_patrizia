part of 'list_todo_cubit.dart';

class ListTodoState extends Equatable {
  final List<TodoModel> todos;
  const ListTodoState({
    required this.todos,
  });
  factory ListTodoState.initial() {
    return const ListTodoState(todos: []);
  }
  @override
  List<Object> get props => [todos];

  ListTodoState copyWith({
    List<TodoModel>? todos,
  }) {
    return ListTodoState(
      todos: todos ?? this.todos,
    );
  }

  @override
  String toString() => 'ListTodoState(todos: $todos)';
}
