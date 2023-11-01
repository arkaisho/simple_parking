import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_parking/control/parking_store.dart';
import 'package:simple_parking/model/floor.dart';
import 'package:simple_parking/utils/custom_colors.dart';
import 'package:simple_parking/utils/fonts.dart';

class ParkingFloorDeleteModalContent extends StatefulWidget {
  final Function(String floorId) onConfirm;
  const ParkingFloorDeleteModalContent({
    required this.onConfirm,
    super.key,
  });

  @override
  State<ParkingFloorDeleteModalContent> createState() =>
      _ParkingFloorDeleteModalContentState();
}

class _ParkingFloorDeleteModalContentState
    extends State<ParkingFloorDeleteModalContent> {
  var parkingStore = GetIt.I.get<ParkingStore>();
  String dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Remover pátio/piso",
                  textAlign: TextAlign.center,
                  style: Fonts.headline4.copyWith(
                    color: CustomColors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: DropdownMenu<String>(
                  inputDecorationTheme: const InputDecorationTheme(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                  hintText: "Selecionar",
                  onSelected: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  dropdownMenuEntries: parkingStore.floors
                      .map<DropdownMenuEntry<String>>((Floor floor) {
                    return DropdownMenuEntry<String>(
                      value: floor.id,
                      label: floor.name,
                    );
                  }).toList(),
                ),
              ),
              if (dropdownValue.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Realmente deseja remover pátio/piso\n'${parkingStore.floors.firstWhere((floor) => floor.id == dropdownValue).name}'?",
                    textAlign: TextAlign.center,
                    style: Fonts.headline5.copyWith(
                      color: CustomColors.black,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 40,
                        ),
                        decoration: BoxDecoration(
                          color: CustomColors.gray,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Text(
                          "Cancelar",
                          style: Fonts.headline5.copyWith(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.black,
                          ),
                        ),
                      ),
                    ),
                    if (dropdownValue.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          widget.onConfirm(dropdownValue);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                          decoration: BoxDecoration(
                            color: CustomColors.red,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Text(
                            "Remover",
                            style: Fonts.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          ),
        ),
      ],
    );
  }
}
