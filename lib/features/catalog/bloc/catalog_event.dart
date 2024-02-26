part of 'catalog_bloc.dart';

@immutable
sealed class CatalogEvent {}

final class CatalogInitialEvent extends CatalogEvent {}

final class CatalogAddCatalogButtonClickedEvent extends CatalogEvent {
  final catalogModelDatabase catalog;

  CatalogAddCatalogButtonClickedEvent({required this.catalog});
}

final class CatalogUpdateCatalogButtonClickedEvent extends CatalogEvent {
  final catalogModelDatabase catalog;
  final int index;

  CatalogUpdateCatalogButtonClickedEvent(
      {required this.catalog, required this.index});
}

final class CatalogGetFilmCatalogEvent extends CatalogEvent {}

final class CatalogMenuShowEvent extends CatalogEvent {}

final class CatalogDetailInitEvent extends CatalogEvent {
  final int index;

  CatalogDetailInitEvent({required this.index});
}

abstract class IconButtonEvent {}

class ToggleIconEvent extends IconButtonEvent {}

class CatalogClickedDeleteEvent extends IconButtonEvent {
  final BuildContext context;
  final int index;

  CatalogClickedDeleteEvent({required this.index, required this.context});
}
