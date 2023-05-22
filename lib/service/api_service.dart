import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_app/models/book.dart';

class ApiService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<List<Book>> searchBooks(String query) async {
    final api_key = "AIzaSyD_6iFIRzBVpFzRFR2mvU8jjUUWXiJaAFw";
    final url = Uri.parse('$_baseUrl?q=$query&key=$api_key');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final List<Book> books = [];
      final List<dynamic> items = json['items'];

      for (final item in items) {
        final volumeInfo = item['volumeInfo'];

        final book = Book(
          title: volumeInfo['title'] ?? '',
          author: volumeInfo['authors']?.join(', ') ?? '',
          description: volumeInfo['description'] ?? '',
          thumbnailUrl: volumeInfo['imageLinks']?['thumbnail'] ?? '',
          publisher: volumeInfo['publisher'] ?? '',
          averageRating: volumeInfo['averageRating']?.toString() ?? '0',
        );

        books.add(book);
      }

      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }
}
