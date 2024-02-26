class filmModelDatabase {
  late String idFilm;
  late String title;
  late double rating;
  late String years;
  late String posterPath;

  filmModelDatabase(
      {required this.idFilm,
      required this.title,
      required this.rating,
      required this.years,
      required this.posterPath});

  filmModelDatabase.fromJson(Map<String, dynamic> json) {
    idFilm = json['idFilm'];
    title = json['title'];
    rating = json['rating'];
    years = json['years'];
    posterPath = json['posterPath'];
  }

  Map<String, Object?> toJson() {
    return {
      "idFilm": idFilm,
      "title": title,
      "rating": rating,
      "years": years,
      "posterPath": posterPath
    };
  }
}
