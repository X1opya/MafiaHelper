import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mafia_helper/Models/role.dart';
import 'package:mafia_helper/UICommon/app_color.dart';
import 'package:mafia_helper/UICommon/bases_state.dart';

class RoleCellWidget extends StatefulWidget {
  @override
  RoleCellWidget({Key? key, required this.role, required this.number})
      : super(key: key);

  Role role;
  int number;

  State<StatefulWidget> createState() {
    return _RoleCellWidgetState();
  }
}

class _RoleCellWidgetState extends BaseState<RoleCellWidget> {
  bool _hasFall = false;

  _addFall(int count) {
    setState(() {
      print("_addFall " + count.toString());
      widget.role.fallCount += count;
      _hasFall = widget.role.fallCount != 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.primary,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                shape: BoxShape.circle,
                color: Color(widget.role.color ?? Colors.transparent.value),
              ),
              child: Center(
                child: Text(
                  widget.number.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(widget.role.name.substring(0, 3)),
            const SizedBox(width: 10),
            if (!_hasFall) ...[
              const SizedBox(width: 12),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 6), minimumSize: const Size.square(20)),
                  child: const Text("Фол"),
                  onPressed: () => {_addFall(1)})
            ] else ...[
              ElevatedButton(
                  child: const Text("-"),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10), minimumSize: const Size.square(20)),
                  onPressed: () => {_addFall(-1)}),
              const SizedBox(width: 6),
              Text(widget.role.fallCount.toString()),
              const SizedBox(width: 6),
              ElevatedButton(
                  child: const Text("+"),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10), minimumSize: const Size.square(20)),
                  onPressed: () => {_addFall(1)}),
            ]
          ])),
    );
  }
}
