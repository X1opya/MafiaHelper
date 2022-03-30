// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      $enumDecode(_$RoleTypeEnumMap, json['type']),
      json['color'] as int?,
      json['icon'] as String?,
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
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
