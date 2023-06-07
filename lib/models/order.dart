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
    this.price = _takeSevenDigits(price);
    this.amount = _takeSevenDigits(amount);
    this.total = _takeSevenDigits(total);
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    final priceValue = double.tryParse(json["p"]) ?? 0;
    final amountValue = double.tryParse(json["q"]) ?? 0;
    return Order(
      price: _takeSevenDigits(json["p"]),
      amount: _takeSevenDigits(json["q"]),
      total: _takeSevenDigits((priceValue * amountValue).toString()),
      isBuy: json["m"] ?? false,
    );
  }

  static String _takeSevenDigits(String value) {
    try {
      final split = value.split('');
      String result = "";

      final splitLength = split.length;

      int length = 0;
      int index = 0;
      while (length < 7 && index <= splitLength - 1) {
        if (int.tryParse(split[index]) != null) {
          length++;
        }
        result += split[index];
        index++;
      }
      return result;
    } catch (e) {
      return value;
    }
  }
}
