import 'package:flutter/material.dart';
import 'package:simple_parking/utils/custom_colors.dart';
import 'package:simple_parking/utils/fonts.dart';

class ParkingSpaceDeleteModalContent extends StatelessWidget {
  final String spaceName;
  final Function() onConfirm;
  const ParkingSpaceDeleteModalContent({
    required this.spaceName,
    required this.onConfirm,
    super.key,
  });

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
                  "Remover espaço",
                  textAlign: TextAlign.center,
                  style: Fonts.headline4.copyWith(
                    color: CustomColors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Realmente deseja remover espaço de estacionamento '$spaceName'?",
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        onConfirm();
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
