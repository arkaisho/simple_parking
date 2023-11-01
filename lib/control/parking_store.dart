import 'dart:io';
import 'package:csv/csv.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:simple_parking/external/parking_datasource.dart';
import 'package:simple_parking/model/floor.dart';
import 'package:simple_parking/model/parking_space.dart';
import 'package:simple_parking/model/vehicle.dart';
import 'package:simple_parking/model/vehicle_register.dart';
import 'package:simple_parking/utils/misc.dart';
import 'package:uuid/uuid.dart';

part 'parking_store.g.dart';

class ParkingStore = _ParkingStore with _$ParkingStore;

abstract class _ParkingStore with Store {
  @observable
  bool loadingFloors = false;

  @observable
  bool loadingCsv = false;

  @observable
  String searchFilter = "";

  @observable
  ObservableList<Floor> floors = ObservableList.of([]);

  @observable
  Floor? selectedFloor;

  @observable
  ParkingSpace? selectedParkingSpace;

  @action
  setSearchFilter(String value) {
    searchFilter = value;
  }

  @action
  setSelectedFloor(Floor? value) {
    selectedFloor = value;
  }

  @action
  setSelectedParkingSpace(ParkingSpace? value) {
    selectedParkingSpace = value;
  }

  @action
  addNewFloor({
    required Floor floor,
  }) {
    floors.add(floor);
  }

  @action
  addNewParkingSpace({
    required String floorId,
    required ParkingSpace space,
  }) {
    floors.where((floor) => floor.id == floorId).first.parkingSpaces.add(space);
  }

  @action
  deleteParkingSpace({
    required String floorId,
    required String spaceid,
  }) {
    floors
        .where((floor) => floor.id == floorId)
        .first
        .parkingSpaces
        .removeWhere((space) => space.id == spaceid);
  }

  @action
  deleteParkingFloor({
    required String floorId,
  }) {
    floors.removeWhere((floor) => floor.id == floorId);
  }

  @action
  getFloors() async {
    loadingFloors = true;
    try {
      List<Floor> response = await GetIt.I.get<ParkingDatasource>().getFloors();
      floors = ObservableList.of(response);
    } catch (e, s) {
      printException("$runtimeType.getFloors", e, s);
    }
    loadingFloors = false;
  }

  @action
  registerVehicleArrival({
    required String floorId,
    required String parkingSpaceId,
    required String plate,
  }) {
    int floorIndex = floors.indexWhere(
      (floor) => floorId == floor.id,
    );
    int spaceIndex = floors[floorIndex].parkingSpaces.indexWhere(
          (space) => parkingSpaceId == space.id,
        );

    ParkingSpace currentSpace = floors[floorIndex].parkingSpaces[spaceIndex];
    currentSpace.currentVehicleEntryTime = DateTime.now();
    currentSpace.parkedVehicle = Vehicle(
      id: const Uuid().v4(),
      plate: plate,
    );

    floors[floorIndex].parkingSpaces.removeAt(spaceIndex);
    floors[floorIndex].parkingSpaces.insert(spaceIndex, currentSpace);

    setSelectedFloor(floors[floorIndex]);
    setSelectedParkingSpace(floors[floorIndex].parkingSpaces[spaceIndex]);
  }

  @action
  registerVehicleDeparture({
    required String floorId,
    required String parkingSpaceId,
  }) {
    int floorIndex = floors.indexWhere(
      (floor) => floorId == floor.id,
    );
    int spaceIndex = floors[floorIndex].parkingSpaces.indexWhere(
          (space) => parkingSpaceId == space.id,
        );

    ParkingSpace currentSpace = floors[floorIndex].parkingSpaces[spaceIndex];

    currentSpace.registers.add(
      VehicleRegister(
        id: const Uuid().v4(),
        vehicle: selectedParkingSpace!.parkedVehicle!,
        entryTime: selectedParkingSpace?.currentVehicleEntryTime,
      ),
    );
    currentSpace.parkedVehicle = null;
    currentSpace.currentVehicleEntryTime = null;

    floors[floorIndex].parkingSpaces.removeAt(spaceIndex);
    floors[floorIndex].parkingSpaces.insert(spaceIndex, currentSpace);

    setSelectedFloor(floors[floorIndex]);
    setSelectedParkingSpace(floors[floorIndex].parkingSpaces[spaceIndex]);
  }

  @action
  Future<String?> exportAllRegisters() async {
    loadingCsv = true;
    try {
      List<List<dynamic>> rows = [];
      List<dynamic> row = [];
      row.add("pátio");
      row.add("vaga");
      row.add("placa");
      row.add("entrada");
      row.add("saida");
      rows.add(row);
      for (var floor in floors) {
        for (var space in floor.parkingSpaces) {
          for (var register in space.registers) {
            List<dynamic> row = [];
            row.add(floor.name);
            row.add(space.name);
            row.add(register.vehicle.plate);
            row.add(register.entryTime);
            row.add(register.departureTime);
            rows.add(row);
          }
        }
      }
      String path = await exportListToCsv(
        rows,
        filename: "registros-estacionamento",
      );
      showToast(
        text: "Arquivo exportado com sucesso",
      );
      return path;
    } catch (e, s) {
      printException("$runtimeType.getFloors", e, s);
      showToast(
        text: "Falha ao exportar arquivo",
        success: false,
      );
      return null;
    } finally {
      loadingCsv = false;
    }
  }

  @action
  exportSpaceRegisters({
    required List<VehicleRegister> registers,
    required String spaceName,
  }) async {
    loadingCsv = true;
    try {
      List<List<dynamic>> rows = [];
      List<dynamic> row = [];
      row.add("placa");
      row.add("entrada");
      row.add("saida");
      rows.add(row);
      for (var register in registers) {
        List<dynamic> row = [];
        row.add(register.vehicle.plate);
        row.add(register.entryTime);
        row.add(register.departureTime);
        rows.add(row);
      }
      String path = await exportListToCsv(
        rows,
        filename: "registros-estacionamento-$spaceName",
      );
      showToast(
        text: "Arquivo exportado com sucesso",
      );
      return path;
    } catch (e, s) {
      printException("$runtimeType.getFloors", e, s);
      showToast(
        text: "Falha ao exportar arquivo",
        success: false,
      );
      return null;
    } finally {
      loadingCsv = false;
    }
  }

  Future<String> exportListToCsv(
    List<List<dynamic>> rows, {
    String filename = "registros-estacionamento",
  }) async {
    String csv = const ListToCsvConverter().convert(rows);

    String dir = (await getDownloadPath())!;
    String file = dir;

    File f = File(
      "$file/$filename-${DateTime.now().millisecondsSinceEpoch}.csv",
    );

    f.writeAsString(csv);
    return f.path;
  }
}
