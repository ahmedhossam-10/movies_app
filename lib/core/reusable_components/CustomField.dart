import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatefulWidget {
  final String hint;
  final String? prefix;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?) validation;
  final TextInputType keyboard;
  final int maxLines;

  const CustomField({
    this.maxLines = 1,
    required this.keyboard,
    required this.hint,
    this.prefix,
    required this.controller,
    this.isPassword = false,
    required this.validation,
    super.key,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final background = Colors.grey[800];

    return TextFormField(
      maxLines: widget.maxLines,
      keyboardType: widget.keyboard,
      validator: widget.validation,
      controller: widget.controller,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      obscureText: widget.isPassword ? isHidden : false,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        filled: true,
        fillColor: background,
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white70,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              isHidden = !isHidden;
            });
          },
          icon: Icon(
            isHidden ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: background!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: background, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        hintText: widget.hint,
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 60,
          maxHeight: 60,
        ),
        prefixIcon: widget.prefix == null
            ? null
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(
            widget.prefix!,
            height: 28,
            width: 28,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
