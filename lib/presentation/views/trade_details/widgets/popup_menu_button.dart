import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/app_assets.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/widgets/custom_icon.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class CustomPopupMenuButton extends StatefulWidget {
  const CustomPopupMenuButton({super.key});

  @override
  State<CustomPopupMenuButton> createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
  late final List<String> _items = [
    "Exchange",
    "Wallets",
    "Roqqu Hub",
    "Log out",
  ];

  late String _selectedItem = _items.first;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return PopupMenuButton<String>(
      color: palette.popupMenuBackgroundColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: palette.popupMenuBorderColor,
        ),
      ),
      child: const CustomIcon(
        iconPath: AppAssets.menu,
        height: 32,
        width: 32,
      ),
      itemBuilder: (_) => [
        for (var item in _items)
          PopupMenuItem<String>(
            padding: EdgeInsets.zero,
            value: item,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 48,
              width: MediaQuery.of(context).size.width,
              color: _selectedItem == item
                  ? palette.selectedMenuItemBackgroundColor
                  : null,
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: item,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              if (_selectedItem != item) {
                setState(() {
                  _selectedItem = item;
                });
              }
            },
          ),
      ],
    );
  }
}
