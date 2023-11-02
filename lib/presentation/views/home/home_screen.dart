import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_parking/control/parking_store.dart';
import 'package:simple_parking/model/floor.dart';
import 'package:simple_parking/model/parking_space.dart';
import 'package:simple_parking/presentation/views/home/widgets/home_options_modal_content.dart';
import 'package:simple_parking/presentation/views/home/widgets/parking_space_creation_modal_content.dart';
import 'package:simple_parking/presentation/views/space_details/space_detail_screen.dart';
import 'package:simple_parking/presentation/widgets/custom_search_bar.dart';
import 'package:simple_parking/utils/custom_colors.dart';
import 'package:simple_parking/utils/fonts.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:simple_parking/utils/misc.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home_screen";
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var parkingStore = GetIt.I.get<ParkingStore>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      parkingStore.getFloors();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return GestureDetector(
        onTap: () {
          dismissKeyboard();
        },
        child: Scaffold(
          backgroundColor: CustomColors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomSearchBar(
                          label: "Pesquisar por vaga ou placa",
                          onChanged: (value) {
                            parkingStore.setSearchFilter(value);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: parkingStore.loadingCsv
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: CustomColors.primary,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return const HomeOptionsModalContent();
                                    },
                                  );
                                },
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Icons.more_vert,
                                    color: CustomColors.white,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                  ...parkingStore.floors
                      .map(
                        (floor) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      floor.name,
                                      style: Fonts.headline3.copyWith(
                                        color: CustomColors.white,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return ParkingSpaceCreationModalContent(
                                              onConfirm: (space) {
                                                parkingStore.addNewParkingSpace(
                                                  floorId: floor.id,
                                                  space: space,
                                                );
                                                setState(() {});
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: CustomColors.gray,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    ...filteredSpaces(floor).isEmpty
                                        ? [
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Text(
                                                "Nenhuma vaga",
                                                style: Fonts.headline5.copyWith(
                                                  color: CustomColors.gray,
                                                ),
                                              ),
                                            )
                                          ]
                                        : filteredSpaces(floor)
                                            .map(
                                              (space) => GestureDetector(
                                                onTap: () async {
                                                  parkingStore.setSelectedFloor(
                                                    floor,
                                                  );
                                                  parkingStore
                                                      .setSelectedParkingSpace(
                                                    space,
                                                  );
                                                  await Navigator.pushNamed(
                                                    context,
                                                    SpaceDetailsScreen
                                                        .routeName,
                                                  );
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                        width: 1,
                                                        color: CustomColors
                                                            .white
                                                            .withOpacity(
                                                          .1,
                                                        ),
                                                      ),
                                                    ),
                                                    gradient: space.status !=
                                                            ParkingSpaceStatus
                                                                .filled
                                                        ? LinearGradient(
                                                            colors: [
                                                              Colors
                                                                  .transparent,
                                                              CustomColors
                                                                  .primary
                                                                  .withOpacity(
                                                                      1),
                                                            ],
                                                          )
                                                        : null,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 5,
                                                        height: 50,
                                                        color: space.status ==
                                                                ParkingSpaceStatus
                                                                    .filled
                                                            ? CustomColors
                                                                .yellow
                                                            : null,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      if (space.parkedVehicle !=
                                                          null)
                                                        Image.asset(
                                                          "assets/images/side_truck.png",
                                                          height: 40,
                                                        ),
                                                      const SizedBox(width: 10),
                                                      const Spacer(),
                                                      Text(
                                                        space.parkedVehicle !=
                                                                null
                                                            ? space
                                                                .parkedVehicle!
                                                                .plate
                                                            : "",
                                                        style: Fonts.headline5
                                                            .copyWith(
                                                          color: CustomColors
                                                              .white,
                                                        ),
                                                      ),
                                                      Text(
                                                        " ${floor.code}${space.number}  ",
                                                        style: Fonts.headline4
                                                            .copyWith(
                                                          color: CustomColors
                                                              .white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                    Container(
                                      height: 1,
                                      color: CustomColors.white.withOpacity(
                                        .1,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  const SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  List<ParkingSpace> filteredSpaces(Floor floor) {
    return floor.parkingSpaces.where(
      (space) {
        bool spaceCodeContainsFilter =
            "${floor.code}${space.number}".toLowerCase().contains(
                  parkingStore.searchFilter.toLowerCase(),
                );
        bool spaceNameContainsFilter = space.name != null &&
            space.name!.toLowerCase().contains(
                  parkingStore.searchFilter.toLowerCase(),
                );
        bool spaceNumberContainsFilter =
            space.number.toString().toLowerCase().contains(
                  parkingStore.searchFilter.toLowerCase(),
                );
        bool spaceVehicleContainsFilter = space.parkedVehicle != null &&
            space.parkedVehicle!.plate.toString().toLowerCase().contains(
                  parkingStore.searchFilter.toLowerCase(),
                );
        return spaceCodeContainsFilter ||
            spaceNameContainsFilter ||
            spaceNumberContainsFilter ||
            spaceVehicleContainsFilter;
      },
    ).toList();
  }
}
