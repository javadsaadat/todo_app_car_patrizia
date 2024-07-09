import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  final Id id;
  final String code;
  final String title;
  final String categori;
  final String notes;
  final DateTime? alarm;
  final bool everyDay;
  final bool compelete;
  Todo({
    this.id = Isar.autoIncrement,
    required this.code,
    required this.title,
    required this.categori,
    required this.notes,
    this.alarm,
    required this.everyDay,
    required this.compelete,
  });
}
