import 'dart:math';
import 'package:flutter/material.dart';
import 'circlePicker.dart';

class CircleDatePickerController {
  CircleDatePickerController({
    required this.date,
  });

  ValueNotifier<DateTime> date;
}

class CircleDatePicker extends StatefulWidget {
  const CircleDatePicker({
    Key? key,
    this.controller
    }) : super(key: key);

final CircleDatePickerController? controller;

@override
  _CircleDatePicker createState() => _CircleDatePicker();
}

class _CircleDatePicker extends State<CircleDatePicker> with TickerProviderStateMixin {

  var degreeController = CircleDegreePickerController(degree: 0.0);
  bool shouldChangeYear = true;
  double lastDegree = 0.0;

  @override
  Widget build(BuildContext context) {
      return AnimatedBuilder(animation: degreeController, builder: (context, _) {
          return CircleDegreePicker(
          onDegreeChange: onDegreeChange,
          controller: degreeController,
          child: (
            Center(child:
              Image(
                image: AssetImage('images/sun.png'), 
                width: 50, 
                height: 50
              )
            )
          ),
        );
      });
  }

  void onDegreeChange(double degree) {
    degreeController.degree = degree;
    if (widget.controller != null) {
      DateTime currentDate = widget.controller!.date.value;
      int currentYear = currentDate.year;

      if (degree > 358 && lastDegree <= 2) {
        currentYear --;
      } else if (degree < 2 && lastDegree >= 358) {
        currentYear ++;
      }

      int allDays = 365;
      if (_leapYear(currentYear)) {
        allDays = 366;
      }

      double ratio = 360 / allDays;

      int days = (ratio * degree).round();

      DateTime newDate = DateTime(currentYear, 1, 1);
      newDate = newDate.add(Duration(days: days));

      widget.controller?.date.value = newDate;
    }
    lastDegree = degree;
  }

  bool _leapYear(int year) {
    bool leapYear = false;
    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }
}