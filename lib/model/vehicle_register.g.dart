// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleRegister _$VehicleRegisterFromJson(Map<String, dynamic> json) =>
    VehicleRegister(
      id: json['id'] as String,
      vehicle: Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
      entryTime: json['entryTime'] == null
          ? null
          : DateTime.parse(json['entryTime'] as String),
      departureTime: json['departureTime'] == null
          ? null
          : DateTime.parse(json['departureTime'] as String),
    );

Map<String, dynamic> _$VehicleRegisterToJson(VehicleRegister instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicle': instance.vehicle,
      'entryTime': instance.entryTime?.toIso8601String(),
      'departureTime': instance.departureTime?.toIso8601String(),
    };
