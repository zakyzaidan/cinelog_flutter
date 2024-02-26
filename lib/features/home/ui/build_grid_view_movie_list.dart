import 'package:cinelog/assets/api/api_services.dart';
import 'package:cinelog/features/detail/ui/detail_screen.dart';
import 'package:cinelog/features/home/model/popular_movies.dart';
import 'package:flutter/material.dart';

class BuildGridViewMovieList extends StatelessWidget {
  final int crossAxisCount;
  final List<Result> popularMoviesList;
  final ApiServices apiServices = ApiServices();
  BuildGridViewMovieList(
      {Key? key, required this.crossAxisCount, required this.popularMoviesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: popularMoviesList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 370),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(
                  id: popularMoviesList[index].id,
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
                    if (popularMoviesList[index].posterPath != null) {
                      return Image.network(
                        apiServices.baseUrlImage +
                            popularMoviesList[index].posterPath!,
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
                      color: Theme.of(context).secondaryHeaderColor),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          popularMoviesList[index].title,
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
                      Text('${popularMoviesList[index].releaseDate.year}  |  '),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 15,
                      ),
                      Text('${popularMoviesList[index].voteAverage}/10')
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
