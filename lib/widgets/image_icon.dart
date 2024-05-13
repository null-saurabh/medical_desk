import 'package:flutter/material.dart';

class IconImage extends StatelessWidget {
  String imagePath;
  Color? color;
  double? size;
  IconImage({
    Key? key,
    required this.imagePath,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath,height: size ?? 22, width: size ?? 22,color: color,);

    //   ImageIcon(
    //   AssetImage(imagePath),
    //   size: size ?? 22,
    //   color: color,
    // );
  }
}

// class SvgImage extends StatelessWidget {
//   String imagePath;
//   Color? color;
//   double? size;
//   SvgImage({
//     Key? key,
//     required this.imagePath,
//     this.color = Colors.white,
//     this.size,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SvgPicture.asset(imagePath);
//   }
// }
