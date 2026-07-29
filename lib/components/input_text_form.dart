import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/color.dart';


class InputTextForm extends StatelessWidget {
  InputTextForm({
    super.key,
    required this.controller,
    required this.placeOlder,
    this.label,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.focusNode,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String placeOlder;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  FocusNode? focusNode;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
        ),
        TextFormField(
          style: Theme.of(context).textTheme.bodyMedium,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,

            // hintStyle: TextStyle(
            //   fontFamily: 'Raleway',
            //   fontSize: 14.spMin,
            //   color: AppColors.gray,
            // ),
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.secondaryColor),
            labelStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.lighgrey),
            hintText: placeOlder,
            filled: true,
            fillColor: Colors.white24,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 1),
              borderRadius: BorderRadius.circular(14),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),

          ),

          // decoration: InputDecoration(
          //   contentPadding:
          //       const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          //   errorStyle: const TextStyle(
          //       height: 0.1, color: AppColors.red, fontSize: 10),
          //   prefixIcon: prefixIcon,
          //   border: const OutlineInputBorder(
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(10),
          //     ),
          //   ),
          //   hintText: placeOlder,
          //   hintStyle: Theme.of(context)
          //       .textTheme
          //       .bodySmall
          //       ?.copyWith(color: AppColors.labelColor),
          // ),
        ),
      ],
    );
  }
}
