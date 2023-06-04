import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double? fontSize;
  final Color? color;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.width = 171,
    this.height = 32,
    this.fontSize = 16,
    this.color,
  }) : super(key: key);

  const CustomButton.buy({
    super.key,
    required this.onPressed,
    this.buttonText = "Buy",
    this.fontSize = 16,
    this.width = 171,
    this.height = 32,
    this.color = const Color(0xff25C26E),
  });

  const CustomButton.sell({
    super.key,
    required this.onPressed,
    this.buttonText = "Sell",
    this.fontSize = 16,
    this.width = 171,
    this.height = 32,
    this.color = const Color(0xffFF554A),
  });

  const CustomButton.deposit({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.fontSize = 14,
    this.width = 80,
    this.height = 32,
    this.color = const Color(0xff2764FF),
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        splashFactory: InkRipple.splashFactory,
        textStyle: MaterialStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: fontSize ?? 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => color,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.white,
        ),
        fixedSize: MaterialStateProperty.resolveWith(
          (states) => Size(width, height),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
