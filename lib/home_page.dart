import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  fetchMovies() async {
    var url;
    url = await http.get(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=1500496dcaf1512b62894bd98ba83f9d&language=en-US");
    return json.decode(url.body)['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191826),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'MOVIES',
          style: TextStyle(fontSize: 25.0, color: Color(0xfff43370)),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff191826),
      ),
      body: FutureBuilder(
          future: fetchMovies(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Container(
                        height: 250,
                        alignment: Alignment.centerLeft,
                        child: Card(
                          child: Image.network(
                              "https://image.tmdb.org/t/p/w500" +
                                  snapshot.data[index]['poster_path']),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                snapshot.data[index]["original_title"],
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data[index]["release_date"],
                                style: TextStyle(color: Color(0xff868597)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 100,
                                child: Text(
                                  snapshot.data[index]["overview"],
                                  style: TextStyle(color: Color(0xff868597)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
