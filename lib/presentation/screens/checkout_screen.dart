import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/destination_model.dart';
import '../../data/repositories/order_repository.dart';
import '../blocs/checkout/checkout_bloc.dart';
import '../blocs/checkout/checkout_event.dart';
import '../blocs/checkout/checkout_state.dart';
import '../blocs/orders/orders_bloc.dart';
import '../blocs/orders/orders_event.dart';

class CheckoutScreen extends StatelessWidget {
  final DestinationModel destination;
  final int days;
  final double price;

  const CheckoutScreen({
    super.key,
    required this.destination,
    required this.days,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutBloc(
        orderRepository: context.read<OrderRepository>(),
      )..add(InitCheckoutEvent(
          destination: destination,
          days: days,
          basePrice: price,
        )),
      child: const _CheckoutView(),
    );
  }
}

class _CheckoutView extends StatelessWidget {
  const _CheckoutView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutSuccess) {
            // Refresh orders list
            context.read<OrdersBloc>().add(LoadOrdersEvent());

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.success, size: 64),
                    const SizedBox(height: 16),
                    const Text(
                      'Payment Successful!',
                      style: TextStyle(
                        fontFamily: 'ModernEra',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your eSIM (${state.order.itemTitle}) is ready to install in My eSIMs.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'ModernEra',
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx); // Close dialog
                          Navigator.pop(context); // Close checkout
                          Navigator.pop(context); // Close PDP
                        },
                        child: const Text('Go to My eSIMs'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is CheckoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment failed: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is CheckoutReady) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                // Order Item Summary
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          AppAssets.flag(state.destination.isoCode),
                          width: 48,
                          height: 34,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            width: 48,
                            height: 34,
                            color: AppColors.primaryLight,
                            child: const Icon(Icons.public, color: AppColors.primary),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.destination.name,
                              style: const TextStyle(
                                fontFamily: 'ModernEra',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${state.days} Days • Unlimited Data',
                              style: const TextStyle(
                                fontFamily: 'ModernEra',
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${state.basePrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontFamily: 'ModernEra',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // RoamCoins Discount Toggle
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: state.useCoins ? AppColors.roamcoinGold : AppColors.border,
                      width: state.useCoins ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppAssets.roamcoin,
                        width: 32,
                        height: 32,
                        errorBuilder: (_, _, _) => const Icon(Icons.monetization_on, color: AppColors.roamcoinGold),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Apply 300 RoamCoins',
                              style: TextStyle(
                                fontFamily: 'ModernEra',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Save \$3.00 USD on this purchase',
                              style: TextStyle(
                                fontFamily: 'ModernEra',
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch.adaptive(
                        value: state.useCoins,
                        activeTrackColor: AppColors.roamcoinGold,
                        onChanged: (val) {
                          context.read<CheckoutBloc>().add(ToggleCoinsDiscountEvent(val));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Payment Method Selector
                const Text(
                  'Select Payment Method',
                  style: TextStyle(
                    fontFamily: 'ModernEra',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                _buildPaymentMethodTile(
                  context,
                  id: 'credit_card',
                  title: 'Credit or Debit Card',
                  subtitle: 'Visa, Mastercard, Amex',
                  iconWidget: const Icon(Icons.credit_card, color: AppColors.textPrimary),
                  selected: state.paymentMethod == 'credit_card',
                ),
                _buildPaymentMethodTile(
                  context,
                  id: 'google_pay',
                  title: 'Google Pay',
                  subtitle: 'Fast and secure checkout',
                  iconWidget: Image.asset(AppAssets.googlePay, width: 28, errorBuilder: (_, _, _) => const Icon(Icons.payment)),
                  selected: state.paymentMethod == 'google_pay',
                ),
                _buildPaymentMethodTile(
                  context,
                  id: 'paypal',
                  title: 'PayPal',
                  subtitle: 'Safe digital wallet payment',
                  iconWidget: Image.asset(AppAssets.paypal, width: 28, errorBuilder: (_, _, _) => const Icon(Icons.account_balance_wallet)),
                  selected: state.paymentMethod == 'paypal',
                ),
                const SizedBox(height: 20),

                // Order Breakdown
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _buildRow('Subtotal', '\$${state.basePrice.toStringAsFixed(2)}'),
                      if (state.useCoins) ...[
                        const SizedBox(height: 8),
                        _buildRow('RoamCoins Discount', '-\$${state.coinsDiscount.toStringAsFixed(2)}', isDiscount: true),
                      ],
                      const SizedBox(height: 8),
                      _buildRow('Taxes & Fees', '\$0.00'),
                      const Divider(height: 20, color: AppColors.borderLight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontFamily: 'ModernEra',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            '\$${state.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontFamily: 'ModernEra',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Pay Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: state.isProcessing
                        ? null
                        : () {
                            context.read<CheckoutBloc>().add(ProcessPaymentEvent());
                          },
                    child: state.isProcessing
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                          )
                        : Text('Pay \$${state.totalPrice.toStringAsFixed(2)}'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildPaymentMethodTile(
    BuildContext context, {
    required String id,
    required String title,
    required String subtitle,
    required Widget iconWidget,
    required bool selected,
  }) {
    return GestureDetector(
      onTap: () {
        context.read<CheckoutBloc>().add(SelectPaymentMethodEvent(id));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: iconWidget),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'ModernEra',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'ModernEra',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppColors.primary : AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'ModernEra',
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'ModernEra',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDiscount ? AppColors.success : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
