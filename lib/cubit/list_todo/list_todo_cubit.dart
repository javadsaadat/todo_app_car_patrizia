import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:todo_app_car_patrizia/data_base_isar/data/user_crud.dart';
import 'package:todo_app_car_patrizia/data_base_isar/model/todo.dart';
import 'package:todo_app_car_patrizia/model/todo.dart';

part 'list_todo_state.dart';

class ListTodoCubit extends Cubit<ListTodoState> {
  final TodoCRUD todoCRUD;
  ListTodoCubit({required this.todoCRUD}) : super(ListTodoState.initial()) {
    getSavedTodo();
  }
  getSavedTodo() async {
    List<Todo?> todos = await todoCRUD.readAllTodo();

    emit(
      state.copyWith(
        todos: todos
            .where(
              (element) => element != null,
            )
            .toList()
            .map(
              (e) => TodoModel(
                id: e!.code,
                categori: e.categori,
                title: e.title,
                notes: e.notes,
                alarm: e.alarm?.toJalali(),
                everyDay: e.everyDay,
                compelete: e.compelete,
              ),
            )
            .toList(),
      ),
    );
  }

  addTodo(TodoModel todo) async {
    await todoCRUD.writeTodo(
      todo: Todo(
        alarm: todo.alarm?.toDateTime(),
        code: todo.id,
        title: todo.title,
        categori: todo.categori,
        notes: todo.notes,
        everyDay: todo.everyDay,
        compelete: todo.compelete,
      ),
    );
    await getSavedTodo();
  }

  removeTodo(TodoModel todo) async {
    await todoCRUD.deleteTodo(code: todo.id);

    await getSavedTodo();
  }
}
