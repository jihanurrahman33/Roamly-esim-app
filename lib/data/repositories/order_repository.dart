import '../models/order_model.dart';

class OrderRepository {
  final List<OrderModel> _orders = [
    const OrderModel(
      id: 'ORD-98412',
      date: '15 Oct 2026',
      itemTitle: 'Japan Unlimited eSIM (15 Days)',
      isoCode: 'jp',
      days: 15,
      amount: 47.00,
      currency: 'USD',
      status: OrderStatus.completed,
      receiptId: 'REC-2026-98412',
    ),
    const OrderModel(
      id: 'ORD-76291',
      date: '10 Oct 2026',
      itemTitle: 'United States Unlimited eSIM (5 Days)',
      isoCode: 'us',
      days: 5,
      amount: 21.00,
      currency: 'USD',
      status: OrderStatus.completed,
      receiptId: 'REC-2026-76291',
    ),
    const OrderModel(
      id: 'ORD-55102',
      date: '01 Sep 2026',
      itemTitle: 'Europe (32 Countries) eSIM (10 Days)',
      isoCode: 'eu',
      days: 10,
      amount: 34.00,
      currency: 'USD',
      status: OrderStatus.completed,
      receiptId: 'REC-2026-55102',
    ),
  ];

  Future<List<OrderModel>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_orders);
  }

  Future<OrderModel> createOrder({
    required String itemTitle,
    required String isoCode,
    required int days,
    required double amount,
    String currency = 'USD',
  }) async {
    final newOrder = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      date: 'Today',
      itemTitle: itemTitle,
      isoCode: isoCode,
      days: days,
      amount: amount,
      currency: currency,
      status: OrderStatus.completed,
      receiptId: 'REC-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
    );
    _orders.insert(0, newOrder);
    return newOrder;
  }
}
