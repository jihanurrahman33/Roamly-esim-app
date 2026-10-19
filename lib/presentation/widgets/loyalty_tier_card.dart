import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/loyalty_model.dart';

class LoyaltyTierCard extends StatelessWidget {
  final LoyaltyModel loyalty;

  const LoyaltyTierCard({super.key, required this.loyalty});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E2129), Color(0xFF111317)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      AppAssets.goldTier,
                      width: 38,
                      height: 38,
                      errorBuilder: (_, _, _) => const Icon(Icons.workspace_premium, color: AppColors.roamcoinGold, size: 36),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${loyalty.tierName} Member',
                            style: const TextStyle(
                              fontFamily: 'ModernEra',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${loyalty.cashbackPercentage.toStringAsFixed(0)}% Cashback on all eSIM purchases',
                            style: const TextStyle(
                              fontFamily: 'ModernEra',
                              fontSize: 12,
                              color: AppColors.roamcoinGold,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Image.asset(
                AppAssets.roamcoin,
                width: 32,
                height: 32,
                errorBuilder: (_, _, _) => const Icon(Icons.monetization_on, color: AppColors.roamcoinGold),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Balance Display
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${loyalty.points}',
                style: const TextStyle(
                  fontFamily: 'ModernEra',
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'RoamCoins',
                style: TextStyle(
                  fontFamily: 'ModernEra',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.roamcoinGold,
                ),
              ),
              const Spacer(),
              Text(
                '≈ \$${(loyalty.points * 0.01).toStringAsFixed(2)} USD',
                style: const TextStyle(
                  fontFamily: 'ModernEra',
                  fontSize: 14,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress to Platinum
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Progress to Platinum Tier',
                    style: TextStyle(
                      fontFamily: 'ModernEra',
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                  Text(
                    '${loyalty.pointsToNextTier} coins needed',
                    style: const TextStyle(
                      fontFamily: 'ModernEra',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: const LinearProgressIndicator(
                  value: 0.7,
                  minHeight: 8,
                  backgroundColor: Color(0xFF2D323F),
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.roamcoinGold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
