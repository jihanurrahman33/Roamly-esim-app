import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/destination_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DestinationRepository destinationRepository;

  HomeBloc({required this.destinationRepository}) : super(HomeInitial()) {
    on<LoadHomeEvent>(_onLoadHome);
    on<SearchDestinationEvent>(_onSearchDestination);
    on<FilterRegionEvent>(_onFilterRegion);
  }

  Future<void> _onLoadHome(LoadHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final popular = await destinationRepository.getPopularDestinations();
      final all = await destinationRepository.getDestinations();
      emit(HomeLoaded(
        popularDestinations: popular,
        filteredDestinations: all,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onSearchDestination(SearchDestinationEvent event, Emitter<HomeState> emit) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final filtered = await destinationRepository.getDestinations(
        query: event.query,
        region: currentState.selectedRegion,
      );
      emit(currentState.copyWith(
        filteredDestinations: filtered,
        searchQuery: event.query,
      ));
    }
  }

  Future<void> _onFilterRegion(FilterRegionEvent event, Emitter<HomeState> emit) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      final filtered = await destinationRepository.getDestinations(
        query: currentState.searchQuery,
        region: event.region,
      );
      emit(currentState.copyWith(
        filteredDestinations: filtered,
        selectedRegion: event.region,
      ));
    }
  }
}
