import 'package:cinelog/assets/api/api_services.dart';
import 'package:cinelog/features/home/bloc/home_bloc.dart';
import 'package:cinelog/features/home/model/popular_movies.dart';
import 'package:cinelog/features/home/ui/custom_app_bar.dart';
import 'package:cinelog/features/home/ui/popular_movies_screen.dart';
import 'package:cinelog/features/home/ui/top_rated_movies_screen.dart';
import 'package:cinelog/features/search/ui/search_movies.dart';
import 'package:flutter/material.dart';
import 'package:cinelog/features/detail/ui/detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToPopularPageActionState) {
          final currState = state as HomeNavigateToPopularPageActionState;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => PopularMoviesScreen(
                      popularMovies: currState.popularListMovies))));
        } else if (state is HomeNavigateToTopRatedPageActionState) {
          final currState = state as HomeNavigateToTopRatedPageActionState;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => TopRatedMoviesScreen(
                      topRatedMovies: currState.topRatedMovies))));
        } else if (state is HomeNavigateToSearchPageActionState) {
          final currState = state as HomeNavigateToSearchPageActionState;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchMoviesScreen(
              resultsMovies: currState.searchResult,
              query: currState.searchQuery,
            );
          }));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            final popularMovies = successState.popularMovies;
            final topRatedMovies = successState.topRatedMovies;
            final textEditingController = TextEditingController();
            return GestureDetector(
              onTap: () {
                textEditingController.clear();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CustomAppBar(),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: const Text("Exploration",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500)),
                                ),
                                TextField(
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      hintText: "Search movies here...",
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      )),
                                  onEditingComplete: () {
                                    homeBloc.add(HomeNavigateToSearchPageEvent(
                                        query: textEditingController.text));
                                  },
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Popular",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500)),
                              TextButton(
                                  onPressed: () {
                                    homeBloc.add(HomeNavigateToPopularPageEvent(
                                        page: 1));
                                  },
                                  child: const Text("View All->"))
                            ],
                          ),
                          SizedBox(
                            height: 370,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: popularMovies.results.length,
                              itemBuilder: (context, index) {
                                return BuildCard(context, index,
                                    popularMovies.results, ApiServices());
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Top Rated",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500)),
                              TextButton(
                                  onPressed: () {
                                    homeBloc.add(
                                        HomeNavigateToTopRatedPageEvent(
                                            page: 1));
                                  },
                                  child: const Text("View All->"))
                            ],
                          ),
                          SizedBox(
                            height: 370,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: topRatedMovies.results.length,
                              itemBuilder: (context, index) {
                                return BuildCard(context, index,
                                    topRatedMovies.results, ApiServices());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text("---Error---"),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }

  InkWell BuildCard(BuildContext context, int index, List<Result> movieList,
      ApiServices apiServices) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(
            id: movieList[index].id,
          );
        }));
      },
      child: Container(
        height: 330,
        width: 200,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor),
        child: Column(
          children: [
            Builder(builder: (context) {
              if (movieList[index].posterPath != null) {
                return Image.network(
                  apiServices.baseUrlImage + movieList[index].posterPath!,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.fill,
                );
              } else {
                return Image.asset(
                  "images/errorImage.png",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.fill,
                );
              }
            }),
            Divider(
                thickness: 4, color: Theme.of(context).secondaryHeaderColor),
            Row(
              children: [
                Expanded(
                  child: Text(
                    movieList[index].originalTitle,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('${movieList[index].releaseDate.year}  |  '),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 15,
                ),
                Text('${movieList[index].voteAverage}/10')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
