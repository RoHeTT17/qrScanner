import 'package:flutter/material.dart';

class ScanButtom extends StatelessWidget {
//  const ScanButtom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: ()=>{}
      
      );
  }
}