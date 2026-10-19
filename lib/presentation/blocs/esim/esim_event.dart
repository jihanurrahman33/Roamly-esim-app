abstract class EsimEvent {}

class LoadEsimsEvent extends EsimEvent {}

class ToggleEsimToolEvent extends EsimEvent {
  final String esimId;
  final bool? adBlocker;
  final bool? safeBrowsing;
  final bool? virtualLocation;
  final bool? parentalControl;

  ToggleEsimToolEvent({
    required this.esimId,
    this.adBlocker,
    this.safeBrowsing,
    this.virtualLocation,
    this.parentalControl,
  });
}
