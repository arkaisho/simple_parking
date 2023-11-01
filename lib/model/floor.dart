import 'package:json_annotation/json_annotation.dart';
import 'package:simple_parking/model/parking_space.dart';

part "floor.g.dart";

@JsonSerializable()
class Floor {
  String id;
  String name;
  String code;
  List<ParkingSpace> parkingSpaces;

  Floor({
    required this.id,
    required this.name,
    required this.code,
    required this.parkingSpaces,
  });

  factory Floor.fromJson(Map<String, dynamic> json) => _$FloorFromJson(json);

  Map<String, dynamic> toJson() => _$FloorToJson(this);
}
