// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class TodoModel {
  final String id;
  final String title;
  final String categori;
  final String notes;
  final Jalali? alarm;
  final bool everyDay;
  final bool compelete;
  TodoModel({
    String? id,
    required this.categori,
    required this.title,
    required this.notes,
    required this.alarm,
    required this.everyDay,
    required this.compelete,
  }) : id = id ?? uuid.v4();

  TodoModel copyWith({
    String? id,
    String? title,
    String? categori,
    String? notes,
    Jalali? alarm,
    bool? everyDay,
    bool? compelete,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      categori: categori ?? this.categori,
      notes: notes ?? this.notes,
      alarm: alarm ?? this.alarm,
      everyDay: everyDay ?? this.everyDay,
      compelete: compelete ?? this.compelete,
    );
  }
}
