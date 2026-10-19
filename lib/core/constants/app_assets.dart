class AppAssets {
  // Base Directories
  static const String flagsPath = 'assets/packages/flutter_multi_formatter/flags/png/';
  static const String iconsPath = 'assets/assets/icons/';
  static const String logosPath = 'assets/assets/logos/';

  // Logos
  static const String roamlyLogo = '${logosPath}logotype_holafly.png';
  static const String holaflyLogo = roamlyLogo;
  static const String applePay = '${logosPath}logo_apple_pay.png';
  static const String googlePay = '${logosPath}logo_google_pay.png';
  static const String paypal = '${logosPath}logo_paypal.png';
  static const String visa = '${logosPath}logo_visa.svg';
  static const String mastercard = '${logosPath}logo_master_card.svg';

  // Loyalty & Coins
  static const String roamcoin = '${iconsPath}ic_holacoin.png';
  static const String roamcoinsStack = '${iconsPath}ic_holacoins_stack.png';
  static const String holacoin = roamcoin;
  static const String holacoinsStack = roamcoinsStack;
  static const String silverTier = '${iconsPath}ic_tiers-level-silver.png';
  static const String goldTier = '${iconsPath}ic_tiers-level-gold.png';
  static const String platinumTier = '${iconsPath}ic_tiers-level-platinum.png';

  // Regions
  static const String regionEurope = '${iconsPath}ic_region_europe.svg';
  static const String regionLatam = '${iconsPath}ic_region_latam.svg';

  // Helper for flag
  static String flag(String isoCode) {
    return '$flagsPath${isoCode.toLowerCase()}.png';
  }
}
