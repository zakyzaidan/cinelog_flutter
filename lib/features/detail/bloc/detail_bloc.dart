import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinelog/assets/api/api_services.dart';
import 'package:cinelog/features/catalog/model/catalog_model.dart';
import 'package:cinelog/features/catalog/model/film_model.dart';
import 'package:cinelog/features/detail/model/actor_detail_movies.dart';
import 'package:cinelog/features/detail/model/detail_movies.dart';
import 'package:cinelog/features/detail/model/detail_movies_youtube_model.dart';
import 'package:cinelog/assets/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  ApiServices apiServices = ApiServices();
  final DatabaseServices databaseServices = DatabaseServices();
  final int id;
  DetailBloc(this.id) : super(DetailInitial()) {
    on<DetailInitialEvent>(detailInitialEvent);
    on<DetailClickedTrailerEvent>(detailClickedTrailerEvent);
    on<DetailClickedAddCatalogEvent>(detailClickedAddCatalogEvent);
    on<DetailClickedCheckboxAddtoCatalogEvent>(
        detailClickedCheckboxAddtoCatalogEvent);
    on<DetailClickedCheckboxDeleteFromCatalogEvent>(
        detailClickedCheckboxDeleteFromCatalogEvent);
  }

  FutureOr<void> detailInitialEvent(
      DetailInitialEvent event, Emitter<DetailState> emit) async {
    emit(DetailLoadedState());
    final detailMovies = await apiServices.getDetailMovies(id);
    final actorDetailMovies = await apiServices.getActorDetailMovies(id);
    emit(DetailLoadedSuccessState(
        detailMovies: detailMovies, actorDetailMovies: actorDetailMovies));
  }

  FutureOr<void> detailClickedTrailerEvent(
      DetailClickedTrailerEvent event, Emitter<DetailState> emit) async {
    final detailYoutubeTrailer =
        await apiServices.getYoutubeTrailerDetailMovies(event.id);
    emit(DetailYoutubeActionState(
        detailMoviesYoutubeModel: detailYoutubeTrailer));
  }

  FutureOr<void> detailClickedAddCatalogEvent(
      DetailClickedAddCatalogEvent event, Emitter<DetailState> emit) async {
    final List<catalogModelDatabase> catalogs =
        await databaseServices.getCatalog();
    final QuerySnapshot catalogRef = await databaseServices.getCatalogRef();

    emit(DetailAddCatalogActionState(
        catalogs: catalogs, film: event.film, catalogRef: catalogRef));
  }

  FutureOr<void> detailClickedCheckboxAddtoCatalogEvent(
      DetailClickedCheckboxAddtoCatalogEvent event, Emitter<DetailState> emit) {
    try {
      databaseServices.addCatalogFilm(event.film, event.idCatalog);
      emit(DetailClickedCheckboxAddtoCatalogActionState(film: event.film));
    } catch (e) {
      print("-----------$e------------");
    }
  }

  FutureOr<void> detailClickedCheckboxDeleteFromCatalogEvent(
      DetailClickedCheckboxDeleteFromCatalogEvent event,
      Emitter<DetailState> emit) {
    try {
      print("start");
      databaseServices.deleteCatalogFilm(event.idCatalog, event.idFilm);
      emit(DetailClickedCheckboxAddtoCatalogActionState(film: event.film));
    } catch (e) {
      print("-----------$e------------");
    }
  }
}
