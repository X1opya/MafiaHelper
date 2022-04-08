import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:mafia_helper/UICommon/bases_state.dart';

class TimerWidget extends StatefulWidget {
  TimerWidget({Key? key, this.startTime = 60}) : super(key: key);
  int startTime;
  @override
  State<StatefulWidget> createState() {
    return _TimerWidgetState();
  }
}

class _TimerWidgetState extends BaseState<TimerWidget> {
  int seconds = 0;

  Color timerColor = Colors.orange;

  @override
  void initState() {
    super.initState();
    seconds = widget.startTime;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
        children: [
      ArgonTimerButton(
        height: 40,
        width: 160,
        minWidth: 90,
        color: timerColor,
        borderRadius: 5.0,
        child: Text(
          "Запустить таймер | $seconds",
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
        ),
        loader: (timeLeft) {
          return Text(
            "$timeLeft",
            style: const TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          );
        },
        onTap: (startTimer, btnState) {
          setState(() {
            startTimer(seconds);
          });
        },
      ),
      IconButton(
          onPressed: () => {showPickerModal()},
          icon: const Icon(Icons.more_time_rounded))
    ]);
  }

  showPickerModal() {
    var list = generateSecondsList();
    var startIndex = list.indexOf(seconds);
    Picker(
        adapter: PickerDataAdapter<int>(pickerdata: list),
        changeToFirst: true,
        hideHeader: false,
        selecteds: [startIndex],
        confirmText: "Подтвердить",
        cancelText: "Отменить",
        onConfirm: (Picker picker, List value) {
          setState(() {
            seconds = int.tryParse(picker.adapter.text
                    .replaceAll("[", "")
                    .replaceAll(']', "")) ??
                0;
          });
        }).showModal(context);
  }

  List<int> generateSecondsList() {
    List<int> secondsParts = List.empty(growable: true);
    for (var i = 5; i <= 300; i += 5) {
      secondsParts.add(i);
    }
    return secondsParts;
  }
}
