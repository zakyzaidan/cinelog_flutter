class catalogModelDatabase {
  late String description;
  late String title;

  catalogModelDatabase({required this.description, required this.title});

  catalogModelDatabase.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    title = json['title'];
  }

//List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
  Map<String, Object?> toJson() {
    return {
      "description": description,
      "title": title,
    };
  }
  //List<dynamic>.from(results.map((x) => x.toJson()))
}
