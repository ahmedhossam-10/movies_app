import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white70,
        ),
        filled: true,
        fillColor: background,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(
            AssetsManager.search_selected,
            height: 24,
            width: 24,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 60,
          maxHeight: 60,
        ),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
          icon: const Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            widget.controller.clear();
            widget.onChanged?.call("");
            setState(() {});
          },
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
      ),
    );
  }
}
