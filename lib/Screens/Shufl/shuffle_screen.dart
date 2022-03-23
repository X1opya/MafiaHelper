import 'package:flutter/material.dart';
import 'package:mafia_helper/role.dart';
import 'package:mafia_helper/UICommon/app_color.dart';

import '../../UICommon/bases_state.dart';

class ShuffleScreen extends StatefulWidget {
  const ShuffleScreen({Key? key}) : super(key: key);

  @override
  ShuffleScreenState createState() {
    return ShuffleScreenState();
  }
}

class ShuffleScreenState extends BaseState<ShuffleScreen> {
  final Map<String, bool> _rolles = {
    "Комисар": false,
    "Дон Мафии": false,
    "Доктор": false
  };
  final _playerCountController = TextEditingController();
  final _mafiaCountController = TextEditingController();

  int get playerCount => int.tryParse(_playerCountController.text) ?? 0;

  int get mafiaCount => int.tryParse(_mafiaCountController.text) ?? 0;

  List<Role> get otherRoles => _getSelectedRoles();

  List<Role> _getSelectedRoles() {
    List<Role> list = List.empty();
    _rolles.forEach((key, value) {
      String? name;
      Color? color;
      name = key;
      if (key == "Комисар") {
        color = Colors.red;
      }
      if (key == "Дон Мафии") {
        color = Colors.blueAccent;
      }
      if (key == "Доктор") {
        color = Colors.green;
      }
      list.add(Role(name, color, null));
    });
    return list;
  }

  showShuffleDialog() {
    showMaterialDialog(title: "asdadad", leftActionText: "left", rightActionText: "right", leftAction: () => {
      dismissDialog()
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(6),
            child: Card(
                color: AppColor.primary,
                elevation: 8,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Wrap(
                        runSpacing: 14,
                        alignment: WrapAlignment.center,
                        children: [
                          const Text("Регнуть игру",
                              style: TextStyle(
                                  fontSize: 33, fontWeight: FontWeight.bold)),
                          TextField(
                            controller: _playerCountController,
                            decoration:
                                const InputDecoration(hintText: "Кол-во игроков"),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            controller: _mafiaCountController,
                            decoration:
                                const InputDecoration(hintText: "Кол-во мафии"),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          ),
                          const Text("Роли",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: _rolles.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  title: Text(_rolles.keys.elementAt(index)),
                                  value: _rolles.values.elementAt(index),
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _rolles[_rolles.keys.elementAt(index)] =
                                          newValue ?? false;
                                    });
                                  },
                                );
                              }),
                          ElevatedButton(
                            onPressed: () => {showShuffleDialog()},
                            child: const Text("Шафлить"),
                            style: ElevatedButton.styleFrom(
                                fixedSize:
                                    const Size.fromWidth(double.maxFinite)),
                          )
                        ])))));
  }
}
