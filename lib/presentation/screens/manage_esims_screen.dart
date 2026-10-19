import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/esim_model.dart';
import '../blocs/esim/esim_bloc.dart';
import '../blocs/esim/esim_event.dart';
import '../blocs/esim/esim_state.dart';
import '../widgets/esim_card.dart';
import '../widgets/network_tool_tile.dart';
import '../widgets/qr_code_dialog.dart';

class ManageEsimsScreen extends StatelessWidget {
  const ManageEsimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My eSIMs'),
          bottom: const TabBar(
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: TextStyle(
              fontFamily: 'ModernEra',
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            tabs: [
              Tab(text: 'Active & Ready'),
              Tab(text: 'Expired'),
            ],
          ),
        ),
        body: BlocBuilder<EsimBloc, EsimState>(
          builder: (context, state) {
            if (state is EsimLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (state is EsimLoaded) {
              final activeList = [...state.activeEsims, ...state.pendingEsims];
              final expiredList = state.expiredEsims;

              return TabBarView(
                children: [
                  _buildEsimList(context, activeList, 'No active eSIMs found.'),
                  _buildEsimList(context, expiredList, 'No expired eSIMs in history.'),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildEsimList(BuildContext context, List<EsimModel> esims, String emptyMessage) {
    if (esims.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sim_card_outlined, size: 64, color: AppColors.textMuted),
            const SizedBox(height: 14),
            Text(
              emptyMessage,
              style: const TextStyle(
                fontFamily: 'ModernEra',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: esims.length,
      itemBuilder: (context, index) {
        final esim = esims[index];
        return EsimCard(
          esim: esim,
          onShowQr: () {
            showDialog(
              context: context,
              builder: (_) => QrCodeDialog(esim: esim),
            );
          },
          onToggleTools: () {
            _showSecurityToolsBottomSheet(context, esim);
          },
        );
      },
    );
  }

  void _showSecurityToolsBottomSheet(BuildContext context, EsimModel esim) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (bottomSheetCtx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.shield_outlined, color: AppColors.primary, size: 24),
                        const SizedBox(width: 10),
                        Text(
                          '${esim.country} Security Tools',
                          style: const TextStyle(
                            fontFamily: 'ModernEra',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Manage built-in network security layers on your cellular profile.',
                      style: TextStyle(
                        fontFamily: 'ModernEra',
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),

                    NetworkToolTile(
                      icon: Icons.block_flipped,
                      title: 'Ad Blocker',
                      subtitle: 'Filters intrusive banners, popups, and trackers',
                      value: esim.adBlockerEnabled,
                      onChanged: (val) {
                        context.read<EsimBloc>().add(
                              ToggleEsimToolEvent(esimId: esim.id, adBlocker: val),
                            );
                        Navigator.pop(bottomSheetCtx);
                      },
                    ),
                    NetworkToolTile(
                      icon: Icons.security,
                      title: 'Safe Browsing',
                      subtitle: 'Blocks known phishing domains and malware',
                      value: esim.safeBrowsingEnabled,
                      onChanged: (val) {
                        context.read<EsimBloc>().add(
                              ToggleEsimToolEvent(esimId: esim.id, safeBrowsing: val),
                            );
                        Navigator.pop(bottomSheetCtx);
                      },
                    ),
                    NetworkToolTile(
                      icon: Icons.vpn_lock_outlined,
                      title: 'Virtual Location (VPN)',
                      subtitle: 'Secure connection via ${esim.virtualLocationCountry}',
                      value: esim.virtualLocationEnabled,
                      onChanged: (val) {
                        context.read<EsimBloc>().add(
                              ToggleEsimToolEvent(esimId: esim.id, virtualLocation: val),
                            );
                        Navigator.pop(bottomSheetCtx);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
