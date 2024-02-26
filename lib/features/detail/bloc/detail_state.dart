part of 'detail_bloc.dart';

@immutable
sealed class DetailState {}

final class DetailInitial extends DetailState {}

abstract class DetailActionState extends DetailState {}

final class DetailLoadedState extends DetailState {}

final class DetailErrorState extends DetailState {}

final class DetailLoadedSuccessState extends DetailState {
  final DetailMovies detailMovies;
  final ActorDetailMovies actorDetailMovies;

  DetailLoadedSuccessState(
      {required this.detailMovies, required this.actorDetailMovies});
}

final class DetailYoutubeActionState extends DetailActionState {
  final DetailMoviesYoutubeModel detailMoviesYoutubeModel;

  DetailYoutubeActionState({required this.detailMoviesYoutubeModel});
}

final class DetailAddCatalogActionState extends DetailActionState {
  final filmModelDatabase film;
  final List<catalogModelDatabase> catalogs;
  final QuerySnapshot catalogRef;

  DetailAddCatalogActionState(
      {required this.catalogs, required this.film, required this.catalogRef});
}

final class DetailClickedCheckboxAddtoCatalogActionState
    extends DetailActionState {
  final filmModelDatabase film;
  DetailClickedCheckboxAddtoCatalogActionState({required this.film});
}

final class DetailClickedCheckboxDeleteFromCatalogActionState
    extends DetailActionState {
  final filmModelDatabase film;
  DetailClickedCheckboxDeleteFromCatalogActionState({required this.film});
}
