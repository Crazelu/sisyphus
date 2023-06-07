import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/theme/palette.dart';

class FilterRow extends StatefulWidget {
  final Function(int) onChanged;

  const FilterRow({super.key, required this.onChanged});

  @override
  State<FilterRow> createState() => FilterRowState();
}

class FilterRowState extends State<FilterRow> {
  int _index = 0;

  void _setIndex(int value) {
    if (_index != value) {
      widget.onChanged(value);
      setState(() {
        _index = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Row(
      children: [
        _Filter(
          key: const ValueKey("BuysAndSells"),
          topColor: palette.sellButtonColor,
          bottomColor: palette.buyButtonColor,
          onPressed: () => _setIndex(0),
          selected: _index == 0,
        ),
        const Gap(4),
        _Filter(
          key: const ValueKey("BuysOnly"),
          bottomColor: palette.buyButtonColor,
          onPressed: () => _setIndex(1),
          selected: _index == 1,
        ),
        const Gap(4),
        _Filter(
          key: const ValueKey("SellsOnly"),
          topColor: palette.sellButtonColor,
          onPressed: () => _setIndex(2),
          selected: _index == 2,
        ),
      ],
    );
  }
}

class _Filter extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? topColor;
  final Color? bottomColor;
  final bool selected;

  const _Filter({
    super.key,
    required this.onPressed,
    this.selected = false,
    this.topColor,
    this.bottomColor,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: selected ? palette.dropDownBackgroundColor : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Line(color: topColor ?? palette.filterLineColor),
            _Line(color: palette.filterLineColor),
            _Line(color: bottomColor ?? palette.filterLineColor),
          ],
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  final Color color;
  const _Line({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      height: 2,
      width: 12,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
