import 'dart:ui';

import 'package:cinelog/assets/api/api_services.dart';
import 'package:cinelog/features/catalog/bloc/catalog_bloc.dart';
import 'package:cinelog/features/catalog/model/catalog_model.dart';
import 'package:cinelog/features/catalog/model/film_model.dart';
import 'package:cinelog/features/catalog/ui/add_catalog_screen.dart';
import 'package:cinelog/features/catalog/ui/detail_catalog_screen.dart';
import 'package:cinelog/features/catalog/ui/update_catalog_screen.dart';
import 'package:cinelog/features/home/ui/custom_app_bar.dart';
import 'package:cinelog/assets/services/database_services.dart';
import 'package:cinelog/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KatalogScreen extends StatefulWidget {
  const KatalogScreen({super.key});

  @override
  State<KatalogScreen> createState() => _KatalogScreenState();
}

class _KatalogScreenState extends State<KatalogScreen> {
  final CatalogBloc catalogBloc = CatalogBloc();

  @override
  void initState() {
    catalogBloc.add(CatalogInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatalogBloc, CatalogState>(
      bloc: catalogBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case CatalogLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case CatalogLoadedSuccessState:
            final successState = state as CatalogLoadedSuccessState;
            final ApiServices apiServices = ApiServices();
            final DatabaseServices databaseServices = DatabaseServices();
            final List<catalogModelDatabase> catalogs = successState.catalogs;
            final IconButtonBloc iconButtonBloc = IconButtonBloc();
            if (catalogs.isEmpty) {
              return Scaffold(
                body: SafeArea(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAppBar(),
                      const Text(
                        "Catalog Screen",
                        style: TextStyle(fontSize: 25),
                      ),
                      const customDivider(thickness: 2),
                      Expanded(
                          child: Center(
                        child: Text("Add some catalog"),
                      ))
                    ],
                  ),
                )),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => AddCatalogScreen()));
                  },
                  child: Icon(Icons.add),
                ),
              );
            } else {
              return Scaffold(
                body: SafeArea(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAppBar(),
                      const Text(
                        "Catalog",
                        style: TextStyle(fontSize: 25),
                      ),
                      const customDivider(thickness: 2),
                      Expanded(
                          child: BlocConsumer<IconButtonBloc, IconButtonState>(
                        bloc: iconButtonBloc,
                        listener: (context, state) {},
                        builder: (context, state) {
                          final state2 = state;
                          final isShow = state2.isPressed;

                          return ListView.separated(
                              separatorBuilder: (context, index) => Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                              itemCount: catalogs.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (builder) {
                                                  return DetailCatalogScreen(
                                                      catalog: catalogs[index],
                                                      index: index);
                                                }));
                                              },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    catalogs[index].title,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    catalogs[index].description,
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Builder(builder: (builder) {
                                            if (isShow) {
                                              return Row(
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (builder) => UpdateCatalogScreen(
                                                                    currTitle:
                                                                        catalogs[index]
                                                                            .title,
                                                                    currDescription:
                                                                        catalogs[index]
                                                                            .description,
                                                                    index:
                                                                        index)));
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Theme.of(
                                                                          context)
                                                                      .primaryColor)),
                                                      child: Text('Edit')),
                                                  TextButton(
                                                      onPressed: () async {
                                                        return showDialog(
                                                            context: context,
                                                            builder: (builder) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Delete'),
                                                                content: Text(
                                                                    "Do you Want to delete catalog ${catalogs[index].title}?"),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        iconButtonBloc.add(CatalogClickedDeleteEvent(
                                                                            index:
                                                                                index,
                                                                            context:
                                                                                context));
                                                                        catalogBloc
                                                                            .add(CatalogInitialEvent());
                                                                        Navigator.of(context).push(MaterialPageRoute(builder:
                                                                            (builder) {
                                                                          return MainScreen(
                                                                              index: 0);
                                                                        }));
                                                                      },
                                                                      child: Text(
                                                                          'Yes')),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          'Cancel')),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red)),
                                                      child: Text('Delete')),
                                                  IconButton(
                                                    icon: Icon(Icons.close),
                                                    onPressed: () {
                                                      iconButtonBloc.add(
                                                          ToggleIconEvent());
                                                    },
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return IconButton(
                                                icon: Icon(Icons.menu),
                                                onPressed: () {
                                                  iconButtonBloc
                                                      .add(ToggleIconEvent());
                                                },
                                              );
                                            }
                                          })
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      FutureBuilder(
                                          future: databaseServices
                                              .getCatalogFilm(successState
                                                  .catalogRef.docs[index].id),
                                          builder: (BuildContext builder,
                                              AsyncSnapshot asyncSnapshot) {
                                            if (asyncSnapshot.hasData) {
                                              final List<filmModelDatabase>
                                                  films = asyncSnapshot.data;
                                              if (films.isNotEmpty) {
                                                return Container(
                                                  height: 150,
                                                  child: ListView.separated(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                      itemCount: films.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (films[index]
                                                            .posterPath
                                                            .isEmpty) {
                                                          return Container(
                                                            height: 150,
                                                            width: 100,
                                                            child: Image.asset(
                                                                'images/errorImage.png'),
                                                          );
                                                        } else {
                                                          return Container(
                                                            height: 150,
                                                            width: 100,
                                                            child: Image.network(
                                                                apiServices
                                                                        .baseUrlImage +
                                                                    films[index]
                                                                        .posterPath),
                                                          );
                                                        }
                                                      }),
                                                );
                                              } else {
                                                return SizedBox();
                                              }
                                            } else {
                                              return SizedBox();
                                            }
                                          }),
                                    ],
                                  ),
                                );
                              });
                        },
                      ))
                    ],
                  ),
                )),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => AddCatalogScreen()));
                  },
                  child: Icon(Icons.add),
                ),
              );
            }
          default:
            return SizedBox();
        }
      },
    );
  }
}
