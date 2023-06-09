import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Function(String)? onPressed;
  final bool selected;
  final bool disableWidth;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final double? width;

  const CustomChip({
    super.key,
    required this.label,
    this.selected = false,
    this.disableWidth = false,
    this.fontWeight = FontWeight.w500,
    this.padding = EdgeInsets.zero,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onPressed?.call(label);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: padding,
        width: width ?? (disableWidth ? null : 40),
        height: 28,
        decoration: BoxDecoration(
          color: selected ? palette.selectedTimeChipColor : null,
          borderRadius: selected ? BorderRadius.circular(100) : null,
        ),
        child: Center(
          child: CustomText(
            text: label,
            fontSize: 14,
            fontWeight: fontWeight,
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
