import 'package:flutter/material.dart';
import 'package:mafia_helper/Models/role.dart';

class RoleGenerator {
  static List<Role>? randomize(
      int playerCount, int mafiaCount, List<Role> otherRoles) {
    List<Role> roles = List.empty(growable: true);
    int civilianCount = playerCount - (mafiaCount + otherRoles.length);
    if (civilianCount <= 0 || (mafiaCount == 0 && otherRoles.isEmpty)) {
      return null;
    }
    for (var i = 1; i <= civilianCount; i++) {
      roles.add(Role(RoleType.civilian, null, null));
    }
    for (var i = 1; i <= mafiaCount; i++) {
      roles.add(Role(RoleType.mafia, Colors.pinkAccent.value, null));
    }
    roles.addAll(otherRoles);
    roles.shuffle();
    return roles;
  }

  static String shuffleMsg(List<Role> roles) {
    String mafiaMsg = "Мафия: ";
    String donMsg = "";
    String otherMsg = "";
    for (var i = 0; i < roles.length; i++) {
      int number = i + 1;
      if (roles[i].type == RoleType.civilian) {
        continue;
      } else if (roles[i].type == RoleType.mafia) {
        mafiaMsg += number.toString() + ", ";
      } else {
        if (roles[i].type == RoleType.don) {
          donMsg = "${roles[i].name} $number \n";
        } else {
          otherMsg += "${roles[i].name} $number \n";
        }
      }
    }
    return mafiaMsg.substring(0, mafiaMsg.length - 2) + "\n" + donMsg  + otherMsg;
  }

  static List<Role> getSelectedRoles(Map<String, bool> checkableRoles) {
    List<Role> list = List.empty(growable: true);
    checkableRoles.forEach((key, value) {
      if (value) {
        int? color;
        // String? name = key;
        RoleType? type;
        if (key == RoleType.comm.name) {
          color = Colors.blueAccent.value;
          type = RoleType.comm;
        }
        if (key == RoleType.don.name) {
          color = Colors.red.value;
          type = RoleType.don;
        }
        if (key == RoleType.doctor.name) {
          color = Colors.green.value;
          type = RoleType.doctor;
        }
        list.add(Role(type ?? RoleType.civilian, color, null));
      }
    });
    return list;
  }
}
