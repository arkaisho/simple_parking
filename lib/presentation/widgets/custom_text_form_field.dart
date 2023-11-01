import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_parking/utils/custom_colors.dart';
import 'package:simple_parking/utils/fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String?) onChanged;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  const CustomTextFormField({
    required this.onChanged,
    this.textInputType,
    this.inputFormatters,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      style: Fonts.headline6.copyWith(
        color: CustomColors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        fillColor: CustomColors.black.withOpacity(.05),
        hintStyle: Fonts.headline6.copyWith(
          color: CustomColors.black.withOpacity(.6),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(50.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
      ),
    );
  }
}
