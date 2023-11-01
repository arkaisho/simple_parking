// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ParkingStore on _ParkingStore, Store {
  late final _$loadingFloorsAtom =
      Atom(name: '_ParkingStore.loadingFloors', context: context);

  @override
  bool get loadingFloors {
    _$loadingFloorsAtom.reportRead();
    return super.loadingFloors;
  }

  @override
  set loadingFloors(bool value) {
    _$loadingFloorsAtom.reportWrite(value, super.loadingFloors, () {
      super.loadingFloors = value;
    });
  }

  late final _$loadingCsvAtom =
      Atom(name: '_ParkingStore.loadingCsv', context: context);

  @override
  bool get loadingCsv {
    _$loadingCsvAtom.reportRead();
    return super.loadingCsv;
  }

  @override
  set loadingCsv(bool value) {
    _$loadingCsvAtom.reportWrite(value, super.loadingCsv, () {
      super.loadingCsv = value;
    });
  }

  late final _$searchFilterAtom =
      Atom(name: '_ParkingStore.searchFilter', context: context);

  @override
  String get searchFilter {
    _$searchFilterAtom.reportRead();
    return super.searchFilter;
  }

  @override
  set searchFilter(String value) {
    _$searchFilterAtom.reportWrite(value, super.searchFilter, () {
      super.searchFilter = value;
    });
  }

  late final _$floorsAtom =
      Atom(name: '_ParkingStore.floors', context: context);

  @override
  ObservableList<Floor> get floors {
    _$floorsAtom.reportRead();
    return super.floors;
  }

  @override
  set floors(ObservableList<Floor> value) {
    _$floorsAtom.reportWrite(value, super.floors, () {
      super.floors = value;
    });
  }

  late final _$selectedFloorAtom =
      Atom(name: '_ParkingStore.selectedFloor', context: context);

  @override
  Floor? get selectedFloor {
    _$selectedFloorAtom.reportRead();
    return super.selectedFloor;
  }

  @override
  set selectedFloor(Floor? value) {
    _$selectedFloorAtom.reportWrite(value, super.selectedFloor, () {
      super.selectedFloor = value;
    });
  }

  late final _$selectedParkingSpaceAtom =
      Atom(name: '_ParkingStore.selectedParkingSpace', context: context);

  @override
  ParkingSpace? get selectedParkingSpace {
    _$selectedParkingSpaceAtom.reportRead();
    return super.selectedParkingSpace;
  }

  @override
  set selectedParkingSpace(ParkingSpace? value) {
    _$selectedParkingSpaceAtom.reportWrite(value, super.selectedParkingSpace,
        () {
      super.selectedParkingSpace = value;
    });
  }

  late final _$getFloorsAsyncAction =
      AsyncAction('_ParkingStore.getFloors', context: context);

  @override
  Future getFloors() {
    return _$getFloorsAsyncAction.run(() => super.getFloors());
  }

  late final _$exportAllRegistersAsyncAction =
      AsyncAction('_ParkingStore.exportAllRegisters', context: context);

  @override
  Future<String?> exportAllRegisters() {
    return _$exportAllRegistersAsyncAction
        .run(() => super.exportAllRegisters());
  }

  late final _$exportSpaceRegistersAsyncAction =
      AsyncAction('_ParkingStore.exportSpaceRegisters', context: context);

  @override
  Future exportSpaceRegisters(
      {required List<VehicleRegister> registers, required String spaceName}) {
    return _$exportSpaceRegistersAsyncAction.run(() =>
        super.exportSpaceRegisters(registers: registers, spaceName: spaceName));
  }

  late final _$_ParkingStoreActionController =
      ActionController(name: '_ParkingStore', context: context);

  @override
  dynamic setSearchFilter(String value) {
    final _$actionInfo = _$_ParkingStoreActionController.startAction(
        name: '_ParkingStore.setSearchFilter');
    try {
      return super.setSearchFilter(value);
    } finally {
      _$_ParkingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedFloor(Floor? value) {
    final _$actionInfo = _$_ParkingStoreActionController.startAction(
        name: '_ParkingStore.setSelectedFloor');
    try {
      return super.setSelectedFloor(value);
    } finally {
      _$_ParkingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedParkingSpace(ParkingSpace? value) {
    final _$actionInfo = _$_ParkingStoreActionController.startAction(
        name: '_ParkingStore.setSelectedParkingSpace');
    try {
      return super.setSelectedParkingSpace(value);
    } finally {
      _$_ParkingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addNewFloor({required Floor floor}) {
    final _$actionInfo = _$_ParkingStoreActionController.startAction(
        name: '_ParkingStore.addNewFloor');
    try {
      return super.addNewFloor(floor: floor);
    } finally {
      _$_ParkingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addNewParkingSpace(
      {required String floorId, required ParkingSpace space}) {
    final _$actionInfo = _$_ParkingStoreActionController.startAction(
        name: '_ParkingStore.addNewParkingSpace');
    try {
      return super.addNewParkingSpace(floorId: floorId, space: space);
    } finally {
      _$_ParkingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteParkingSpace(
      {required String floorId, required String spaceid}) {
    final _$actionInfo = _$_ParkingStoreActionController.startAction(
        name: '_ParkingStore.deleteParkingSpace');
    try {
      return super.deleteParkingSpace(floorId: floorId, spaceid: spaceid);
    } finally {
      _$_ParkingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteParkingFloor({required String floorId}) {
    final _$actionInfo = _$_ParkingStoreActionController.startAction(
        name: '_ParkingStore.deleteParkingFloor');
    try {
      return super.deleteParkingFloor(floorId: floorId);
    } finally {
      _$_ParkingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic registerVehicleArrival(
      {required String floorId,
      required String parkingSpaceId,
      required String plate}) {
    final _$actionInfo = _$_ParkingStoreActionController.startAction(
        name: '_ParkingStore.registerVehicleArrival');
    try {
      return super.registerVehicleArrival(
          floorId: floorId, parkingSpaceId: parkingSpaceId, plate: plate);
    } finally {
      _$_ParkingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic registerVehicleDeparture(
      {required String floorId, required String parkingSpaceId}) {
    final _$actionInfo = _$_ParkingStoreActionController.startAction(
        name: '_ParkingStore.registerVehicleDeparture');
    try {
      return super.registerVehicleDeparture(
          floorId: floorId, parkingSpaceId: parkingSpaceId);
    } finally {
      _$_ParkingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingFloors: ${loadingFloors},
loadingCsv: ${loadingCsv},
searchFilter: ${searchFilter},
floors: ${floors},
selectedFloor: ${selectedFloor},
selectedParkingSpace: ${selectedParkingSpace}
    ''';
  }
}
