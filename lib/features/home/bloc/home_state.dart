part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final ListMovies popularMovies;
  final ListMovies topRatedMovies;

  HomeLoadedSuccessState(
      {required this.popularMovies, required this.topRatedMovies});
}

class HomeNavigateToDetailPageActionState extends HomeActionState {}

class HomeShowPopularMoviesActionState extends HomeActionState {}

class HomeNavigateToPopularPageActionState extends HomeActionState {
  final ListMovies popularListMovies;

  HomeNavigateToPopularPageActionState({required this.popularListMovies});
}

class HomeNavigateToTopRatedPageActionState extends HomeActionState {
  final ListMovies topRatedMovies;

  HomeNavigateToTopRatedPageActionState({required this.topRatedMovies});
}

class HomeNavigateToSearchPageActionState extends HomeActionState {
  final String searchQuery;
  final ListMovies searchResult;

  HomeNavigateToSearchPageActionState(
      {required this.searchResult, required this.searchQuery});
}
