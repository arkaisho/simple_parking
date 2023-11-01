import 'package:get_it/get_it.dart';
import 'package:simple_parking/control/parking_store.dart';
import 'package:simple_parking/external/parking_datasource.dart';
import 'package:simple_parking/utils/dio_config.dart';

void setupGetIt() {
  //Stores
  GetIt.I.registerSingleton<ParkingStore>(
    ParkingStore(),
  );

  //Datasources
  GetIt.I.registerSingleton<ParkingDatasource>(
    ParkingDatasource(
      DioConfig().dio,
      baseUrl: DioConfig().baseurl,
    ),
  );
}
