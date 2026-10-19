import '../../../data/models/esim_model.dart';

abstract class EsimState {}

class EsimInitial extends EsimState {}

class EsimLoading extends EsimState {}

class EsimLoaded extends EsimState {
  final List<EsimModel> esims;
  EsimLoaded(this.esims);

  List<EsimModel> get activeEsims =>
      esims.where((e) => e.status == EsimStatus.active).toList();

  List<EsimModel> get pendingEsims =>
      esims.where((e) => e.status == EsimStatus.readyToInstall).toList();

  List<EsimModel> get expiredEsims =>
      esims.where((e) => e.status == EsimStatus.expired).toList();
}

class EsimError extends EsimState {
  final String message;
  EsimError(this.message);
}
