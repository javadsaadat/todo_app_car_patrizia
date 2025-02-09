import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:todo_app_car_patrizia/core/utils/geter_and_func.dart';
import 'package:todo_app_car_patrizia/cubit/days_of_mount/days_of_mount_cubit.dart';
import 'package:todo_app_car_patrizia/model/day_mount.dart';
import 'package:todo_app_car_patrizia/screens/general_widgets/day_of_mount.dart';

class SevenDayToday extends StatefulWidget {
  const SevenDayToday({super.key});

  @override
  State<SevenDayToday> createState() => _SevenDayTodayState();
}

class _SevenDayTodayState extends State<SevenDayToday> {
  ScrollController scrollController = ScrollController();
  autoScrollListViewOnDayNow() {
    List<DayMount> dayOfMount =
        BlocProvider.of<DaysOfMountCubit>(context).state.days;
    final widthItem =
        scrollController.position.maxScrollExtent / dayOfMount.length;
    int activeDay = 0;
    for (var i = 0; i < dayOfMount.length; i++) {
      if (dayOfMount[i].date == Jalali.now()) {
        activeDay = i;
      }
    }
    scrollController.animateTo(activeDay * widthItem,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ////like onload metoud
      autoScrollListViewOnDayNow();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: const Color(0xFF454642).withOpacity(0.7)),
      width: mediaQ(context).size.width,
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: BlocBuilder<DaysOfMountCubit, DaysOfMountState>(
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: state.days.length,
              itemBuilder: (context, index) {
                DayMount dayMount = state.days[index];
                List<String> textDate =
                    dayMount.date.formatFullDate().split(" ");
                return Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: DayOfMount(
                    numDay: dayMount.date.day.toString(),
                    weekday: textDate.length > 4
                        ? "${textDate[0]} ${textDate[1]}"
                        : textDate[0],
                    bgColor: dayMount.bgColor,
                    fgColor: dayMount.fgColor,
                    width: 55,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
