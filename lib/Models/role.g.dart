// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      json['name'] as String,
      json['color'] as int?,
      json['icon'] as String?,
    )
      ..isVoting = json['isVoting'] as bool
      ..isDead = json['isDead'] as bool
      ..fallCount = json['fallCount'] as int;

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'icon': instance.icon,
      'isVoting': instance.isVoting,
      'isDead': instance.isDead,
      'fallCount': instance.fallCount,
    };
