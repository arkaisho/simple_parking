// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Floor _$FloorFromJson(Map<String, dynamic> json) => Floor(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      parkingSpaces: (json['parkingSpaces'] as List<dynamic>)
          .map((e) => ParkingSpace.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FloorToJson(Floor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'parkingSpaces': instance.parkingSpaces,
    };
