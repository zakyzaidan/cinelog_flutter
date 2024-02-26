part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

abstract class SearchActionState extends SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchErrorState extends SearchState {}

final class SearchInitialFoundQueryState extends SearchState {
  final ListMovies resultSearchQuery;

  SearchInitialFoundQueryState({required this.resultSearchQuery});
}

final class SearchInitialNotFoundQueryState extends SearchState {}

final class SearchNavigateToOtherPageActionState extends SearchActionState {
  final String searchQuery;
  final ListMovies resultsMovies;

  SearchNavigateToOtherPageActionState(
      {required this.resultsMovies, required this.searchQuery});
}
