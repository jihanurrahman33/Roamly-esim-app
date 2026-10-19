import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedCurrency = 'USD (\$)';
  String _selectedLanguage = 'English';
  bool _pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account & Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Profile Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primaryLight,
                  child: const Text(
                    'N',
                    style: TextStyle(
                      fontFamily: 'ModernEra',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nishak',
                        style: TextStyle(
                          fontFamily: 'ModernEra',
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'nishak@example.com',
                        style: TextStyle(
                          fontFamily: 'ModernEra',
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: AppColors.textMuted),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit profile dialog')),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Preferences
          const Text(
            'App Preferences',
            style: TextStyle(
              fontFamily: 'ModernEra',
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.attach_money,
                    title: 'Display Currency',
                    trailingText: _selectedCurrency,
                    onTap: () => _showCurrencyPicker(),
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildSettingTile(
                    icon: Icons.language,
                    title: 'Language',
                    trailingText: _selectedLanguage,
                    onTap: () => _showLanguagePicker(),
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.notifications_outlined, color: AppColors.textPrimary, size: 22),
                            SizedBox(width: 14),
                            Text(
                              'Push Notifications',
                              style: TextStyle(
                                fontFamily: 'ModernEra',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Switch.adaptive(
                          value: _pushNotifications,
                          activeTrackColor: AppColors.primary,
                          onChanged: (val) {
                            setState(() {
                              _pushNotifications = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Support & Help
          const Text(
            'Support & Legal',
            style: TextStyle(
              fontFamily: 'ModernEra',
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.chat_bubble_outline,
                    title: '24/7 Live Support Chat',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Connecting to Roamly Support Concierge...')),
                      );
                    },
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildSettingTile(
                    icon: Icons.help_outline,
                    title: 'Frequently Asked Questions',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _buildSettingTile(
                    icon: Icons.description_outlined,
                    title: 'Terms of Service & Privacy',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Version Footer
          Center(
            child: Column(
              children: const [
                Text(
                  'Roamly eSIM',
                  style: TextStyle(
                    fontFamily: 'ModernEra',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Version 4.11.0 (Build 447)',
                  style: TextStyle(
                    fontFamily: 'ModernEra',
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'ModernEra',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText,
              style: const TextStyle(
                fontFamily: 'ModernEra',
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          const SizedBox(width: 6),
          const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textMuted),
        ],
      ),
      onTap: onTap,
    );
  }

  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Select Currency',
                style: TextStyle(
                  fontFamily: 'ModernEra',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ...['USD (\$)', 'EUR (€)', 'GBP (£)', 'AUD (A\$)'].map(
              (c) => ListTile(
                title: Text(c),
                trailing: c == _selectedCurrency ? const Icon(Icons.check, color: AppColors.primary) : null,
                onTap: () {
                  setState(() => _selectedCurrency = c);
                  Navigator.pop(ctx);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Select Language',
                style: TextStyle(
                  fontFamily: 'ModernEra',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ...['English', 'Español', 'Français', 'Deutsch', 'Italiano'].map(
              (l) => ListTile(
                title: Text(l),
                trailing: l == _selectedLanguage ? const Icon(Icons.check, color: AppColors.primary) : null,
                onTap: () {
                  setState(() => _selectedLanguage = l);
                  Navigator.pop(ctx);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
