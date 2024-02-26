import 'package:cinelog/features/catalog/model/catalog_model.dart';
import 'package:cinelog/features/catalog/model/film_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<catalogModelDatabase>> getCatalog() async {
    final snapshot = await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('catalogs')
        .get();
    final catalogData = snapshot.docs
        .map((e) => catalogModelDatabase.fromJson(e.data()))
        .toList();
    return catalogData;
  }

  Future<QuerySnapshot> getCatalogRef() async {
    final snapshot = await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('catalogs')
        .get();
    return snapshot;
  }

  Future<QuerySnapshot> getCatalogFilmRef(String id) async {
    final snapshot = await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('catalogs')
        .doc(id)
        .collection('films')
        .get();
    return snapshot;
  }

  addCatalog(catalogModelDatabase catalog) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('catalogs')
        .add(catalog.toJson());
  }

  updateCatalog(catalogModelDatabase catalog, String id) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('catalogs')
        .doc(id)
        .update(catalog.toJson());
  }

  deleteCatalog(String idCatalog) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('catalogs')
        .doc(idCatalog)
        .delete();
  }

  Future<List<filmModelDatabase>> getCatalogFilm(String id) async {
    final snapshot = await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('catalogs')
        .doc(id)
        .collection('films')
        .get();
    final filmData =
        snapshot.docs.map((e) => filmModelDatabase.fromJson(e.data())).toList();
    return filmData;
  }

  addCatalogFilm(filmModelDatabase film, String id) async {
    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("catalogs")
        .doc(id)
        .collection('films')
        .add(film.toJson());
  }

  deleteCatalogFilm(String idCatalog, String idFilm) async {
    final film = await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("catalogs")
        .doc(idCatalog)
        .collection('films')
        .where('idFilm', isEqualTo: idFilm)
        .get();
    final id = await film.docs[0].id;
    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("catalogs")
        .doc(idCatalog)
        .collection('films')
        .doc(id)
        .delete();
  }

  Future<bool?> isFilmInCatalog(String idFilm, String id) async {
    final isFilmInCatalog = await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("catalogs")
        .doc(id)
        .collection('films')
        .where('idFilm', isEqualTo: idFilm)
        .get();
    if (isFilmInCatalog.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

// const String FILM_COLLECTION_REF = "films";
// const String CATALOG_COLLECTION_REF = "catalogs";

// class CatalogDatabaseServices {
//   final _firestore = FirebaseFirestore.instance;

//   late final CollectionReference _catalogRef;

//   CatalogDatabaseServices() {
//     _catalogRef = _firestore
//         .collection(CATALOG_COLLECTION_REF)
//         .withConverter<catalogModelDatabase>(
//             fromFirestore: (snapshot, _) =>
//                 catalogModelDatabase.fromJson(snapshot.data()!),
//             toFirestore: (catalogModelDatabase, _) =>
//                 catalogModelDatabase.toJson());
//   }

//   Stream<QuerySnapshot> getCatalog() {
//     return _catalogRef.snapshots();
//   }

//   void addCatalog(catalogModelDatabase catalog) async {
//     _catalogRef.add(catalog);
//   }
// }

// class FilmsDatabaseServices {
//   final _firestore = FirebaseFirestore.instance;

//   late final CollectionReference _filmRef;
//   final String id;

//   FilmsDatabaseServices({required this.id}) {
//     _filmRef = _firestore
//         .collection(CATALOG_COLLECTION_REF)
//         .doc(id)
//         .collection(FILM_COLLECTION_REF)
//         .withConverter<filmModelDatabase>(
//             fromFirestore: (snapshot, _) =>
//                 filmModelDatabase.fromJson(snapshot.data()!),
//             toFirestore: (filmModelDatabase, _) => filmModelDatabase.toJson());
//   }

//   Stream<QuerySnapshot> getFilm() {
//     return _filmRef.snapshots();
//   }

//   void addFilm(filmModelDatabase film) async {
//     _filmRef.add(film);
//   }
// }
