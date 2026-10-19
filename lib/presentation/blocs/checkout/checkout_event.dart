import '../../../data/models/destination_model.dart';

abstract class CheckoutEvent {}

class InitCheckoutEvent extends CheckoutEvent {
  final DestinationModel destination;
  final int days;
  final double basePrice;

  InitCheckoutEvent({
    required this.destination,
    required this.days,
    required this.basePrice,
  });
}

class ToggleCoinsDiscountEvent extends CheckoutEvent {
  final bool apply;
  ToggleCoinsDiscountEvent(this.apply);
}

class SelectPaymentMethodEvent extends CheckoutEvent {
  final String method;
  SelectPaymentMethodEvent(this.method);
}

class ProcessPaymentEvent extends CheckoutEvent {}
