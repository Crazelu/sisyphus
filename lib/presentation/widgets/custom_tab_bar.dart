import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'dart:math' as math;

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int index;
  final Function(int)? onChanged;
  final Color? selectedTabBorderColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomTabBar({
    super.key,
    this.tabs = const [],
    this.index = 0,
    this.onChanged,
    this.selectedTabBorderColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      padding: selectedTabBorderColor != null
          ? EdgeInsets.zero
          : const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: palette.tabBackgroundColor,
        border: palette.tabBorderColor != null
            ? Border.all(color: palette.tabBorderColor!)
            : null,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (BuildContext context, int i) {
          return _Tab(
            key: ValueKey("Tab -> ${tabs[i]}"),
            title: tabs[i],
            selected: i == index,
            addPadding: i != tabs.length - 1,
            borderColor: selectedTabBorderColor,
            onPressed: () => onChanged?.call(i),
            minWidth: math.max(
              102,
              (width / tabs.length) * (tabs.length > 2 ? .92 : 0.9),
            ),
            fontSize: fontSize,
            fontWeight: fontWeight,
          );
        },
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String title;
  final bool selected;
  final bool addPadding;
  final double minWidth;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final double? fontSize;
  final FontWeight? fontWeight;

  const _Tab({
    super.key,
    required this.title,
    required this.selected,
    this.addPadding = false,
    this.minWidth = 102,
    this.borderColor,
    this.onPressed,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.linearToEaseOut,
        constraints: BoxConstraints(minWidth: minWidth),
        height: 34,
        padding: addPadding ? const EdgeInsets.only(right: 4) : EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selected ? palette.selectedTabChipColor : Colors.transparent,
          border: selected
              ? borderColor != null
                  ? Border.all(color: borderColor!)
                  : null
              : null,
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSize ?? 14,
              fontWeight: fontWeight ?? FontWeight.w700,
              color: selected
                  ? palette.selectedTabTextColor
                  : palette.unselectedTabTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
