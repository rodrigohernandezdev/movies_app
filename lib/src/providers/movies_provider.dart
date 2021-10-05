import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = '36f48d05f33340945bc413ff91e48fe2';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';
  int _popularPage = 0;
  bool _loading = false;
  List<Movie> _popularMovies = [];
  final _popularController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularController.sink.add;

  Stream<List<Movie>> get popularStream => _popularController.stream;

  Future<List<Movie>> process(Uri uri) async {
    final resp = await http.get(uri);
    final data = json.decode(resp.body);
    final movies = Movies.fromJsonList(data['results']);
    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final uri = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});
    return await process(uri);
  }

  Future<List<Movie>> getPopularMovies() async {
    //print(_loading);
    if (_loading) return [];
    _loading = true;
    _popularPage++;
    final uri = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });
    final resp = await process(uri);
    _popularMovies.addAll(resp);
    popularSink(_popularMovies);
    _loading = false;
    return resp;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final uri = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });
    return await process(uri);
  }

  void dispose() {
    _popularController?.close();
  }
}
