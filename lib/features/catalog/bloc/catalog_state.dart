part of 'catalog_bloc.dart';

@immutable
sealed class CatalogState {}

final class CatalogInitial extends CatalogState {}

final class CatalogActionState extends CatalogState {}

final class CatalogLoadingState extends CatalogState {}

final class CatalogLoadedSuccessState extends CatalogState {
  final List<catalogModelDatabase> catalogs;
  final QuerySnapshot catalogRef;

  CatalogLoadedSuccessState({required this.catalogs, required this.catalogRef});
}

final class CatalogDetailInitState extends CatalogState {
  final List<filmModelDatabase> films;

  CatalogDetailInitState({required this.films});
}

final class CatalogAddCatalogButtonActionState extends CatalogActionState {
  final String nameCatalog;
  CatalogAddCatalogButtonActionState({required this.nameCatalog});
}

final class CatalogUpdateCatalogButtonActionState extends CatalogActionState {}

final class CatalogAddCatalogButtonErrorActionState extends CatalogActionState {
  final String error;
  CatalogAddCatalogButtonErrorActionState({required this.error});
}

final class CatalogMenuShowActionState extends CatalogActionState {}

class IconButtonState {
  final bool isPressed;

  IconButtonState({required this.isPressed});
}
