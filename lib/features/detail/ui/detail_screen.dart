import 'package:cinelog/assets/api/api_services.dart';
import 'package:cinelog/features/catalog/model/catalog_model.dart';
import 'package:cinelog/features/catalog/model/film_model.dart';
import 'package:cinelog/features/detail/bloc/detail_bloc.dart';
import 'package:cinelog/features/home/ui/custom_app_bar.dart';
import 'package:cinelog/main_screen.dart';
import 'package:cinelog/assets/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiServices apiServices = ApiServices();
  late final DetailBloc detailBloc = DetailBloc(widget.id);
  @override
  void initState() {
    detailBloc.add(DetailInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailBloc, DetailState>(
      bloc: detailBloc,
      listenWhen: (previous, current) => current is DetailActionState,
      buildWhen: (previous, current) => current is! DetailActionState,
      listener: (context, state) {
        if (state is DetailYoutubeActionState) {
          final successState = state as DetailYoutubeActionState;
          YoutubePlayerController _ytController = YoutubePlayerController(
              initialVideoId:
                  successState.detailMoviesYoutubeModel.results!.last.key!);
          showDialog(
              context: context,
              builder: (builder) {
                return AlertDialog(
                  content: YoutubePlayer(
                    controller: _ytController,
                    showVideoProgressIndicator: true,
                  ),
                );
              });
        } else if (state is DetailAddCatalogActionState) {
          final successState = state as DetailAddCatalogActionState;
          final DatabaseServices databaseServices = DatabaseServices();
          final List<catalogModelDatabase> catalogs = successState.catalogs;
          final filmModelDatabase film = successState.film;
          showDialog(
              context: context,
              builder: (builder) {
                return AlertDialog(
                  content: Builder(builder: (context) {
                    if (catalogs.isNotEmpty) {
                      return Container(
                        height: 300,
                        width: 200,
                        child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
                            itemCount: catalogs.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                  future: databaseServices.isFilmInCatalog(
                                      film.idFilm,
                                      successState.catalogRef.docs[index].id),
                                  builder: (BuildContext builder,
                                      AsyncSnapshot asyncSnapshot) {
                                    if (asyncSnapshot.data as bool? ?? false) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            catalogs[index].title,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                detailBloc.add(
                                                    DetailClickedCheckboxDeleteFromCatalogEvent(
                                                        idFilm: film.idFilm,
                                                        film: film,
                                                        idCatalog: successState
                                                            .catalogRef
                                                            .docs[index]
                                                            .id));
                                              },
                                              child: Icon(Icons.check))
                                        ],
                                      );
                                    } else {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            catalogs[index].title,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                detailBloc.add(
                                                    DetailClickedCheckboxAddtoCatalogEvent(
                                                        film: film,
                                                        idCatalog: successState
                                                            .catalogRef
                                                            .docs[index]
                                                            .id));
                                              },
                                              child: Icon(Icons.add))
                                        ],
                                      );
                                    }
                                  });
                            }),
                      );
                    } else {
                      return Container(
                        height: 100,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Empty Catalog"),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              MainScreen(index: 1)));
                                },
                                child: Text("Add Catalog here"))
                          ],
                        ),
                      );
                    }
                  }),
                );
              });
        } else if (state is DetailClickedCheckboxAddtoCatalogActionState) {
          Navigator.pop(context);
          detailBloc.add(DetailClickedAddCatalogEvent(film: state.film));
        } else if (state is DetailClickedCheckboxAddtoCatalogActionState) {
          Navigator.pop(context);
          detailBloc.add(DetailClickedAddCatalogEvent(film: state.film));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case DetailLoadedState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case DetailLoadedSuccessState:
            final successState = state as DetailLoadedSuccessState;
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const CustomAppBar(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "<- Back",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Builder(builder: (context) {
                                  if (successState.detailMovies.posterPath !=
                                      null) {
                                    return Image.network(
                                      apiServices.baseUrlImage +
                                          successState.detailMovies.posterPath!,
                                      height: 200,
                                      fit: BoxFit.fill,
                                    );
                                  } else {
                                    return Expanded(
                                      child: Image.asset(
                                        'images/errorImage.png',
                                        height: 200,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  }
                                }),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        successState
                                            .detailMovies.originalTitle!,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Tahun rilis : ${successState.detailMovies.releaseDate!.year}",
                                      ),
                                      Text(
                                          "Status : ${successState.detailMovies.status}"),
                                      const Text("Genre :"),
                                      SizedBox(
                                        height: 20,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: successState
                                              .detailMovies.genres!.length,
                                          itemBuilder: (_, index) {
                                            return Text(
                                                "${successState.detailMovies.genres![index].name!}  ");
                                          },
                                        ),
                                      ),
                                      Text(
                                          "Durasi : ${successState.detailMovies.runtime} menit"),
                                      Text(
                                          "Rating : ${successState.detailMovies.voteAverage}/10 dari ${successState.detailMovies.voteCount}"),
                                      TextButton(
                                          onPressed: () {
                                            detailBloc.add(
                                                DetailClickedTrailerEvent(
                                                    id: successState
                                                        .detailMovies.id!));
                                          },
                                          child:
                                              Text("Watch Trailer Movies ->"))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  detailBloc.add(DetailClickedAddCatalogEvent(
                                      film: filmModelDatabase(
                                          idFilm: successState.detailMovies.id
                                              .toString(),
                                          title:
                                              successState.detailMovies.title!,
                                          rating: successState
                                              .detailMovies.voteAverage!,
                                          years: successState
                                              .detailMovies.releaseDate!.year
                                              .toString(),
                                          posterPath: successState
                                                  .detailMovies.posterPath ??
                                              "")));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Icon(Icons.bookmark),
                                      Text("Add to catalog")
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Sinopsis",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(successState.detailMovies.overview!),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Actor",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: successState
                                      .actorDetailMovies.cast!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 120,
                                      height: 170,
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Builder(builder: (context) {
                                            if (successState.actorDetailMovies
                                                    .cast![index].profilePath !=
                                                null) {
                                              return CircleAvatar(
                                                radius: 40.0,
                                                backgroundImage: NetworkImage(
                                                    apiServices.baseUrlImage +
                                                        successState
                                                            .actorDetailMovies
                                                            .cast![index]
                                                            .profilePath!),
                                                backgroundColor:
                                                    Colors.transparent,
                                              );
                                            } else {
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  "images/errorImage.png",
                                                  fit: BoxFit.fill,
                                                  height: 70,
                                                ),
                                              );
                                            }
                                          }),
                                          Text(
                                            successState.actorDetailMovies
                                                .cast![index].name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(successState.actorDetailMovies
                                              .cast![index].character!)
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text("error"),
              ),
            );
        }
      },
    );
  }
}
