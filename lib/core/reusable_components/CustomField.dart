import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      obscureText: widget.isPassword ? isHidden : false,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        filled: true,
        fillColor: background,
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white70,
          fontSize: 16.sp,
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
            size: 24.sp,
          ),
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: background!, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: background, width: 2.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.w,
          ),
        ),
        hintText: widget.hint,
        prefixIconConstraints: BoxConstraints(
          maxWidth: 60.w,
          maxHeight: 60.h,
        ),
        prefixIcon: widget.prefix == null
            ? null
            : Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SvgPicture.asset(
            widget.prefix!,
            height: 28.h,
            width: 28.w,
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
