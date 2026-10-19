import '../../../data/models/loyalty_model.dart';

abstract class LoyaltyState {}

class LoyaltyInitial extends LoyaltyState {}

class LoyaltyLoading extends LoyaltyState {}

class LoyaltyLoaded extends LoyaltyState {
  final LoyaltyModel loyalty;
  LoyaltyLoaded(this.loyalty);
}

class LoyaltyError extends LoyaltyState {
  final String message;
  LoyaltyError(this.message);
}
