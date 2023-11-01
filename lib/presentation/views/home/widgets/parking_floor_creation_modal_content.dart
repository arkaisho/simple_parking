import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_parking/model/floor.dart';
import 'package:simple_parking/presentation/widgets/custom_text_form_field.dart';
import 'package:simple_parking/utils/custom_colors.dart';
import 'package:simple_parking/utils/fonts.dart';
import 'package:uuid/uuid.dart';

class ParkingFloorCreationModalContent extends StatefulWidget {
  final Function(Floor) onConfirm;
  const ParkingFloorCreationModalContent({
    required this.onConfirm,
    super.key,
  });

  @override
  State<ParkingFloorCreationModalContent> createState() =>
      _ParkingFloorCreationModalContentState();
}

class _ParkingFloorCreationModalContentState
    extends State<ParkingFloorCreationModalContent> {
  String code = "";
  String name = "";
  String codeError = "";
  String nameError = "";
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
                  "Adicionar pátio/piso",
                  textAlign: TextAlign.center,
                  style: Fonts.headline4.copyWith(
                    color: CustomColors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "Nome",
                        style: Fonts.headline5.copyWith(
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
                                nameError,
                                style: Fonts.caption.copyWith(
                                  color: nameError.isNotEmpty
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
                                    name = value ?? "";
                                    setState(() => nameError = "");
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Código",
                      style: Fonts.headline5.copyWith(
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
                              codeError,
                              style: Fonts.caption.copyWith(
                                color: codeError.isNotEmpty
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
                                  code = value ?? "";
                                  setState(() => codeError = "");
                                },
                                hintText: "Somente letras",
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z]"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    if (code.isNotEmpty && name.isNotEmpty) {
                      Navigator.pop(context);
                      widget.onConfirm(
                        Floor(
                          id: const Uuid().v4(),
                          name: name,
                          code: code,
                          parkingSpaces: [],
                        ),
                      );
                    } else {
                      if (code.isEmpty) {
                        setState(() {
                          codeError = "Insira um código";
                        });
                      }
                      if (name.isEmpty) {
                        setState(() {
                          nameError = "Insira um nome";
                        });
                      }
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
                      "Adicionar",
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
