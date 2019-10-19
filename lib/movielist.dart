import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  final movie;
  MovieList({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 8.0,
      margin: EdgeInsets.all(16.0),
      child: InkWell(
        radius: 8.0,
        child: getCardView(context, movie),
        onTap: () {},
      ),
    );
  }
}

getCardView(BuildContext context, movie) {
  String imageUrl = 'https://image.tmdb.org/t/p/w500';
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Hero(
        tag: movie['poster_path'],
        child: Container(
          height: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
                image: NetworkImage(imageUrl + movie['poster_path']),
                fit: BoxFit.cover),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              movie['title'] + ' (' + movie['vote_average'].toString() + ')',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Release: ' + movie['release_date'],
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              movie['overview'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ],
  );
}
