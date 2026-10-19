abstract class HomeEvent {}

class LoadHomeEvent extends HomeEvent {}

class SearchDestinationEvent extends HomeEvent {
  final String query;
  SearchDestinationEvent(this.query);
}

class FilterRegionEvent extends HomeEvent {
  final String region;
  FilterRegionEvent(this.region);
}
