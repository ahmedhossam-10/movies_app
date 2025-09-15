import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import '../resources/AssetsManager.dart';
import '../resources/ColorManager.dart';

class CustomSwitch extends StatelessWidget {
  List<Widget> icons;
  int current;
  void Function(int) onChange;
  CustomSwitch({required this.icons,required this.current,required this.onChange});

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<int>.rolling(
      onChanged:(selectedValue){
        onChange(selectedValue);
      },
      current: current,
      values: [
        0,1
      ],
      inactiveOpacity: 1.0,
      iconOpacity: 1,
      style: ToggleStyle(
          indicatorColor: ColorManager.yellow,
          borderColor: ColorManager.yellow,
          backgroundColor: Colors.transparent
      ),
      iconList: icons,
    );
  }
}