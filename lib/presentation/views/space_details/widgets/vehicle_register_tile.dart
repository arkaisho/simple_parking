import 'package:flutter/material.dart';
import 'package:simple_parking/model/vehicle_register.dart';
import 'package:simple_parking/utils/custom_colors.dart';
import 'package:simple_parking/utils/fonts.dart';
import 'package:simple_parking/utils/misc.dart';

class VehicleRegisterTile extends StatelessWidget {
  final VehicleRegister register;
  const VehicleRegisterTile({
    required this.register,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: CustomColors.white.withOpacity(
              .1,
            ),
          ),
        ),
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                register.vehicle.plate,
                maxLines: 1,
                style: Fonts.headline5.copyWith(
                  color: CustomColors.white,
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chegada: ${getReadableCompleteDate(register.entryTime!)}",
                    style: Fonts.headline6.copyWith(
                      color: CustomColors.white,
                    ),
                  ),
                  Text(
                    "Saída: ${getReadableCompleteDate(register.departureTime!)}",
                    style: Fonts.headline6.copyWith(
                      color: CustomColors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
