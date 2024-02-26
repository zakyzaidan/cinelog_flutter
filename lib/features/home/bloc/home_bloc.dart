import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinelog/assets/api/api_services.dart';
import 'package:cinelog/features/home/model/popular_movies.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ApiServices apiServices = ApiServices();
  HomeBloc() : super(HomeInitial()) {
    on<HomeNavigateToDetailPageEvent>(homeNavigateToDetailPageEvent);
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeNavigateToPopularPageEvent>(homeNavigateToPopularPageEvent);
    on<HomeNavigateToTopRatedPageEvent>(homeNavigateToTopRatedPageEvent);
    on<HomeNavigateToSearchPageEvent>(homeNavigateToSearchPageEvent);
  }

  FutureOr<void> homeNavigateToDetailPageEvent(
      HomeNavigateToDetailPageEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToDetailPageActionState());
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final popularMovies = await apiServices.getPopularMovies(1);
    final topRatedMovies = await apiServices.getTopRatedMovies(1);
    emit(HomeLoadedSuccessState(
        popularMovies: popularMovies, topRatedMovies: topRatedMovies));
  }

  FutureOr<void> homeNavigateToPopularPageEvent(
      HomeNavigateToPopularPageEvent event, Emitter<HomeState> emit) async {
    final popularListMovies = await apiServices.getPopularMovies(event.page);
    emit(HomeNavigateToPopularPageActionState(
        popularListMovies: popularListMovies));
  }

  FutureOr<void> homeNavigateToTopRatedPageEvent(
      HomeNavigateToTopRatedPageEvent event, Emitter<HomeState> emit) async {
    final topRatedListMovies = await apiServices.getTopRatedMovies(event.page);
    emit(HomeNavigateToTopRatedPageActionState(
        topRatedMovies: topRatedListMovies));
  }

  FutureOr<void> homeNavigateToSearchPageEvent(
      HomeNavigateToSearchPageEvent event, Emitter<HomeState> emit) async {
    final searchResult =
        await apiServices.getSearchMoviesByQuery(event.query, 1);
    emit(HomeNavigateToSearchPageActionState(
        searchResult: searchResult, searchQuery: event.query));
  }
}
