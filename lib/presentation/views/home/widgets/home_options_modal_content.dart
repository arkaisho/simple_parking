import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_parking/control/parking_store.dart';
import 'package:simple_parking/presentation/views/home/widgets/parking_floor_creation_modal_content.dart';
import 'package:simple_parking/presentation/views/home/widgets/parking_floor_delete_modal_content.dart';
import 'package:simple_parking/utils/custom_colors.dart';
import 'package:simple_parking/utils/fonts.dart';

class HomeOptionsModalContent extends StatelessWidget {
  const HomeOptionsModalContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              HomeOptionTile(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return ParkingFloorCreationModalContent(
                        onConfirm: (floor) {
                          GetIt.I.get<ParkingStore>().addNewFloor(floor: floor);
                        },
                      );
                    },
                  );
                },
                text: "Adicionar pátio/piso",
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.add,
                    color: CustomColors.black,
                    size: 20,
                  ),
                ),
              ),
              HomeOptionTile(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return ParkingFloorDeleteModalContent(
                        onConfirm: (floorId) {
                          GetIt.I.get<ParkingStore>().deleteParkingFloor(
                                floorId: floorId,
                              );
                        },
                      );
                    },
                  );
                },
                text: "Remover pátio/piso",
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.delete_outline_outlined,
                    color: CustomColors.black,
                    size: 20,
                  ),
                ),
              ),
              HomeOptionTile(
                onTap: () {
                  Navigator.pop(context);
                  GetIt.I.get<ParkingStore>().exportAllRegisters();
                },
                text: "Exportar todos os registros",
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.download_for_offline_outlined,
                    color: CustomColors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HomeOptionTile extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Widget? leading;

  const HomeOptionTile({
    required this.onTap,
    required this.text,
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: CustomColors.gray.withOpacity(.3),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading ?? const SizedBox.shrink(),
            Text(
              text,
              maxLines: 1,
              style: Fonts.headline5.copyWith(
                color: CustomColors.black,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
