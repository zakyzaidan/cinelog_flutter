class datafilm {
  String judul;
  int durasi;
  double rating;
  String tahunRilis;
  String sutradara;
  String linkcover;
  String sinopsis;

  datafilm({
    required this.judul,
    required this.durasi,
    required this.rating,
    required this.tahunRilis,
    required this.sutradara,
    required this.linkcover,
    required this.sinopsis
  });
}

var listfilm = [
  datafilm(
    judul: "Dune",
    durasi: 155,
    rating: 7.787,
    tahunRilis: "2021",
    sutradara: "Denis Villeneuve",
    linkcover: "images/dune.jpg",
    sinopsis: "Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe to ensure the future of his family and his people. As malevolent forces explode into conflict over the planet's exclusive supply of the most precious resource in existence-a commodity capable of unlocking humanity's greatest potential-only those who can conquer their fear will survive.",
  ),
  datafilm(
    judul: "Kiki's Delivery Service",
    durasi: 103,
    rating: 7.848,
    tahunRilis: "1989",
    sutradara: "Hayao Miyazaki",
    linkcover: "images/kiki.jpg",
    sinopsis: "A young witch, on her mandatory year of independent life, finds fitting into a new community difficult while she supports herself by running an air courier service.",
  ),
  datafilm(
    judul: "Zodiac",
    durasi: 163,
    rating: 7.521,
    tahunRilis: "2007",
    sutradara: "David Fincher",
    linkcover: "images/zodiac.jpg",
    sinopsis: "A cartoonist teams up with an ace reporter and a law enforcement officer to track down an elusive serial killer.",
        
  )
];