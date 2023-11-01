import 'package:json_annotation/json_annotation.dart';
import 'package:simple_parking/model/vehicle.dart';
import 'package:simple_parking/model/vehicle_register.dart';

part "parking_space.g.dart";

@JsonSerializable()
class ParkingSpace {
  String id;
  String name;
  int number;
  Vehicle? parkedVehicle;
  DateTime? currentVehicleEntryTime;
  List<VehicleRegister> registers;

  ParkingSpace({
    required this.id,
    required this.name,
    required this.number,
    this.parkedVehicle,
    this.currentVehicleEntryTime,
    this.registers = const [],
  });

  factory ParkingSpace.fromJson(Map<String, dynamic> json) =>
      _$ParkingSpaceFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingSpaceToJson(this);

  ParkingSpaceStatus get status {
    return parkedVehicle != null
        ? ParkingSpaceStatus.filled
        : ParkingSpaceStatus.vague;
  }
}

enum ParkingSpaceStatus { filled, vague }
