import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final IconData? icon;
  final String? svgIcon;

  CustomTextField({
    required this.hintText,
    this.isPassword = false,
    this.icon,
    this.svgIcon,
    super.key,
  });

  String? _validate(String? value) {
    if (value == null || value.isEmpty) return 'This field is Required';

    if (isPassword && value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (!isPassword) {
      final emailRegex = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (!emailRegex.hasMatch(value)) return 'Please enter a valid email';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      style: TextStyle(color: ColorManger.white),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManger.darkGray),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManger.darkGray),
        ),
        filled: true,
        fillColor: ColorManger.darkGray,
        labelText: hintText,
        labelStyle: TextStyle(color: ColorManger.white),
        floatingLabelStyle: TextStyle(color: ColorManger.white),
        prefixIcon: icon != null
            ? Icon(icon, color: ColorManger.white)
            : svgIcon != null
            ? Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            svgIcon!,
            color: ColorManger.white,
            width: 20,
            height: 20,
          ),
        )
            : null,
      ),
      validator: _validate,
    );
  }
}

