import 'package:sissyphus/utils/parser_util.dart';

class Order {
  late final String price;
  late final String amount;
  late final String total;
  final bool isBuy;

  Order({
    required String price,
    required String amount,
    required String total,
    required this.isBuy,
  }) {
    this.price = ParserUtil.clampDigits(price);
    this.amount = ParserUtil.clampDigits(amount);
    this.total = ParserUtil.clampDigits(total);
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    final priceValue = double.tryParse(json["p"]) ?? 0;
    final amountValue = double.tryParse(json["q"]) ?? 0;
    return Order(
      price: ParserUtil.clampDigits(json["p"]),
      amount: ParserUtil.clampDigits(json["q"]),
      total: ParserUtil.clampDigits((priceValue * amountValue).toString()),
      isBuy: json["m"] ?? false,
    );
  }
}
