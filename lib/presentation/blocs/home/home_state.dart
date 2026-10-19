import '../../../data/models/destination_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<DestinationModel> popularDestinations;
  final List<DestinationModel> filteredDestinations;
  final String selectedRegion;
  final String searchQuery;

  HomeLoaded({
    required this.popularDestinations,
    required this.filteredDestinations,
    this.selectedRegion = 'All',
    this.searchQuery = '',
  });

  HomeLoaded copyWith({
    List<DestinationModel>? popularDestinations,
    List<DestinationModel>? filteredDestinations,
    String? selectedRegion,
    String? searchQuery,
  }) {
    return HomeLoaded(
      popularDestinations: popularDestinations ?? this.popularDestinations,
      filteredDestinations: filteredDestinations ?? this.filteredDestinations,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
