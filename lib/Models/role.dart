import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'role.g.dart';

@JsonSerializable()
class Role {
  String name;
  int? color;
  String? icon;
  bool isVoting = false;
  bool isDead = false;
  int fallCount = 0;

  Role(this.name, this.color, this.icon);

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  static List<Role> fromJsonList(String json) {
    List<dynamic> objects = jsonDecode(json);
    List<Role> roles = objects.map((e) => Role.fromJson(e)).toList();
    return roles;
  }

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}