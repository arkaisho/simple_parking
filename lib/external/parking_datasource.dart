import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:simple_parking/model/floor.dart';

part "parking_datasource.g.dart";

@RestApi()
abstract class ParkingDatasource {
  factory ParkingDatasource(Dio dio, {String baseUrl}) = _ParkingDatasource;

  @GET("/floors")
  Future<List<Floor>> getFloors();
}
