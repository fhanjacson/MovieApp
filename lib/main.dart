import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'movielist.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkModeEnabled = false;
  var movies;
  static String apiKey = '400d1db0ec96a230ff11515ef71fc9e1';
  String apiUrl = 'http://api.themoviedb.org/3/discover/movie?api_key=$apiKey';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: isDarkModeEnabled ? Brightness.dark : Brightness.light,
            primarySwatch: Colors.purple),
        home: Scaffold(
            appBar: AppBar(
              title: Text('MovieApp'),
              centerTitle: true,
              actions: <Widget>[
                Switch(
                  value: isDarkModeEnabled,
                  onChanged: (bool newValue) {
                    setState(() {
                      isDarkModeEnabled = newValue;
                    });
                  },
                  activeColor: Colors.grey,
                  inactiveThumbColor: Colors.lime,
                )
              ],
            ),
            body: movies == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (BuildContext context, i) {
                        return MovieList(movie: movies[i]);
                      },
                    ),
                    onRefresh: _refreshController,
                  )));
  }

  @override
  void initState() {
    fetchMovies();
    super.initState();
  }

  void fetchMovies() async {
    var response = await http.get(apiUrl);
    var data = json.decode(response.body);
    print(data);

    setState(() {
      movies = data['results'];
    });
  }

  Future<Null> _refreshController() async {
    setState(() {
      movies = null;
    });

    fetchMovies();
  }
}
