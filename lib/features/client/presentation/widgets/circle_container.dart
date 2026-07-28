import 'package:flutter/material.dart';
import 'package:tailor_made/core/theme/app_pallete.dart';

class CircleContainer extends StatelessWidget {
  final double diameter;
  final Color color; 
  const CircleContainer({
    this.diameter = 100,
    this.color = AppPallete.greyColor,
    super.key
  });


  @override 
  Widget build(BuildContext context){
    return Container(
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      )
    );
  }

}