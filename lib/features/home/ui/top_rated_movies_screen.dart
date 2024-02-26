import 'package:cinelog/features/home/bloc/home_bloc.dart';
import 'package:cinelog/features/home/model/popular_movies.dart';
import 'package:cinelog/features/home/ui/build_grid_view_movie_list.dart';
import 'package:cinelog/features/home/ui/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesScreen extends StatelessWidget {
  final ListMovies topRatedMovies;
  final HomeBloc homeBloc = HomeBloc();
  TopRatedMoviesScreen({super.key, required this.topRatedMovies});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToTopRatedPageActionState) {
          final currState = state as HomeNavigateToTopRatedPageActionState;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => TopRatedMoviesScreen(
                      topRatedMovies: currState.topRatedMovies))));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
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
                    const Text("Top Rated Movies",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const customDivider(thickness: 2),
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        if (constraints.maxWidth < 600) {
                          return BuildGridViewMovieList(
                            crossAxisCount: 2,
                            popularMoviesList: topRatedMovies.results,
                          );
                        } else if (constraints.maxWidth < 900) {
                          return BuildGridViewMovieList(
                              crossAxisCount: 3,
                              popularMoviesList: topRatedMovies.results);
                        } else if (constraints.maxWidth < 1300) {
                          return BuildGridViewMovieList(
                              crossAxisCount: 4,
                              popularMoviesList: topRatedMovies.results);
                        } else {
                          return BuildGridViewMovieList(
                              crossAxisCount: 5,
                              popularMoviesList: topRatedMovies.results);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 100,
                        separatorBuilder: ((context, index) => SizedBox(
                              width: 10,
                            )),
                        itemBuilder: (context, index) {
                          final int index2 = index + 1;
                          if (topRatedMovies.page == index2) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              height: 10,
                              width: 80,
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    index2.toString(),
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
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
                                    homeBloc.add(
                                        HomeNavigateToTopRatedPageEvent(
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
        );
      },
    );
  }
}
