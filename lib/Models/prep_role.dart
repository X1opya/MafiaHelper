import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'prep_role.g.dart';

@JsonSerializable()
class PrepRole {
  String get name {
    if (type.name.isEmpty) {
      return _name;
    } else {
      return type.name;
    }
  }

  int? color;
  String? icon;
  RoleType type = RoleType.civilian;

  String _name = "";

  PrepRole.custom(String name, this.color, this.icon) {
    type = RoleType.other;
    _name = name;
  }

  PrepRole(this.type, this.color, this.icon);

  factory PrepRole.fromJson(Map<String, dynamic> json) => _$PrepRoleFromJson(json);

  static List<PrepRole> fromJsonList(String json) {
    List<dynamic> objects = jsonDecode(json);
    List<PrepRole> roles = objects.map((e) => PrepRole.fromJson(e)).toList();
    return roles;
  }

  Map<String, dynamic> toJson() => _$PrepRoleToJson(this);
}

enum RoleType { civilian, mafia, don, comm, doctor, other }

extension RoleTypeExtension on RoleType {
  String get name {
    switch (this) {
      case RoleType.civilian:
        return "Мирный";
      case RoleType.mafia:
        return "Мафия";
      case RoleType.don:
        return "Дон мафии";
      case RoleType.comm:
        return "Комиссар";
      case RoleType.doctor:
        return "Доктор";
      default:
        return "";
    }
  }
}
