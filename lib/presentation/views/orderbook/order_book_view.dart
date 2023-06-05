import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/filter_row.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/transaction_count_drop_down.dart';

class OrderBookView extends StatelessWidget {
  const OrderBookView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Gap(24),
          Row(
            children: [
              const FilterRow(),
              const Spacer(),
              TransactionCountDropDown(
                counts: const [10, 20, 50],
                onChanged: (value) {},
              ),
            ],
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
