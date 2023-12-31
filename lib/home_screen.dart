import 'package:flutter/material.dart';
import 'package:cinelog/assets/datafilm.dart';
import 'package:cinelog/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: const Text("Exploration", 
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold)
                      ),
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 10),
                      decoration: InputDecoration(
                        label: const Text("Pencarian"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        )
                      ),
                    ),
                  ],
                ),
              ),
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth < 600) {
                      return const BuildCard(crossAxisCount: 2);
                    } else if (constraints.maxWidth < 900) {
                      return const BuildCard(crossAxisCount: 3);
                    } else if (constraints.maxWidth < 1300) {
                      return const BuildCard(crossAxisCount: 4);
                    } else {
                      return const BuildCard(crossAxisCount: 5);
                    }
                  },
                ),
            ],
          ),
        ),
    );
  }
}

class BuildCard extends StatelessWidget {
  final int crossAxisCount;
  const BuildCard({Key? key, required this.crossAxisCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: listfilm.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 330
        ),
      itemBuilder: (context, index){
        return InkWell(
          onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(film: listfilm.elementAt(index));
          }));},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Image.asset(listfilm.elementAt(index).linkcover, 
                height: 250,
                width: double.infinity,
                fit: BoxFit.fill,),
                const Divider(thickness: 4,color: Colors.black),
                Row(
                  children: [
                    Text(listfilm.elementAt(index).judul,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                Row(
                  children: [
                    Text(listfilm.elementAt(index).tahunRilis+ '  |  '),
                    Text(listfilm.elementAt(index).rating.toString())
                  ],
                ),
              ],
            ),
          ),
        );
  });
  }
}