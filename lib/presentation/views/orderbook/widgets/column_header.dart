import 'package:flutter/material.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class ColumnHeader extends StatelessWidget {
  const ColumnHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _ColumnItem(
            title: "Price",
            subtitle: "USDT",
          ),
        ),
        Spacer(),
        Expanded(
          child: _ColumnItem(
            title: "Amounts",
            subtitle: "BTC",
          ),
        ),
        Spacer(),
        Expanded(
          child: _ColumnItem(
            title: "Total",
          ),
        ),
      ],
    );
  }
}

class _ColumnItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ColumnItem({
    super.key,
    required this.title,
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.secondary,
        ),
        CustomText(
          text: subtitle.isNotEmpty ? "($subtitle)" : " ",
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}
