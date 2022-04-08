import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mafia_helper/Models/role.dart';
import 'package:mafia_helper/Screens/Game/Widgets/role_list_widget.dart';
import 'package:mafia_helper/Screens/Game/Widgets/timer_widget.dart';
import 'package:mafia_helper/Screens/Shufl/shuffle_screen.dart';
import 'package:mafia_helper/UICommon/bases_state.dart';
import 'package:mafia_helper/Analitics/Core/game_settings_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Analitics/analitics_event.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  static const routeName = "/game";

  // final bool isGameStarted;

  @override
  State<StatefulWidget> createState() {
    return GameScreenState();
  }
}

class GameScreenState extends BaseState<GameScreen> {
  Future<List<Role>> getList(BuildContext context) async {
    List<Role> roles;
    try {
      final prefs = await SharedPreferences.getInstance();
      roles = Role.fromJsonList(
          prefs.getString(GameSettingsStorage.gameRolesKey) ?? "");
    } catch (e) {
      _closeGame();
      roles = List.empty();
    }
    return roles;
  }

  _closeGame() {
    FirebaseAnalytics.instance.logEvent(name: AnalyticEvent.endGame.name);
    dismissDialog();
    GameSettingsStorage.setGameStarted(false, null);
    Navigator.pushReplacementNamed(context, ShuffleScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getList(context),
        initialData: List<Role>.empty(),
        builder: (BuildContext context, AsyncSnapshot<List<Role>> roles) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(''),
              leading: IconButton(
                icon: const Icon(Icons.clear_sharp),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  showMaterialDialog(
                      title: "Закончить текущую игру?",
                      leftActionText: "Отменить",
                      rightActionText: "Закончить",
                      leftAction: () => {dismissDialog()},
                      rightAction: () => {_closeGame()});
                },
              ),
            ),
            // drawer: Drawer(),
            body: SingleChildScrollView(
                child: Center(
                    child: Column(
              children: [
                const SizedBox(height: 6),
                TimerWidget(),
                const SizedBox(height: 6),
                TimerWidget(startTime: 30),
                const SizedBox(height: 6),
                RoleListWidget(roles: roles.requireData),
              ],
            ))),
          );
        });
  }
}
