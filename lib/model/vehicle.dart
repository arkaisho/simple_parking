import 'package:json_annotation/json_annotation.dart';

part "vehicle.g.dart";

@JsonSerializable()
class Vehicle {
  String id;
  String plate;

  Vehicle({
    required this.id,
    required this.plate,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
