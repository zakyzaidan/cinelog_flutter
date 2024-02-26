part of 'detail_bloc.dart';

@immutable
sealed class DetailEvent {}

final class DetailInitialEvent extends DetailEvent {}

final class DetailClickedTrailerEvent extends DetailEvent {
  final int id;

  DetailClickedTrailerEvent({required this.id});
}

final class DetailClickedAddCatalogEvent extends DetailEvent {
  final filmModelDatabase film;

  DetailClickedAddCatalogEvent({required this.film});
}

final class DetailClickedCheckboxAddtoCatalogEvent extends DetailEvent {
  final filmModelDatabase film;
  final String idCatalog;

  DetailClickedCheckboxAddtoCatalogEvent(
      {required this.film, required this.idCatalog});
}

final class DetailClickedCheckboxDeleteFromCatalogEvent extends DetailEvent {
  final filmModelDatabase film;
  final String idCatalog;
  final String idFilm;

  DetailClickedCheckboxDeleteFromCatalogEvent(
      {required this.idCatalog, required this.idFilm, required this.film});
}
