import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_manage_app/constant.dart';
import '../styles/colors/colors.dart';

class CustomeImage extends StatelessWidget {
  final String? image;
  final double? height, width;
  final double? iconSize;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BoxFit? fit;
  const CustomeImage({
    super.key,
    this.image,
    this.height,
    this.width,
    this.borderRadius,
    this.iconSize,
    this.margin,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * .25,
      width: width ?? MediaQuery.of(context).size.width * .25,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade200,
        borderRadius: borderRadius,
        image: image != null
            ? DecorationImage(
                fit: fit ?? BoxFit.cover,
                image: AssetImage(image!),
              )
            : null,
      ),
      child: image != null
          ? null
          : Icon(
              Icons.person,
              size: iconSize ?? 35.sp,
              color: defaultColor2,
            ),
    );
  }
}

class CustomeNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height, width;
  final double? iconSize;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BoxFit? fit;
  const CustomeNetworkImage({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.borderRadius,
    this.iconSize,
    this.margin,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * .25,
      width: width ?? MediaQuery.of(context).size.width * .25,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade200,
        borderRadius: borderRadius,
        image: imageUrl != null
            ? DecorationImage(
                fit: fit ?? BoxFit.scaleDown,
                image: NetworkImage('http://$ipAddress:8000/upload/$imageUrl'),
              )
            : null,
      ),
      child: imageUrl != null
          ? null
          : Icon(
              Icons.person,
              size: iconSize ?? 35.sp,
              color: defaultColor2,
            ),
    );
  }
}
