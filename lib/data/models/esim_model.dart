enum EsimStatus { active, readyToInstall, expired }

class EsimModel {
  final String id;
  final String title;
  final String country;
  final String isoCode;
  final EsimStatus status;
  final double dataUsedGb;
  final double totalDataGb;
  final bool isUnlimited;
  final int daysRemaining;
  final String iccid;
  final String qrCodeData;
  final String activatedDate;
  
  // Security & Network Tools
  final bool adBlockerEnabled;
  final bool safeBrowsingEnabled;
  final bool virtualLocationEnabled;
  final String virtualLocationCountry;
  final bool parentalControlEnabled;

  const EsimModel({
    required this.id,
    required this.title,
    required this.country,
    required this.isoCode,
    required this.status,
    required this.dataUsedGb,
    required this.totalDataGb,
    required this.isUnlimited,
    required this.daysRemaining,
    required this.iccid,
    required this.qrCodeData,
    required this.activatedDate,
    this.adBlockerEnabled = true,
    this.safeBrowsingEnabled = true,
    this.virtualLocationEnabled = false,
    this.virtualLocationCountry = 'United States',
    this.parentalControlEnabled = false,
  });

  EsimModel copyWith({
    String? id,
    String? title,
    String? country,
    String? isoCode,
    EsimStatus? status,
    double? dataUsedGb,
    double? totalDataGb,
    bool? isUnlimited,
    int? daysRemaining,
    String? iccid,
    String? qrCodeData,
    String? activatedDate,
    bool? adBlockerEnabled,
    bool? safeBrowsingEnabled,
    bool? virtualLocationEnabled,
    String? virtualLocationCountry,
    bool? parentalControlEnabled,
  }) {
    return EsimModel(
      id: id ?? this.id,
      title: title ?? this.title,
      country: country ?? this.country,
      isoCode: isoCode ?? this.isoCode,
      status: status ?? this.status,
      dataUsedGb: dataUsedGb ?? this.dataUsedGb,
      totalDataGb: totalDataGb ?? this.totalDataGb,
      isUnlimited: isUnlimited ?? this.isUnlimited,
      daysRemaining: daysRemaining ?? this.daysRemaining,
      iccid: iccid ?? this.iccid,
      qrCodeData: qrCodeData ?? this.qrCodeData,
      activatedDate: activatedDate ?? this.activatedDate,
      adBlockerEnabled: adBlockerEnabled ?? this.adBlockerEnabled,
      safeBrowsingEnabled: safeBrowsingEnabled ?? this.safeBrowsingEnabled,
      virtualLocationEnabled: virtualLocationEnabled ?? this.virtualLocationEnabled,
      virtualLocationCountry: virtualLocationCountry ?? this.virtualLocationCountry,
      parentalControlEnabled: parentalControlEnabled ?? this.parentalControlEnabled,
    );
  }
}
