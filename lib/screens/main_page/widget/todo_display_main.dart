import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:todo_app_car_patrizia/core/global/theme/color_theme.dart';
import 'package:todo_app_car_patrizia/core/utils/app_string.dart';
import 'package:todo_app_car_patrizia/core/utils/geter_and_func.dart';
import 'package:todo_app_car_patrizia/cubit/list_todo/list_todo_cubit.dart';
import 'package:todo_app_car_patrizia/model/todo.dart';
import 'package:todo_app_car_patrizia/screens/new_task/new_task.dart';

class TodoDisplayMain extends StatelessWidget {
  final TodoModel todo;
  const TodoDisplayMain({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onEdit() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewTask(
            todoModel: todo,
          ),
        ),
      );
    }

    return Dismissible(
      key: ValueKey(todo),
      onDismissed: (direction) {
        BlocProvider.of<ListTodoCubit>(context).removeTodo(todo);
      },
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 19.0),
          child: Container(
            width: mediaQ(context).size.width * 0.89,
            height: 85,
            decoration: BoxDecoration(
              color: ColorTheme.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  child: Checkbox(
                    value: todo.compelete,
                    onChanged: (value) {
                      BlocProvider.of<ListTodoCubit>(context)
                          .addTodo(todo.copyWith(compelete: !todo.compelete));
                    },
                    splashRadius: 50,
                    activeColor: ColorTheme.azalea,
                    shape: const CircleBorder(),
                    side: BorderSide(color: ColorTheme.azalea, width: 4),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      todo.alarm != null ? todo.alarm!.formatFullDate() : "",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorTheme.dustyGray,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                    SizedBox(
                      width: 190,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "${todo.title}${(todo.title.isNotEmpty && todo.categori.isNotEmpty) ? " _ " : ""}${todo.categori}",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 190,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          todo.notes,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: ColorTheme.dustyGray,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    TextButton(
                        onPressed: onEdit,
                        child: Text(
                          AppString.edit,
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                    todo.alarm != null
                        ? const Icon(
                            Icons.notifications,
                            size: 20,
                          )
                        : const SizedBox(),
                  ],
                ),
                Container(
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/car_wallpaper.jpg",
                        ),
                      ),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(50))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
