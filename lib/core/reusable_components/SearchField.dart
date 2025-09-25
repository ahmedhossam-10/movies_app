import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/AssetsManager.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hint;

  const SearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hint = "Search...",
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final background = Colors.grey[800];

    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white70,
          fontSize: 16.sp,
        ),
        filled: true,
        fillColor: background,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SvgPicture.asset(
            AssetsManager.search_selected,
            height: 24.h,
            width: 24.w,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          maxWidth: 60.w,
          maxHeight: 60.h,
        ),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
          icon: Icon(Icons.clear, color: Colors.white, size: 20.sp),
          onPressed: () {
            widget.controller.clear();
            widget.onChanged?.call("");
            setState(() {});
          },
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
      ),
    );
  }
}
