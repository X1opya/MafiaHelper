// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prep_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrepRole _$PrepRoleFromJson(Map<String, dynamic> json) => PrepRole(
      $enumDecode(_$RoleTypeEnumMap, json['type']),
      json['color'] as int?,
      json['icon'] as String?,
    );

Map<String, dynamic> _$PrepRoleToJson(PrepRole instance) => <String, dynamic>{
      'color': instance.color,
      'icon': instance.icon,
      'type': _$RoleTypeEnumMap[instance.type],
    };

const _$RoleTypeEnumMap = {
  RoleType.civilian: 'civilian',
  RoleType.mafia: 'mafia',
  RoleType.don: 'don',
  RoleType.comm: 'comm',
  RoleType.doctor: 'doctor',
  RoleType.other: 'other',
};
