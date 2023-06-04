import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String iconPath;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final Color? color;

  const CustomIcon({
    super.key,
    required this.iconPath,
    this.width,
    this.height,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Image.asset(
        iconPath,
        height: height,
        width: width,
        color: color,
      ),
    );
  }
}
