import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:sissyphus/presentation/views/orderbook/order_book_view_model.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/column_header.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/filter_row.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/order_table.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/price_bar.dart';
import 'package:sissyphus/presentation/views/orderbook/widgets/transaction_count_drop_down.dart';
import 'package:sissyphus/presentation/widgets/reactive_builder.dart';

class OrderBookView extends StatefulWidget {
  const OrderBookView({super.key});

  @override
  State<OrderBookView> createState() => _OrderBookViewState();
}

class _OrderBookViewState extends State<OrderBookView> {
  final _counts = [5, 10, 20, 50];
  late int _limit = _counts.first;

  bool _showSells = true;
  bool _showBuys = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer(builder: (context, ref, _) {
        return Column(
          children: [
            const Gap(24),
            Row(
              children: [
                FilterRow(
                  onChanged: (value) {
                    setState(() {
                      _showSells = value == 0 || value == 2;
                      _showBuys = value == 0 || value == 1;
                    });
                  },
                ),
                const Spacer(),
                TransactionCountDropDown(
                  counts: _counts,
                  onChanged: (value) {
                    if (value != _limit) {
                      setState(() {
                        _limit = value;
                      });
                    }
                  },
                ),
              ],
            ),
            const Gap(24),
            const ColumnHeader(),
            const Gap(12),
            if (_showSells)
              ReactiveBuilder(
                value: ref.read(orderBookViewModelProvider).sellOrders,
                builder: (orders) {
                  return OrderTable(
                    orders: orders.take(_limit),
                  );
                },
              ),
            const Gap(16),
            if (_showSells && _showBuys) ...{
              ReactiveBuilder(
                value: ref.read(orderBookViewModelProvider).prices,
                builder: (prices) {
                  return Pricebar(
                    oldPrice: prices.last,
                    newPrice: prices.first,
                  );
                },
              ),
              const Gap(28),
            },
            if (_showBuys) ...{
              ReactiveBuilder(
                value: ref.read(orderBookViewModelProvider).buyOrders,
                builder: (orders) {
                  return OrderTable(
                    orders: orders.take(_limit),
                  );
                },
              ),
              const Gap(16),
            },
          ],
        );
      }),
    );
  }
}
