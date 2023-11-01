import 'package:flutter/material.dart';
import 'package:simple_parking/presentation/widgets/custom_text_form_field.dart';
import 'package:simple_parking/utils/custom_colors.dart';
import 'package:simple_parking/utils/fonts.dart';

class VehicleArrivalModalContent extends StatefulWidget {
  final Function(String) onConfirm;
  const VehicleArrivalModalContent({
    required this.onConfirm,
    super.key,
  });

  @override
  State<VehicleArrivalModalContent> createState() =>
      _VehicleArrivalModalContentState();
}

class _VehicleArrivalModalContentState
    extends State<VehicleArrivalModalContent> {
  String plate = "";
  String error = "";
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "Placa",
                        style: Fonts.headline4.copyWith(
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                              child: Text(
                                error,
                                style: Fonts.caption.copyWith(
                                  color: error.isNotEmpty
                                      ? CustomColors.red
                                      : Colors.transparent,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: Center(
                                child: CustomTextFormField(
                                  onChanged: (value) {
                                    plate = value ?? "";
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (plate.isNotEmpty) {
                      Navigator.pop(context);
                      widget.onConfirm(plate);
                    } else {
                      setState(() {
                        error = "Insira uma placa para registrar a entrada";
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 40,
                    ),
                    decoration: BoxDecoration(
                      color: CustomColors.primary,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Text(
                      "Registrar entrada",
                      style: Fonts.headline5.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.black,
                      ),
                    ),
                  ),
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
