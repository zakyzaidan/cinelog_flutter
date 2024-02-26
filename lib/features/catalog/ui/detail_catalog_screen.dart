import 'package:cinelog/assets/api/api_services.dart';
import 'package:cinelog/assets/services/database_services.dart';
import 'package:cinelog/features/catalog/bloc/catalog_bloc.dart';
import 'package:cinelog/features/catalog/model/catalog_model.dart';
import 'package:cinelog/features/detail/ui/detail_screen.dart';
import 'package:cinelog/features/home/ui/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCatalogScreen extends StatefulWidget {
  final catalogModelDatabase catalog;
  final int index;

  DetailCatalogScreen({super.key, required this.catalog, required this.index});

  @override
  State<DetailCatalogScreen> createState() => _DetailCatalogScreenState();
}

class _DetailCatalogScreenState extends State<DetailCatalogScreen> {
  final DatabaseServices databaseServices = DatabaseServices();
  final CatalogBloc catalogBloc = CatalogBloc();

  @override
  void initState() {
    catalogBloc.add(CatalogDetailInitEvent(index: widget.index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatalogBloc, CatalogState>(
      bloc: catalogBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case CatalogDetailInitState:
            final successState = state as CatalogDetailInitState;
            final ApiServices apiServices = ApiServices();
            final films = successState.films;
            return Scaffold(
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.catalog.title,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      customDivider(thickness: 2),
                      Text(
                        widget.catalog.description,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: successState.films.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 370,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DetailScreen(
                                    id: int.parse(films[index].idFilm),
                                  );
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Builder(builder: (context) {
                                      if (films[index].posterPath.isNotEmpty) {
                                        return Image.network(
                                          apiServices.baseUrlImage +
                                              films[index].posterPath,
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
                                        thickness: 4,
                                        color: Theme.of(context)
                                            .secondaryHeaderColor),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            films[index].title,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('${films[index].years}  |  '),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 15,
                                        ),
                                        Text('${films[index].rating}/10')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                ),
              )),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
