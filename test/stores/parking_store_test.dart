import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_parking/control/parking_store.dart';
import 'package:simple_parking/model/floor.dart';
import 'package:simple_parking/model/parking_space.dart';
import 'package:simple_parking/utils/setup_get_it.dart';
import 'package:uuid/uuid.dart';

void main() {
  setUp(() async {
    setupGetIt();
    ParkingStore parkingStore = GetIt.I.get<ParkingStore>();
    await parkingStore.getFloors();
  });

  tearDown(() {
    GetIt.I.reset();
  });

  test(
    'Deve recuperar as informações de pisos do banco de dados',
    () async {
      ParkingStore parkingStore = GetIt.I.get<ParkingStore>();
      expect(parkingStore.floors.isNotEmpty, true);
    },
  );
  test(
    "Deve adicionar um novo piso a lista de pisos da store",
    () async {
      ParkingStore parkingStore = GetIt.I.get<ParkingStore>();
      var newFloorId = const Uuid().v4();
      parkingStore.addNewFloor(
        floor: floorMock(newFloorId),
      );
      expect(parkingStore.floors.any((floor) => floor.id == newFloorId), true);
    },
  );
  test(
    "Deve remover um piso da lista de pisos da store",
    () async {
      ParkingStore parkingStore = GetIt.I.get<ParkingStore>();
      String floorId = parkingStore.floors.first.id;
      parkingStore.deleteParkingFloor(floorId: floorId);
      expect(parkingStore.floors.any((floor) => floor.id == floorId), false);
    },
  );

  test(
    "Deve adicionar um novo epaço a lista de espaços de um piso",
    () async {
      ParkingStore parkingStore = GetIt.I.get<ParkingStore>();
      String floorId = parkingStore.floors.first.id;
      String newSpaceId = const Uuid().v4();
      parkingStore.addNewParkingSpace(
        floorId: floorId,
        space: spaceMock(newSpaceId),
      );
      expect(
        parkingStore.floors
            .firstWhere((floor) => floor.id == floorId)
            .parkingSpaces
            .any(
              (space) => space.id == newSpaceId,
            ),
        true,
      );
    },
  );
  test(
    "Deve remover um espaço da lista de espaços de um piso",
    () async {
      ParkingStore parkingStore = GetIt.I.get<ParkingStore>();
      String floorId = parkingStore.floors.first.id;
      parkingStore.deleteParkingFloor(floorId: floorId);
      expect(parkingStore.floors.any((floor) => floor.id == floorId), false);
    },
  );
  test(
    "Deve criar um arquivo contendo os registros de um espaço de estacionamento",
    () async {
      setupTestPathProviderMethodChannel();
      ParkingStore parkingStore = GetIt.I.get<ParkingStore>();
      Floor floor = getPopulatedFloor(parkingStore);
      ParkingSpace space = getPopulatedSpace(floor);
      String? path;
      path = await parkingStore.exportSpaceRegisters(
        spaceName: space.name ?? "${floor.code}${space.number}",
        registers: space.registers,
      );

      expect(path != null, true);
      expect(path?.isNotEmpty, true);
    },
  );
  test(
    "Deve criar um arquivo contendo todos registros de todos os espaços de estacionamento",
    () async {
      setupTestPathProviderMethodChannel();
      ParkingStore parkingStore = GetIt.I.get<ParkingStore>();
      String? path = await parkingStore.exportAllRegisters();
      expect(path != null, true);
      expect(path?.isNotEmpty, true);
    },
  );
  test(
    "Deve registrar corretamente a entrada de um veículo no espaço do estacionamento",
    () async {
      ParkingStore parkingStore = GetIt.I.get<ParkingStore>();
      Floor floor = getPopulatedFloor(parkingStore);
      ParkingSpace space = getPopulatedSpace(floor);
      int beforeArrivalRegistersLenght = space.registers.length;
      parkingStore.registerVehicleArrival(
        floorId: floor.id,
        parkingSpaceId: space.id,
        plate: "ABCD1234",
      );
      expect(
        parkingStore.selectedParkingSpace!.registers.length,
        beforeArrivalRegistersLenght,
      );
      expect(
        parkingStore.selectedParkingSpace!.parkedVehicle != null,
        true,
      );
      expect(
        parkingStore.selectedParkingSpace!.currentVehicleEntryTime != null,
        true,
      );
    },
  );

  test(
    "Deve registrar corretamente a entrada e saída de um veículo no espaço do estacionamento",
    () async {
      setupTestPathProviderMethodChannel();
      ParkingStore parkingStore = GetIt.I.get<ParkingStore>();
      Floor floor = getPopulatedFloor(parkingStore);
      ParkingSpace space = getPopulatedSpace(floor);
      int beforeArrivalRegistersLenght = space.registers.length;
      parkingStore.registerVehicleArrival(
        floorId: floor.id,
        parkingSpaceId: space.id,
        plate: "ABCD1234",
      );
      parkingStore.registerVehicleDeparture(
        floorId: floor.id,
        parkingSpaceId: space.id,
      );
      expect(
        parkingStore.selectedParkingSpace!.registers.length,
        beforeArrivalRegistersLenght + 1,
      );
      expect(
        parkingStore.selectedParkingSpace!.parkedVehicle,
        null,
      );
      expect(
        parkingStore.selectedParkingSpace!.currentVehicleEntryTime,
        null,
      );
    },
  );
}

setupTestPathProviderMethodChannel() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (MethodCall methodCall) async {
    return './test-files/';
  });
}

ParkingSpace getPopulatedSpace(Floor floor) {
  return floor.parkingSpaces.firstWhere(
    (space) => space.registers.isNotEmpty,
    orElse: () => spaceMock(
      const Uuid().v4(),
    ),
  );
}

Floor getPopulatedFloor(ParkingStore parkingStore) {
  return parkingStore.floors.firstWhere(
    (floor) => floor.parkingSpaces.any(
      (space) => space.registers.isNotEmpty,
    ),
    orElse: () => floorMock(
      const Uuid().v4(),
    ),
  );
}

ParkingSpace spaceMock(String newSpaceId) {
  return ParkingSpace(
    id: newSpaceId,
    name: 'new space name',
    number: '1',
  );
}

Floor floorMock(String newFloorId) {
  return Floor(
    id: newFloorId,
    name: 'new floor',
    code: 'n',
    parkingSpaces: [],
  );
}
