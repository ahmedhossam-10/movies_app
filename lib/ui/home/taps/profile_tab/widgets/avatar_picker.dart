import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/ColorManager.dart';

class AvatarPicker extends StatelessWidget {
  final String selectedAvatar;
  final ValueChanged<String> onAvatarSelected;
  final VoidCallback openSheet; // دالة لفتح الـ BottomSheet

  const AvatarPicker({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
    required this.openSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: openSheet,
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(selectedAvatar),
        ),
      ),
    );
  }

  void showAvatarSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.darkGray,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final avatarPath = 'assets/images/avatar ${index + 1}.png';
              final isSelected = avatarPath == selectedAvatar;

              return GestureDetector(
                onTap: () {
                  onAvatarSelected(avatarPath);
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: isSelected ? ColorManager.yellow : Colors.transparent,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage(avatarPath),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
