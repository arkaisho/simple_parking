import 'package:json_annotation/json_annotation.dart';
import 'package:simple_parking/model/vehicle.dart';

part "vehicle_register.g.dart";

@JsonSerializable()
class VehicleRegister {
  String id;
  Vehicle vehicle;
  DateTime? entryTime;
  DateTime? departureTime;

  VehicleRegister({
    required this.id,
    required this.vehicle,
    DateTime? entryTime,
    DateTime? departureTime,
  }) {
    if (entryTime == null) {
      this.entryTime = DateTime.now();
    } else {
      this.entryTime = entryTime;
    }
    if (departureTime == null) {
      this.departureTime = DateTime.now();
    } else {
      this.departureTime = departureTime;
    }
  }

  factory VehicleRegister.fromJson(Map<String, dynamic> json) =>
      _$VehicleRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleRegisterToJson(this);
}
