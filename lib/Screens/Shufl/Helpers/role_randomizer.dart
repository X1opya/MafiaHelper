import 'package:flutter/material.dart';
import 'package:mafia_helper/Models/prep_role.dart';
import 'package:mafia_helper/UICommon/app_color.dart';

class RoleGenerator {
  static List<PrepRole>? randomize(
      int playerCount, int mafiaCount, List<PrepRole> otherRoles) {
    List<PrepRole> roles = List.empty(growable: true);
    int civilianCount = playerCount - (mafiaCount + otherRoles.length);
    if (civilianCount <= 0 || (mafiaCount == 0 && otherRoles.isEmpty)) {
      return null;
    }
    for (var i = 1; i <= civilianCount; i++) {
      roles.add(PrepRole(RoleType.civilian, Colors.white.value, null));
    }
    for (var i = 1; i <= mafiaCount; i++) {
      roles.add(PrepRole(RoleType.mafia, AppColor.maf.value, null));
    }
    roles.addAll(otherRoles);
    roles.shuffle();
    return roles;
  }

  static String shuffleMsg(List<PrepRole> roles) {
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

  static List<PrepRole> getSelectedRoles(Map<String, bool> checkableRoles) {
    List<PrepRole> list = List.empty(growable: true);
    checkableRoles.forEach((key, value) {
      if (value) {
        int? color;
        // String? name = key;
        RoleType? type;
        if (key == RoleType.comm.name) {
          color = AppColor.com.value;
          type = RoleType.comm;
        }
        if (key == RoleType.don.name) {
          color = AppColor.don.value;
          type = RoleType.don;
        }
        if (key == RoleType.doctor.name) {
          color = AppColor.doc.value;
          type = RoleType.doctor;
        }
        list.add(PrepRole(type ?? RoleType.civilian, color, null));
      }
    });
    return list;
  }
}
