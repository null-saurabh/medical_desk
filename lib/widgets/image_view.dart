import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_desk/utils/assets.dart';


enum ImageType { asset, file, url, svg, urlSvg }

class ImageView extends StatelessWidget {
  ImageType imageType;
  String imagePath;
  double? height;
  double? width;
  BoxFit? fit;
  String? placeHolder;
  Color? color;
  ImageView(
      {super.key,
      required this.imagePath,
      required this.imageType,
      this.height,
      this.placeHolder = AppAssets.placeHolder,
      this.fit,
        this.color,
      this.width});

  @override
  Widget build(BuildContext context) {
    if (imageType == ImageType.asset) {
      return Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return placeholderWidget();
        },
      );
    }
    if (imageType == ImageType.file) {
      return Image.file(
        File(imagePath),
        height: height,
        fit: fit,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return placeholderWidget();
        },
      );
    }
    if (imageType == ImageType.url) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        height: height,
        width: width,
        fit: fit,

        errorWidget: (context, url, error) => placeholderWidget(),
      );
    }
    if (imageType == ImageType.svg) {
      return SvgPicture.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
      );
    }
    if (imageType == ImageType.urlSvg) {
      return SvgPicture.network(
        imagePath,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
      );
    }
    return placeholderWidget();
  }

  SizedBox placeholderWidget() {
    return SizedBox(
      height: height,
      width: width,
      child: Image.asset(
        placeHolder!,
      ),
    );
  }
}
