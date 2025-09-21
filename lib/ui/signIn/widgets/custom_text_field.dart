import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final IconData? icon;
  final String? svgIcon;

  const CustomTextField({
    required this.hintText,
    this.isPassword = false,
    this.icon,
    this.svgIcon,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  String? _validate(String? value) {
    if (value == null || value.isEmpty) return 'This field is Required';

    if (widget.isPassword && value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (!widget.isPassword) {
      final emailRegex = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (!emailRegex.hasMatch(value)) return 'Please enter a valid email';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? _obscureText : false,
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
        labelText: widget.hintText,
        labelStyle: TextStyle(color: ColorManger.white),
        floatingLabelStyle: TextStyle(color: ColorManger.white),
        prefixIcon: widget.icon != null
            ? Icon(widget.icon, color: ColorManger.white)
            : widget.svgIcon != null
            ? Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            widget.svgIcon!,
            color: ColorManger.white,
            width: 20,
            height: 20,
          ),
        )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: ColorManger.white,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
      validator: _validate,
    );
  }
}
