import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/order_repository.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final OrderRepository orderRepository;

  CheckoutBloc({required this.orderRepository}) : super(CheckoutInitial()) {
    on<InitCheckoutEvent>(_onInitCheckout);
    on<ToggleCoinsDiscountEvent>(_onToggleCoins);
    on<SelectPaymentMethodEvent>(_onSelectMethod);
    on<ProcessPaymentEvent>(_onProcessPayment);
  }

  void _onInitCheckout(InitCheckoutEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutReady(
      destination: event.destination,
      days: event.days,
      basePrice: event.basePrice,
    ));
  }

  void _onToggleCoins(ToggleCoinsDiscountEvent event, Emitter<CheckoutState> emit) {
    final s = state;
    if (s is CheckoutReady) {
      emit(s.copyWith(useCoins: event.apply));
    }
  }

  void _onSelectMethod(SelectPaymentMethodEvent event, Emitter<CheckoutState> emit) {
    final s = state;
    if (s is CheckoutReady) {
      emit(s.copyWith(paymentMethod: event.method));
    }
  }

  Future<void> _onProcessPayment(ProcessPaymentEvent event, Emitter<CheckoutState> emit) async {
    final s = state;
    if (s is CheckoutReady) {
      emit(s.copyWith(isProcessing: true));
      await Future.delayed(const Duration(seconds: 2));

      try {
        final order = await orderRepository.createOrder(
          itemTitle: '${s.destination.name} Unlimited eSIM (${s.days} Days)',
          isoCode: s.destination.isoCode,
          days: s.days,
          amount: s.totalPrice,
          currency: s.destination.currency,
        );
        emit(CheckoutSuccess(order));
      } catch (e) {
        emit(CheckoutFailure(e.toString()));
      }
    }
  }
}
