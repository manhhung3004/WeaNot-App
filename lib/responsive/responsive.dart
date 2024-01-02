import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget largeSrceen ;
  final Widget smallSrceen ;
  final Widget  mediumSrceen ;
  const Responsive({
  required this.smallSrceen,
  required Key key,
  required this.mediumSrceen,
  required this.largeSrceen,
  }) : super(key : key);

  static bool isSmallSrceen (BuildContext context){
    return MediaQuery.of(context).size.width<800;
  }

  static bool isMediumSrceen (BuildContext context){
    return MediaQuery.of(context).size.width>=800 && MediaQuery.of(context).size.width<=1200;
  }

  static bool isLargeSrceen (BuildContext context){
    return MediaQuery.of(context).size.width>1200;
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        if(constraints.maxWidth > 1200){
          return largeSrceen;
        }
        else if (constraints.maxWidth >= 800 && constraints.maxWidth < 1200 ){
          return mediumSrceen;
        }
        else{
          return smallSrceen ;
        }
      });
  }



}