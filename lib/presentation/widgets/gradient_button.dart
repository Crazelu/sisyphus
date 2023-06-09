import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;

  const GradientButton({
    super.key,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double buttonHeight = 56;
    return SizedBox(
      width: width,
      height: buttonHeight,
      child: TextButton(
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.resolveWith(
          (states) => Size(width, buttonHeight),
        )),
        onPressed: onPressed,
        child: Ink(
          width: width,
          height: buttonHeight,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xff483BEB),
                Color(0xff7847E1),
                Color(0xffDD568D),
              ],
              stops: [0.5, 0.7, 1],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
