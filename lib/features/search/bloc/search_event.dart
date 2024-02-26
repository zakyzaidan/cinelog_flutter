part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchInitialEvent extends SearchEvent {
  final ListMovies resultsMovies;

  SearchInitialEvent({required this.resultsMovies});
}

final class SearchNavigateToOtherPageEvent extends SearchEvent {
  final int page;
  final String query;

  SearchNavigateToOtherPageEvent({required this.page, required this.query});
}
