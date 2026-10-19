enum LoyaltyTier { silver, gold, platinum }

class LoyaltyModel {
  final LoyaltyTier tier;
  final int points;
  final double cashbackRate;
  final int pointsToNextTier;
  final String referralCode;
  final double referralDiscount;

  const LoyaltyModel({
    required this.tier,
    required this.points,
    required this.cashbackRate,
    required this.pointsToNextTier,
    required this.referralCode,
    this.referralDiscount = 3.0,
  });

  String get tierName {
    switch (tier) {
      case LoyaltyTier.silver:
        return 'Silver';
      case LoyaltyTier.gold:
        return 'Gold';
      case LoyaltyTier.platinum:
        return 'Platinum';
    }
  }

  double get cashbackPercentage => cashbackRate * 100;
}
