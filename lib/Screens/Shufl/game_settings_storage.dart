
import 'package:mafia_helper/Models/role.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GameSettingsStorage {
  static const String playerCountKey = "_playerCountKey";
  static const String mafiaCountKey = "_mafiaCountKey";
  static const String otherRolesKey = "_otherRolesKey";

  static storeSettings(int playerCount, int mafiaCount, List<Role> otherRoles) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(playerCountKey, playerCount);
    await prefs.setInt(mafiaCountKey, mafiaCount);
    String stringRoles = jsonEncode(otherRoles);
    print(stringRoles);
    print(otherRoles);
    await prefs.setString(otherRolesKey, stringRoles);
  }
}