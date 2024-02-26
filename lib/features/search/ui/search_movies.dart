import 'package:cinelog/features/home/model/popular_movies.dart';
import 'package:cinelog/features/home/ui/build_grid_view_movie_list.dart';
import 'package:cinelog/features/home/ui/custom_app_bar.dart';
import 'package:cinelog/features/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMoviesScreen extends StatefulWidget {
  final ListMovies resultsMovies;
  final String query;
  SearchMoviesScreen(
      {super.key, required this.resultsMovies, required this.query});

  @override
  State<SearchMoviesScreen> createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> {
  final SearchBloc searchBloc = SearchBloc();

  final textEditingController = TextEditingController();

  @override
  void initState() {
    searchBloc.add(SearchInitialEvent(resultsMovies: widget.resultsMovies));
    textEditingController.text = widget.query;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      bloc: searchBloc,
      listenWhen: (previous, current) => current is SearchActionState,
      buildWhen: (previous, current) => current is! SearchActionState,
      listener: (context, state) {
        if (state is SearchNavigateToOtherPageActionState) {
          final currState = state as SearchNavigateToOtherPageActionState;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => SearchMoviesScreen(
                        resultsMovies: currState.resultsMovies,
                        query: currState.searchQuery,
                      ))));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case SearchLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case SearchInitialFoundQueryState:
            final successState = state as SearchInitialFoundQueryState;
            final searchResult = successState.resultSearchQuery;
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomAppBar(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "<- Back",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: const Text("Exploration",
                                style: TextStyle(
                                  fontSize: 25,
                                )),
                          ),
                          TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                                hintText: "Search movies here...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                )),
                            onEditingComplete: () {
                              searchBloc.add(SearchNavigateToOtherPageEvent(
                                  page: 1, query: textEditingController.text));
                            },
                          ),
                          Text(
                            "Search for ${textEditingController.text}, founded ${searchResult.totalResults} movies",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BuildGridViewMovieList(
                              crossAxisCount: 2,
                              popularMoviesList: searchResult.results),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: searchResult.totalPages,
                              separatorBuilder: ((context, index) => SizedBox(
                                    width: 10,
                                  )),
                              itemBuilder: (context, index) {
                                final int index2 = index + 1;
                                if (searchResult.page == index2) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    ),
                                    height: 10,
                                    width: 80,
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          index2.toString(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )),
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    height: 10,
                                    width: 60,
                                    child: TextButton(
                                        onPressed: () {
                                          searchBloc.add(
                                              SearchNavigateToOtherPageEvent(
                                                  query: textEditingController
                                                      .text,
                                                  page: index2));
                                        },
                                        child: Text(
                                          index2.toString(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor),
                                        )),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          case SearchInitialNotFoundQueryState:
            final textEditingController = TextEditingController();
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomAppBar(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "<- Kembali",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: const Text("Exploration",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                          ),
                          TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                                hintText: "Search movies here...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                )),
                            onEditingComplete: () {
                              searchBloc.add(SearchNavigateToOtherPageEvent(
                                  page: 1, query: textEditingController.text));
                            },
                          ),
                          Center(
                            child: Text(
                              "Data not found",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
