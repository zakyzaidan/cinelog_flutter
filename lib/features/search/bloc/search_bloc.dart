import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinelog/assets/api/api_services.dart';
import 'package:cinelog/features/home/model/popular_movies.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchInitialEvent>(searchInitailEvent);
    on<SearchNavigateToOtherPageEvent>(searchNavigateToOtherPageEvent);
  }

  FutureOr<void> searchInitailEvent(
      SearchInitialEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());
    if (event.resultsMovies.results.isNotEmpty) {
      emit(
          SearchInitialFoundQueryState(resultSearchQuery: event.resultsMovies));
    } else {
      emit(SearchInitialNotFoundQueryState());
    }
  }

  FutureOr<void> searchNavigateToOtherPageEvent(
      SearchNavigateToOtherPageEvent event, Emitter<SearchState> emit) async {
    final resultSearchQuery =
        await ApiServices().getSearchMoviesByQuery(event.query, event.page);
    emit(SearchNavigateToOtherPageActionState(
        resultsMovies: resultSearchQuery, searchQuery: event.query));
  }
}
