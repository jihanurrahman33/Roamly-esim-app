import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/esim_repository.dart';
import 'esim_event.dart';
import 'esim_state.dart';

class EsimBloc extends Bloc<EsimEvent, EsimState> {
  final EsimRepository esimRepository;

  EsimBloc({required this.esimRepository}) : super(EsimInitial()) {
    on<LoadEsimsEvent>(_onLoadEsims);
    on<ToggleEsimToolEvent>(_onToggleEsimTool);
  }

  Future<void> _onLoadEsims(LoadEsimsEvent event, Emitter<EsimState> emit) async {
    emit(EsimLoading());
    try {
      final esims = await esimRepository.getEsims();
      emit(EsimLoaded(esims));
    } catch (e) {
      emit(EsimError(e.toString()));
    }
  }

  Future<void> _onToggleEsimTool(ToggleEsimToolEvent event, Emitter<EsimState> emit) async {
    try {
      await esimRepository.toggleTool(
        esimId: event.esimId,
        adBlocker: event.adBlocker,
        safeBrowsing: event.safeBrowsing,
        virtualLocation: event.virtualLocation,
        parentalControl: event.parentalControl,
      );
      final updated = await esimRepository.getEsims();
      emit(EsimLoaded(updated));
    } catch (e) {
      emit(EsimError(e.toString()));
    }
  }
}
