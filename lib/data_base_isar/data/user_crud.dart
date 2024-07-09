import 'dart:io';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app_car_patrizia/data_base_isar/model/todo.dart';

class TodoCRUD {
  Directory? dir;
  Isar? isar;

  Future initialDatabase() async {
    if (isar == null || !(isar!.isOpen)) {
      dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [TodoSchema],
        directory: dir!.path,
      );
    }
  }

  closeDatabase() async {
    await isar?.close();
  }

  Future<void> writeTodo({required Todo todo}) async {
    try {
      await initialDatabase();

      final Todo newTodo;
      final Todo? findTodo =
          await isar?.todos.filter().codeEqualTo(todo.code).findFirst();

      if (findTodo != null) {
        newTodo = Todo(
            id: findTodo.id,
            alarm: todo.alarm,
            code: todo.code,
            title: todo.title,
            categori: todo.categori,
            notes: todo.notes,
            everyDay: todo.everyDay,
            compelete: todo.compelete);
      } else {
        newTodo = todo;
      }

      await isar?.writeTxn(() async {
        await isar?.todos.put(newTodo);
      });
    } catch (e) {
      debugPrint('  writeTodo  خطا در انجام عملیات: $e');
    } finally {
      await closeDatabase();
    }
  }

  Future<List<Todo?>> readAllTodo() async {
    late final List<Todo?>? todos;

    try {
      await initialDatabase();
      todos = await isar?.todos.where().findAll();
    } catch (e) {
      debugPrint('  readAllTodo  خطا در انجام عملیات: $e');
    } finally {
      await closeDatabase();
    }

    return todos ?? [];
  }

  Future<Todo?> readTodoWithId({required int id}) async {
    late final Todo? todo;

    try {
      await initialDatabase();
      todo = await isar?.todos.get(id);
    } catch (e) {
      debugPrint(' readTodoWithId  خطا در انجام عملیات: $e');
    } finally {
      await closeDatabase();
    }

    return todo;
  }

  Future<Todo?> readTodoWithCode({required String code}) async {
    late final Todo? todo;

    try {
      await initialDatabase();
      todo = await isar?.todos.filter().codeEqualTo(code).findFirst();
    } catch (e) {
      debugPrint('readTodoWithCode  خطا در انجام عملیات: $e');
    } finally {
      await closeDatabase();
    }

    return todo;
  }

  Future<void> deleteTodo({required final String code}) async {
    debugPrint(
        "++++++++ deleteTodo findTodo ${(await readAllTodo()).any((e) => e?.code == code)}");
    debugPrint("++++++++ isar  $code");
    try {
      await initialDatabase();

      final Todo? findTodo =
          await isar?.todos.filter().codeEqualTo(code).findFirst();

      if (findTodo != null) {
        await isar?.writeTxn(() async {
          await isar?.todos.delete(findTodo.id);
        });
      } else {
        debugPrint("item not found for delete");
      }
    } catch (e) {
      debugPrint(' deleteTodo خطا در انجام عملیات: $e');
    } finally {
      await closeDatabase();
    }
  }
}
