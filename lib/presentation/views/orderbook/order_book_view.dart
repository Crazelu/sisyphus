import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/models/order.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/column_header.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/filter_row.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/order_table.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/price_bar.dart';
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
              FilterRow(
                onChanged: (value) {},
              ),
              const Spacer(),
              TransactionCountDropDown(
                counts: const [10, 20, 50],
                onChanged: (value) {},
              ),
            ],
          ),
          const Gap(24),
          const ColumnHeader(),
          const Gap(12),
          OrderTable(
            orders: List.generate(
              5,
              (index) => Order(
                price: "36920.12",
                amount: "0.758965",
                total: "28,020.98",
                isBuy: false,
              ),
            ),
          ),
          const Gap(16),
          const Pricebar(oldPrice: 36641.20, newPrice: 38641.20),
          const Gap(28),
          OrderTable(
            orders: List.generate(
              5,
              (index) => Order(
                price: "36920.12",
                amount: "0.758965",
                total: "28,020.98",
                isBuy: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
