import 'package:flutter/material.dart';
import 'package:sissyphus/models/order.dart';
import 'package:sissyphus/presentation/theme/palette.dart';
import 'package:sissyphus/presentation/widgets/custom_text.dart';

class OrderTable extends StatelessWidget {
  final List<Order> orders;

  const OrderTable({
    super.key,
    this.orders = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var order in orders) _OrderRow(order: order),
      ],
    );
  }
}

class _OrderRow extends StatelessWidget {
  final Order order;
  const _OrderRow({
    super.key,
    required this.order,
  });

  List<String> get _items => [order.price, order.amount, order.total];

  @override
  Widget build(BuildContext context) {
    Color color(int index) {
      if (index != 0) return Theme.of(context).colorScheme.primary;

      final palette = Theme.of(context).extension<Palette>()!;
      if (order.isBuy) return palette.buyButtonColor;
      return palette.sellPriceColor;
    }

    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          for (int i = 0; i < _items.length; i++)
            SizedBox(
              width: width / 3.3,
              child: CustomText(
                text: _items[i],
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color(i),
                textAlign: i == 1
                    ? TextAlign.center
                    : i == 2
                        ? TextAlign.end
                        : TextAlign.left,
              ),
            ),
        ],
      ),
    );
  }
}
