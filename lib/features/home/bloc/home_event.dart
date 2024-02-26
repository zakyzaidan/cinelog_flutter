part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeNavigateToDetailPageEvent extends HomeEvent {}

class HomeNavigateToPopularPageEvent extends HomeEvent {
  final int page;

  HomeNavigateToPopularPageEvent({required this.page});
}

class HomeNavigateToTopRatedPageEvent extends HomeEvent {
  final int page;

  HomeNavigateToTopRatedPageEvent({required this.page});
}

class HomeNavigateToSearchPageEvent extends HomeEvent {
  final String query;

  HomeNavigateToSearchPageEvent({required this.query});
}
