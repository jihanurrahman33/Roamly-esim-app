import '../models/esim_model.dart';

class EsimRepository {
  final List<EsimModel> _esims = [
    const EsimModel(
      id: 'esim_101',
      title: 'Japan 15 Days Unlimited',
      country: 'Japan',
      isoCode: 'jp',
      status: EsimStatus.active,
      dataUsedGb: 4.8,
      totalDataGb: 0.0,
      isUnlimited: true,
      daysRemaining: 11,
      iccid: '8981240019283746192',
      qrCodeData: 'LPA:1\$smdp.roamly.com\$RM-9284-1829-4829',
      activatedDate: '15 Oct 2026',
      adBlockerEnabled: true,
      safeBrowsingEnabled: true,
      virtualLocationEnabled: true,
      virtualLocationCountry: 'Tokyo, Japan',
    ),
    const EsimModel(
      id: 'esim_102',
      title: 'United States 5 Days',
      country: 'United States',
      isoCode: 'us',
      status: EsimStatus.readyToInstall,
      dataUsedGb: 0.0,
      totalDataGb: 0.0,
      isUnlimited: true,
      daysRemaining: 5,
      iccid: '8981240059381726391',
      qrCodeData: 'LPA:1\$smdp.roamly.com\$RM-1102-4820-9912',
      activatedDate: 'Not activated',
      adBlockerEnabled: false,
      safeBrowsingEnabled: true,
      virtualLocationEnabled: false,
    ),
    const EsimModel(
      id: 'esim_103',
      title: 'Europe 10 Days',
      country: 'Europe (32 Countries)',
      isoCode: 'eu',
      status: EsimStatus.expired,
      dataUsedGb: 14.2,
      totalDataGb: 0.0,
      isUnlimited: true,
      daysRemaining: 0,
      iccid: '8981240081726354182',
      qrCodeData: 'LPA:1\$smdp.roamly.com\$RM-8374-2910-1092',
      activatedDate: '01 Sep 2026',
    ),
  ];

  Future<List<EsimModel>> getEsims() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(_esims);
  }

  Future<EsimModel?> toggleTool({
    required String esimId,
    bool? adBlocker,
    bool? safeBrowsing,
    bool? virtualLocation,
    bool? parentalControl,
  }) async {
    final index = _esims.indexWhere((e) => e.id == esimId);
    if (index == -1) return null;

    final current = _esims[index];
    final updated = current.copyWith(
      adBlockerEnabled: adBlocker ?? current.adBlockerEnabled,
      safeBrowsingEnabled: safeBrowsing ?? current.safeBrowsingEnabled,
      virtualLocationEnabled: virtualLocation ?? current.virtualLocationEnabled,
      parentalControlEnabled: parentalControl ?? current.parentalControlEnabled,
    );

    _esims[index] = updated;
    return updated;
  }
}
