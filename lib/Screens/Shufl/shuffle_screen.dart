import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mafia_helper/Analitics/analitics_event.dart';
import 'package:mafia_helper/Models/role.dart';
import 'package:mafia_helper/Screens/Game/game_screen.dart';
import 'package:mafia_helper/Analitics/Core/game_settings_storage.dart';
import 'package:mafia_helper/Screens/Shufl/Helpers/role_randomizer.dart';
import 'package:mafia_helper/Models/prep_role.dart';
import 'package:mafia_helper/UICommon/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UICommon/bases_state.dart';

class ShuffleScreen extends StatefulWidget {
  const ShuffleScreen({Key? key}) : super(key: key);

  static const routeName = "/";

  @override
  ShuffleScreenState createState() {
    return ShuffleScreenState();
  }
}

class ShuffleScreenState extends BaseState<ShuffleScreen> {
  final Map<String, bool> _roles = {
    RoleType.comm.name: false,
    RoleType.don.name: false,
    RoleType.doctor.name: false
  };
  final _playerCountController = TextEditingController();
  final _mafiaCountController = TextEditingController();

  int get _playerCount => int.tryParse(_playerCountController.text) ?? 0;

  int get _mafiaCount => int.tryParse(_mafiaCountController.text) ?? 0;

  List<PrepRole> get _otherRoles => RoleGenerator.getSelectedRoles(_roles);

  @override
  void initState() {
    _getStoredSettings();
    super.initState();
  }

  _getStoredSettings() async {
    final prefs = await SharedPreferences.getInstance();
    bool isStarted = prefs.getBool(GameSettingsStorage.gameStartedKey) ?? false;
    if (isStarted) {
      Navigator.pushReplacementNamed(context, GameScreen.routeName);
      return;
    }
    _mafiaCountController.text =
        prefs.getInt(GameSettingsStorage.mafiaCountKey)?.toString() ?? "";
    _playerCountController.text =
        prefs.getInt(GameSettingsStorage.playerCountKey)?.toString() ?? "";
    String? strRoles = prefs.getString(GameSettingsStorage.otherRolesKey);
    if (strRoles == null) return;
    List<PrepRole> roles = PrepRole.fromJsonList(strRoles);
    for (var element in roles) {
      setState(() {
        _roles[element.type.name] = true;
      });
    }
  }

  _showShuffleDialog() {
    FirebaseAnalytics.instance.logEvent(name: AnalyticEvent.shuffle.name);
    List<PrepRole>? roles =
        RoleGenerator.randomize(_playerCount, _mafiaCount, _otherRoles);
    if (roles == null) {
      return;
    }
    GameSettingsStorage.storeSettings(_playerCount, _mafiaCount, _otherRoles);
    String rolesMsg = RoleGenerator.shuffleMsg(roles);
    showMaterialDialog(
        title: "Вот так вот",
        subTitle: rolesMsg,
        leftActionText: "Решафл",
        rightActionText: "Принять",
        rightAction: () => {_routToGameScreen(roles)},
        leftAction: () => {_reshuffle()});
  }

  _routToGameScreen(List<PrepRole> list) {
    FirebaseAnalytics.instance.logEvent(name: AnalyticEvent.startGame.name);
    dismissDialog();
    GameSettingsStorage.setGameStarted(true, list.map<Role>((e) => Role(e.name, e.color, e.icon)).toList());
    Navigator.pushReplacementNamed(context, GameScreen.routeName);
  }

  _reshuffle() {
    dismissDialog();
    _showShuffleDialog();
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
                            decoration: const InputDecoration(
                                hintText: "Кол-во игроков"),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          ),
                          TextField(
                            controller: _mafiaCountController,
                            decoration:
                                const InputDecoration(hintText: "Кол-во мафии"),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          ),
                          const Text("Роли",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: _roles.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  title: Text(_roles.keys.elementAt(index)),
                                  value: _roles.values.elementAt(index),
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      _roles[_roles.keys.elementAt(index)] =
                                          newValue ?? false;
                                    });
                                  },
                                );
                              }),
                          ElevatedButton(
                            onPressed: () => {_showShuffleDialog()},
                            child: const Text("Шафлить"),
                            style: ElevatedButton.styleFrom(
                                fixedSize:
                                    const Size.fromWidth(double.maxFinite)),
                          )
                        ])))));
  }
}
