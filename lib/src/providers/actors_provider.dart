import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/actors_model.dart';

class ActorsProvider {
  String _apiKey = '36f48d05f33340945bc413ff91e48fe2';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';

  Future<List<Actor>> getCastByMovieId(String movieId) async {
    final uri = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });
    return await process(uri);
  }

  Future<List<Actor>> process(Uri uri) async {
    final resp = await http.get(uri);
    final data = json.decode(resp.body);
    final cast = Cast.fromJsonList(data['cast']);
    return cast.actors;
  }
}
