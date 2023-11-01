import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_parking/control/parking_store.dart';
import 'package:simple_parking/presentation/views/space_details/widgets/parking_space_delete_modal_content.dart';
import 'package:simple_parking/presentation/views/space_details/widgets/vehicle_arrival_modal_content.dart';
import 'package:simple_parking/presentation/views/space_details/widgets/vehicle_departure_modal_content.dart';
import 'package:simple_parking/presentation/views/space_details/widgets/vehicle_register_tile.dart';
import 'package:simple_parking/utils/custom_colors.dart';
import 'package:simple_parking/utils/fonts.dart';
import 'package:simple_parking/utils/misc.dart';

class SpaceDetailsScreen extends StatefulWidget {
  static const routeName = "/space_details_screen";
  const SpaceDetailsScreen({
    super.key,
  });

  @override
  State<SpaceDetailsScreen> createState() => _SpaceDetailsScreenState();
}

class _SpaceDetailsScreenState extends State<SpaceDetailsScreen> {
  var parkingStore = GetIt.I.get<ParkingStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: CustomColors.black,
          floatingActionButton: FloatingActionButton(
            backgroundColor:
                parkingStore.selectedParkingSpace?.parkedVehicle != null
                    ? CustomColors.red
                    : CustomColors.primary,
            child: Icon(
              parkingStore.selectedParkingSpace?.parkedVehicle != null
                  ? Icons.logout
                  : Icons.login,
            ),
            onPressed: () {
              if (parkingStore.selectedParkingSpace?.parkedVehicle != null) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return VehicleDepartureModalContent(
                      onConfirm: () {
                        parkingStore.registerVehicleDeparture(
                          floorId: parkingStore.selectedFloor!.id,
                          parkingSpaceId: parkingStore.selectedParkingSpace!.id,
                        );
                        setState(() {});
                      },
                      vehiclePlate:
                          "${parkingStore.selectedParkingSpace?.parkedVehicle!.plate}",
                    );
                  },
                );
              } else {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return VehicleArrivalModalContent(
                      onConfirm: (plate) {
                        parkingStore.registerVehicleArrival(
                          floorId: parkingStore.selectedFloor!.id,
                          parkingSpaceId: parkingStore.selectedParkingSpace!.id,
                          plate: plate,
                        );
                        setState(() {});
                      },
                    );
                  },
                );
              }
            },
          ),
          appBar: AppBar(
            backgroundColor: CustomColors.tertiary,
            centerTitle: true,
            title: Text(
              "${parkingStore.selectedFloor?.code}${parkingStore.selectedParkingSpace?.number} - ${parkingStore.selectedParkingSpace?.name}",
              style: Fonts.headline3.copyWith(
                color: CustomColors.black,
              ),
            ),
            actions: [
              SizedBox(
                height: 20,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ParkingSpaceDeleteModalContent(
                          onConfirm: () {
                            Navigator.pop(context);
                            parkingStore.deleteParkingSpace(
                              floorId: parkingStore.selectedFloor!.id,
                              spaceid: parkingStore.selectedParkingSpace!.id,
                            );
                          },
                          spaceName: parkingStore.selectedParkingSpace!.name,
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: CustomColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    color: CustomColors.tertiary,
                    child: Column(
                      children: [
                        if (parkingStore.selectedParkingSpace?.parkedVehicle ==
                            null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Text(
                              "Vago",
                              style: Fonts.headline4.copyWith(
                                color: CustomColors.black,
                              ),
                            ),
                          ),
                        if (parkingStore.selectedParkingSpace?.parkedVehicle !=
                            null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Image.asset(
                                    "assets/images/d0242b54e1cfb109a44c3b0ed2f6e0d2.png",
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    parkingStore.selectedParkingSpace!
                                        .parkedVehicle!.plate,
                                    style: Fonts.headline3.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: CustomColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Entrou ${formatDateTime(parkingStore.selectedParkingSpace!.currentVehicleEntryTime!, showCompleteWeekDay: true).toLowerCase()}",
                                style: Fonts.headline4.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: CustomColors.black,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Histórico de registros",
                          style: Fonts.headline4.copyWith(
                            color: CustomColors.white,
                          ),
                        ),
                        parkingStore.loadingCsv
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: CustomColors.primary,
                                ),
                              )
                            : SizedBox(
                                width: 20,
                                height: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    parkingStore.exportSpaceRegisters(
                                      registers: parkingStore
                                              .selectedParkingSpace
                                              ?.registers ??
                                          [],
                                      spaceName:
                                          "${parkingStore.selectedFloor?.name ?? "pátio-selecionado"}-${(parkingStore.selectedParkingSpace?.name ?? "espaço-selecionado")}",
                                    );
                                  },
                                  child: Icon(
                                    Icons.download_for_offline_outlined,
                                    color: CustomColors.gray,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                  if (parkingStore.selectedFloor != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: parkingStore
                              .selectedParkingSpace!.registers.isEmpty
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Sem registros de veículos ainda",
                                style: Fonts.headline6.copyWith(
                                  color: CustomColors.white,
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                ...parkingStore.selectedParkingSpace!.registers
                                    .map(
                                      (register) => VehicleRegisterTile(
                                        register: register,
                                      ),
                                    )
                                    .toList(),
                                Container(
                                  height: 1,
                                  color: CustomColors.white.withOpacity(
                                    .1,
                                  ),
                                ),
                              ],
                            ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
