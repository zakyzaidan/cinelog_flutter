import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinelog/features/catalog/model/catalog_model.dart';
import 'package:cinelog/assets/services/database_services.dart';
import 'package:cinelog/features/catalog/model/film_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final DatabaseServices databaseSerivices = DatabaseServices();
  CatalogBloc() : super(CatalogInitial()) {
    on<CatalogInitialEvent>(catalogInitialEvent);
    on<CatalogAddCatalogButtonClickedEvent>(
        catalogAddCatalogButtonClickedEvent);
    on<CatalogMenuShowEvent>(catalogMenuShowEvent);
    on<CatalogDetailInitEvent>(catalogDetailInitEvent);
    on<CatalogUpdateCatalogButtonClickedEvent>(
        catalogUpdateCatalogButtonClickedEvent);
  }

  FutureOr<void> catalogInitialEvent(
      CatalogInitialEvent event, Emitter<CatalogState> emit) async {
    try {
      List<catalogModelDatabase> catalogs =
          await databaseSerivices.getCatalog();
      final QuerySnapshot catalogRef = await databaseSerivices.getCatalogRef();
      emit(CatalogLoadedSuccessState(
          catalogs: catalogs, catalogRef: catalogRef));
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> catalogAddCatalogButtonClickedEvent(
      CatalogAddCatalogButtonClickedEvent event,
      Emitter<CatalogState> emit) async {
    emit(CatalogLoadingState());
    try {
      await databaseSerivices.addCatalog(event.catalog);
      emit(
          CatalogAddCatalogButtonActionState(nameCatalog: event.catalog.title));
    } catch (e) {
      emit(CatalogAddCatalogButtonErrorActionState(error: e.toString()));
    }
  }

  FutureOr<void> catalogMenuShowEvent(
      CatalogMenuShowEvent event, Emitter<CatalogState> emit) {
    emit(CatalogMenuShowActionState());
  }

  FutureOr<void> catalogDetailInitEvent(
      CatalogDetailInitEvent event, Emitter<CatalogState> emit) async {
    final QuerySnapshot catalogRef = await databaseSerivices.getCatalogRef();
    final List<filmModelDatabase> films =
        await databaseSerivices.getCatalogFilm(catalogRef.docs[event.index].id);
    emit(CatalogDetailInitState(films: films));
  }

  FutureOr<void> catalogUpdateCatalogButtonClickedEvent(
      CatalogUpdateCatalogButtonClickedEvent event,
      Emitter<CatalogState> emit) async {
    emit(CatalogLoadingState());
    try {
      final catalogRef = await databaseSerivices.getCatalogRef();
      final idCatalog = catalogRef.docs[event.index].id;
      await databaseSerivices.updateCatalog(event.catalog, idCatalog);
      emit(CatalogUpdateCatalogButtonActionState());
    } catch (e) {
      print(e);
    }
  }
}

class IconButtonBloc extends Bloc<IconButtonEvent, IconButtonState> {
  final DatabaseServices databaseSerivices = DatabaseServices();
  IconButtonBloc() : super(IconButtonState(isPressed: false)) {
    on<ToggleIconEvent>(toggleIconEvent);
    on<CatalogClickedDeleteEvent>(catalogClickedDeleteEvent);
  }

  FutureOr<void> toggleIconEvent(
      ToggleIconEvent event, Emitter<IconButtonState> emit) {
    emit(IconButtonState(isPressed: !state.isPressed));
  }

  FutureOr<void> catalogClickedDeleteEvent(
      CatalogClickedDeleteEvent event, Emitter<IconButtonState> emit) async {
    final catalogRef = await databaseSerivices.getCatalogRef();
    final idCatalog = catalogRef.docs[event.index].id;
    try {
      await databaseSerivices.deleteCatalog(idCatalog);
      ScaffoldMessenger.of(event.context)
          .showSnackBar(SnackBar(content: Text("Success Delete Catalog")));
    } catch (e) {
      print(e);
    }
  }
}
