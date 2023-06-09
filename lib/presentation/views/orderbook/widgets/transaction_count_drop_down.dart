import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class TransactionCountDropDown<T> extends StatefulWidget {
  final List<T> counts;
  final Function(T) onChanged;

  const TransactionCountDropDown({
    super.key,
    required this.counts,
    required this.onChanged,
  });

  @override
  State<TransactionCountDropDown<T>> createState() =>
      _TransactionCountDropDownState<T>();
}

class _TransactionCountDropDownState<T>
    extends State<TransactionCountDropDown<T>> {
  T? _selected;

  @override
  void initState() {
    super.initState();
    if (widget.counts.isNotEmpty) _selected = widget.counts.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<Palette>()!.dropDownBackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<T>(
        dropdownColor: Theme.of(context).extension<Palette>()!.cardColor,
        underline: const SizedBox(),
        icon: Padding(
          padding: const EdgeInsets.only(left: 8, right: 4),
          child: CustomIcon(
            iconPath: AppAssets.dropDown,
            width: 8,
            height: 9,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        value: _selected,
        items: [
          for (final item in widget.counts)
            DropdownMenuItem(
              value: item,
              child: CustomText(
                text: "$item",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )
        ],
        onChanged: (value) {
          if (value != null) {
            widget.onChanged.call(value);
          }

          setState(() {
            _selected = value;
          });
        },
      ),
    );
  }
}
