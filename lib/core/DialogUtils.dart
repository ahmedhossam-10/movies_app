import 'package:flutter/material.dart';

class DialogUtils{
  static showLoadingDialog(BuildContext context){
    showDialog(context: context, builder: (context)=>AlertDialog(
      alignment: Alignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: CircularProgressIndicator(),),
        ],
      ),
    )
    );
  }
}