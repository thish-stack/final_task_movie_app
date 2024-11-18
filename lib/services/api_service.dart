import 'package:dio/dio.dart';
import '../models/media.dart';

class ApiService {
  static const String moviesUrl = 'http://10.10.1.135:3002/tophundredmovies';
  static const Map<String, String> headers = {
    'auth': 'e2fc714c4727ee9395f324cd2e7f331f',
  };

  final Dio _dio = Dio();

  Future<List<Media>> fetchMedia() async {
    try {
      final response = await _dio.get(moviesUrl, options: Options(headers: headers));
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((item) => Media.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
