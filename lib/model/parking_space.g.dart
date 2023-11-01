// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSpace _$ParkingSpaceFromJson(Map<String, dynamic> json) => ParkingSpace(
      id: json['id'] as String,
      name: json['name'] as String,
      number: json['number'] as int,
      parkedVehicle: json['parkedVehicle'] == null
          ? null
          : Vehicle.fromJson(json['parkedVehicle'] as Map<String, dynamic>),
      currentVehicleEntryTime: json['currentVehicleEntryTime'] == null
          ? null
          : DateTime.parse(json['currentVehicleEntryTime'] as String),
      registers: (json['registers'] as List<dynamic>?)
              ?.map((e) => VehicleRegister.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ParkingSpaceToJson(ParkingSpace instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'number': instance.number,
      'parkedVehicle': instance.parkedVehicle,
      'currentVehicleEntryTime':
          instance.currentVehicleEntryTime?.toIso8601String(),
      'registers': instance.registers,
    };
