import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/loyalty_repository.dart';
import 'loyalty_event.dart';
import 'loyalty_state.dart';

class LoyaltyBloc extends Bloc<LoyaltyEvent, LoyaltyState> {
  final LoyaltyRepository loyaltyRepository;

  LoyaltyBloc({required this.loyaltyRepository}) : super(LoyaltyInitial()) {
    on<LoadLoyaltyEvent>(_onLoadLoyalty);
  }

  Future<void> _onLoadLoyalty(LoadLoyaltyEvent event, Emitter<LoyaltyState> emit) async {
    emit(LoyaltyLoading());
    try {
      final loyalty = await loyaltyRepository.getLoyalty();
      emit(LoyaltyLoaded(loyalty));
    } catch (e) {
      emit(LoyaltyError(e.toString()));
    }
  }
}
