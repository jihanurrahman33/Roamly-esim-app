import '../../../data/models/destination_model.dart';
import '../../../data/models/order_model.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutReady extends CheckoutState {
  final DestinationModel destination;
  final int days;
  final double basePrice;
  final bool useCoins;
  final double coinsDiscount;
  final String paymentMethod; // 'apple_pay', 'google_pay', 'credit_card', 'paypal'
  final bool isProcessing;

  CheckoutReady({
    required this.destination,
    required this.days,
    required this.basePrice,
    this.useCoins = false,
    this.coinsDiscount = 3.0,
    this.paymentMethod = 'credit_card',
    this.isProcessing = false,
  });

  double get totalPrice => (basePrice - (useCoins ? coinsDiscount : 0.0)).clamp(1.0, 9999.0);

  CheckoutReady copyWith({
    DestinationModel? destination,
    int? days,
    double? basePrice,
    bool? useCoins,
    double? coinsDiscount,
    String? paymentMethod,
    bool? isProcessing,
  }) {
    return CheckoutReady(
      destination: destination ?? this.destination,
      days: days ?? this.days,
      basePrice: basePrice ?? this.basePrice,
      useCoins: useCoins ?? this.useCoins,
      coinsDiscount: coinsDiscount ?? this.coinsDiscount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

class CheckoutSuccess extends CheckoutState {
  final OrderModel order;
  CheckoutSuccess(this.order);
}

class CheckoutFailure extends CheckoutState {
  final String error;
  CheckoutFailure(this.error);
}
