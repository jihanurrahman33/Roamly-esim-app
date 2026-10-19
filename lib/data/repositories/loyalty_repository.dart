import '../models/loyalty_model.dart';

class LoyaltyRepository {
  final LoyaltyModel _loyalty = const LoyaltyModel(
    tier: LoyaltyTier.gold,
    points: 420,
    cashbackRate: 0.05,
    pointsToNextTier: 180,
    referralCode: 'ROAM-NISHAK-72',
    referralDiscount: 3.0,
  );

  Future<LoyaltyModel> getLoyalty() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _loyalty;
  }
}
