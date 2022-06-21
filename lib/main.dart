import 'package:flutter/material.dart';
import 'dateCirclePicker.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  CircleDatePickerController _controller =
      CircleDatePickerController(date: ValueNotifier(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date Picker",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 2.0,
            )),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[800],
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<DateTime>(
                valueListenable: _controller.date,
                builder: (context, date, _) {
                  return TextField(
                    controller: TextEditingController(text: "${_controller.date.value.day}/${_controller.date.value.month}/${_controller.date.value.year}"),
                    onTap: () => {
                      showModalBottomSheet(
                        barrierColor: Colors.transparent,
                        backgroundColor: Colors.white,
                        context: context, builder: (BuildContext context) {
                        return Container(
                          height: 400,
                          child: Padding(padding: EdgeInsets.all(20),
                          child: CircleDatePicker(
                              controller: _controller,
                            ),
                          ),
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 4
                              )
                            ] 
                        ),
                        );
                      })
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
