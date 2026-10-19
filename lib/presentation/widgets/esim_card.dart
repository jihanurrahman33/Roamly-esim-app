import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/esim_model.dart';

class EsimCard extends StatelessWidget {
  final EsimModel esim;
  final VoidCallback onShowQr;
  final VoidCallback onToggleTools;

  const EsimCard({
    super.key,
    required this.esim,
    required this.onShowQr,
    required this.onToggleTools,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = esim.status == EsimStatus.active;
    final bool isReady = esim.status == EsimStatus.readyToInstall;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? AppColors.primary.withValues(alpha: 0.3) : AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    AppAssets.flag(esim.isoCode),
                    width: 40,
                    height: 28,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 40,
                      height: 28,
                      color: AppColors.primaryLight,
                      child: const Icon(Icons.public, color: AppColors.primary, size: 18),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        esim.title,
                        style: const TextStyle(
                          fontFamily: 'ModernEra',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ICCID: ${esim.iccid}',
                        style: const TextStyle(
                          fontFamily: 'ModernEra',
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.successLight
                        : isReady
                            ? AppColors.primaryLight
                            : AppColors.borderLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isActive
                        ? 'ACTIVE'
                        : isReady
                            ? 'READY'
                            : 'EXPIRED',
                    style: TextStyle(
                      fontFamily: 'ModernEra',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isActive
                          ? AppColors.success
                          : isReady
                              ? AppColors.primary
                              : AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.borderLight),

          // Stats Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('Data', esim.isUnlimited ? 'Unlimited' : '${esim.totalDataGb} GB', Icons.wifi),
                _buildStat('Validity', '${esim.daysRemaining} Days left', Icons.timer_outlined),
                _buildStat('Network', '4G / 5G LTE', Icons.signal_cellular_alt),
              ],
            ),
          ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onShowQr,
                    icon: const Icon(Icons.qr_code, size: 18),
                    label: const Text('View QR Code'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.border),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onToggleTools,
                    icon: const Icon(Icons.shield_outlined, size: 18),
                    label: const Text('Security Tools'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'ModernEra',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'ModernEra',
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
