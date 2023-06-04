import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/theme/palette.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int index;
  final Function(int)? onChanged;
  final Color? selectedTabBorderColor;

  const CustomTabBar({
    super.key,
    this.tabs = const [],
    this.index = 0,
    this.onChanged,
    this.selectedTabBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      padding: selectedTabBorderColor != null
          ? EdgeInsets.zero
          : const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: palette.tabBackgroundColor,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int i) {
          return _Tab(
            key: ValueKey("Tab -> ${tabs[index]}"),
            title: tabs[index],
            selected: i == index,
            addPadding: i != tabs.length - 1,
            borderColor: selectedTabBorderColor,
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
  final Color? borderColor;

  const _Tab({
    super.key,
    required this.title,
    required this.selected,
    this.addPadding = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Container(
      height: 34,
      padding: addPadding ? const EdgeInsets.only(right: 4) : EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: selected ? palette.selectedTabChipColor : Colors.transparent,
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: selected
              ? palette.selectedTabTextColor
              : palette.unselectedTabTextColor,
        ),
      ),
    );
  }
}
