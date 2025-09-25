import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/ColorManager.dart';

class CastWidget extends StatelessWidget {
  String name;
  String character;
  String pic;
   CastWidget({super.key,required this.pic, required this.name,required this.character});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: ColorManager.darkGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset(pic),
          Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Name : $name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white),),
                    Text("Character : $character",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white),),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
