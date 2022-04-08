
import 'package:mafia_helper/Models/prep_role.dart';
import 'package:mafia_helper/Models/role.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GameSettingsStorage {
  static const String playerCountKey = "_playerCountKey";
  static const String mafiaCountKey = "_mafiaCountKey";
  static const String otherRolesKey = "_otherRolesKey";

  static const String gameStartedKey = "gameStartedKey";
  static const String gameRolesKey = "gameRolesKey";

  static storeSettings(int playerCount, int mafiaCount, List<PrepRole> otherRoles) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(playerCountKey, playerCount);
    await prefs.setInt(mafiaCountKey, mafiaCount);
    String stringRoles = jsonEncode(otherRoles);
    print(stringRoles);
    print(otherRoles);
    await prefs.setString(otherRolesKey, stringRoles);
  }

  static setGameStarted(bool isStarted, [List<Role>? roles]) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(gameStartedKey, isStarted);

    print("setGameStarted = " + isStarted.toString());
    if (roles != null) {
      String stringRoles = jsonEncode(roles);
      prefs.setString(gameRolesKey, stringRoles);
    } else {
      prefs.setString(gameRolesKey, "");
    }
  }
}