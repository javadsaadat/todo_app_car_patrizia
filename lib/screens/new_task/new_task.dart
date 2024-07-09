import 'package:flutter/material.dart';
import 'package:todo_app_car_patrizia/core/utils/app_string.dart';
import 'package:todo_app_car_patrizia/core/utils/geter_and_func.dart';
import 'package:todo_app_car_patrizia/model/todo.dart';
import 'package:todo_app_car_patrizia/screens/general_widgets/main_appbar.dart';
import 'package:todo_app_car_patrizia/screens/new_task/widget/display_date.dart';
import 'package:todo_app_car_patrizia/screens/new_task/widget/form_add_todo.dart';

class NewTask extends StatelessWidget {
  final TodoModel? todoModel;
  const NewTask({
    Key? key,
    this.todoModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MainAppbar(
        title: todoModel == null ? AppString.newTask : AppString.edit,
        isMain: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DisplayDate(),
            Padding(
              padding: EdgeInsets.only(
                bottom: mediaQ(context).viewInsets.bottom,
              ),
              child: FormAddTodo(
                todoModel: todoModel,
              ),
            )
          ],
        ),
      ),
    );
  }
}
