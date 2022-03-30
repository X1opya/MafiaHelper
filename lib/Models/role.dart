import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
class Role {
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

  Role.custom(String name, this.color, this.icon) {
    type = RoleType.other;
    _name = name;
  }

  Role(this.type, this.color, this.icon);

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
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

  set name(String name) {}
}
