class AppAssets {
  // Base Directories
  static const String flagsPath = 'assets/flags/';
  static const String iconsPath = 'assets/icons/';
  static const String logosPath = 'assets/logos/';
  static const String imagesPath = 'assets/images/';

  // Logos
  static const String roamlyLogo = '${logosPath}logo_roamly.png';
  static const String applePay = '${logosPath}logo_apple_pay.png';
  static const String googlePay = '${logosPath}logo_google_pay.png';
  static const String paypal = '${logosPath}logo_paypal.png';
  static const String visa = '${logosPath}logo_visa.svg';
  static const String mastercard = '${logosPath}logo_master_card.svg';

  // Loyalty & Coins
  static const String roamcoin = '${iconsPath}ic_roamcoin.png';
  static const String roamcoinsStack = '${iconsPath}ic_roamcoins_stack.png';
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
