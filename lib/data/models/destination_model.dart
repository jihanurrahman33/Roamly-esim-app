class DestinationModel {
  final String id;
  final String name;
  final String isoCode;
  final String region;
  final double startingPrice;
  final String currency;
  final bool isPopular;
  final bool isRegional;
  final List<String> features;
  final String coverageDetails;

  const DestinationModel({
    required this.id,
    required this.name,
    required this.isoCode,
    required this.region,
    required this.startingPrice,
    this.currency = 'USD',
    this.isPopular = false,
    this.isRegional = false,
    this.features = const [
      'Unlimited Data',
      'Keep your WhatsApp number',
      '500MB daily hotspot tethering',
      '24/7 Customer Support',
    ],
    this.coverageDetails = 'Connects to top-tier local 4G/5G carriers automatically with zero roaming charges.',
  });
}
