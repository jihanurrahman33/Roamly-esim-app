enum OrderStatus { completed, refunded, pending }

class OrderModel {
  final String id;
  final String date;
  final String itemTitle;
  final String isoCode;
  final int days;
  final double amount;
  final String currency;
  final OrderStatus status;
  final String receiptId;

  const OrderModel({
    required this.id,
    required this.date,
    required this.itemTitle,
    required this.isoCode,
    required this.days,
    required this.amount,
    required this.currency,
    required this.status,
    required this.receiptId,
  });
}
