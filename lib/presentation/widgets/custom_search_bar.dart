import 'package:flutter/material.dart';
import 'package:simple_parking/utils/fonts.dart';
import '../../utils/custom_colors.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    Key? key,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  final Function(String) onChanged;
  final String label;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: SizedBox(
        height: 40,
        child: TextFormField(
          onChanged: (value) {
            widget.onChanged(value);
          },
          style: Fonts.caption.copyWith(
            color: CustomColors.white,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: CustomColors.white.withOpacity(.05),
            prefixIcon: Icon(
              Icons.search,
              color: CustomColors.white.withOpacity(.6),
            ),
            labelText: widget.label,
            labelStyle: Fonts.caption.copyWith(
              color: CustomColors.white.withOpacity(.6),
              fontWeight: FontWeight.w600,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
      ),
    );
  }
}
