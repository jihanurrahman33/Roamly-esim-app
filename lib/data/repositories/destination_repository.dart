import '../models/destination_model.dart';

class DestinationRepository {
  final List<DestinationModel> _destinations = const [
    DestinationModel(
      id: 'dest_usa',
      name: 'United States',
      isoCode: 'us',
      region: 'Americas',
      startingPrice: 6.00,
      isPopular: true,
      coverageDetails: 'Unlimited 5G/4G on AT&T and T-Mobile networks with nationwide coverage.',
    ),
    DestinationModel(
      id: 'dest_jp',
      name: 'Japan',
      isoCode: 'jp',
      region: 'Asia',
      startingPrice: 6.90,
      isPopular: true,
      coverageDetails: 'Ultra-fast Docomo & SoftBank networks across Tokyo, Osaka, Kyoto, and Hokkaido.',
    ),
    DestinationModel(
      id: 'dest_eu',
      name: 'Europe (32 Countries)',
      isoCode: 'eu',
      region: 'Europe',
      startingPrice: 19.00,
      isPopular: true,
      isRegional: true,
      coverageDetails: 'Single eSIM covering France, Germany, Italy, Spain, Switzerland, and 27 more countries.',
    ),
    DestinationModel(
      id: 'dest_gb',
      name: 'United Kingdom',
      isoCode: 'gb',
      region: 'Europe',
      startingPrice: 6.00,
      isPopular: true,
      coverageDetails: 'High-speed 4G/5G coverage on EE and Vodafone UK networks.',
    ),
    DestinationModel(
      id: 'dest_tr',
      name: 'Turkey',
      isoCode: 'tr',
      region: 'Europe',
      startingPrice: 6.00,
      isPopular: true,
      coverageDetails: 'Turkcell and Vodafone Turkey coverage in Istanbul, Antalya, and Cappadocia.',
    ),
    DestinationModel(
      id: 'dest_th',
      name: 'Thailand',
      isoCode: 'th',
      region: 'Asia',
      startingPrice: 5.90,
      isPopular: true,
      coverageDetails: 'TrueMove H and AIS networks covering Bangkok, Phuket, Chiang Mai, and islands.',
    ),
    DestinationModel(
      id: 'dest_ch',
      name: 'Switzerland',
      isoCode: 'ch',
      region: 'Europe',
      startingPrice: 6.00,
      isPopular: false,
      coverageDetails: 'Swisscom and Sunrise coverage across Zurich, Geneva, and the Alps.',
    ),
    DestinationModel(
      id: 'dest_mx',
      name: 'Mexico',
      isoCode: 'mx',
      region: 'Americas',
      startingPrice: 8.00,
      isPopular: true,
      coverageDetails: 'Telcel and AT&T Mexico coverage with seamless roaming across all 32 states.',
    ),
    DestinationModel(
      id: 'dest_ca',
      name: 'Canada',
      isoCode: 'ca',
      region: 'Americas',
      startingPrice: 7.00,
      isPopular: false,
      coverageDetails: 'Rogers and Bell networks in Toronto, Vancouver, Montreal, and Calgary.',
    ),
    DestinationModel(
      id: 'dest_kr',
      name: 'South Korea',
      isoCode: 'kr',
      region: 'Asia',
      startingPrice: 6.90,
      isPopular: false,
      coverageDetails: 'SK Telecom and KT 5G networks in Seoul, Busan, and Jeju.',
    ),
  ];

  Future<List<DestinationModel>> getDestinations({String query = '', String region = 'All'}) async {
    // Simulating light async repository call
    await Future.delayed(const Duration(milliseconds: 150));
    return _destinations.where((d) {
      final matchesQuery = query.isEmpty ||
          d.name.toLowerCase().contains(query.toLowerCase()) ||
          d.isoCode.toLowerCase().contains(query.toLowerCase());
      final matchesRegion = region == 'All' || d.region == region;
      return matchesQuery && matchesRegion;
    }).toList();
  }

  Future<List<DestinationModel>> getPopularDestinations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _destinations.where((d) => d.isPopular).toList();
  }

  Future<DestinationModel?> getDestinationById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _destinations.firstWhere((d) => d.id == id, orElse: () => _destinations.first);
  }
}
