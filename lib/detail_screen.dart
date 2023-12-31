import 'package:flutter/material.dart';
import 'package:cinelog/assets/datafilm.dart';

class DetailScreen extends StatelessWidget {
  final datafilm film;
  const DetailScreen({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('images/CinelogLogo.png',scale: 2,),
                          const Row(
                            children: [
                              Icon(Icons.notifications),
                              SizedBox(width: 5),
                              Text("User Name"),
                              SizedBox(width: 5),
                              CircleAvatar(backgroundColor: Colors.grey,),
                            ],
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 3, color: Colors.black,
                      ),
                    ],
                  ),
                ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Text("<- Kembali", style: TextStyle(fontSize: 25),),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(film.linkcover, height: 200,fit: BoxFit.fill,),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(film.judul, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Text("Tahun rilis : "+film.tahunRilis,),
                              Text("Sutradara : "+film.sutradara),
                              Text("Durasi : "+film.durasi.toString()+" menit"),
                              Text("Rating : "+film.rating.toString())
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const Text("Sinopsis", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      Text(film.sinopsis)
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}