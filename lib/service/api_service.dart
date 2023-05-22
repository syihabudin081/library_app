import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stock_app/models/book.dart';

class ApiService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  static const String api_key = "AIzaSyD_6iFIRzBVpFzRFR2mvU8jjUUWXiJaAFw";

  Future<List<Book>> searchBooks(String query) async {
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
          averageRating: volumeInfo['averageRating']?.toString() ?? 'Not yet rated.',
        );

        books.add(book);
      }

      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Book>> getBooksByCategory(String category) async {
    final url = Uri.parse('$_baseUrl?q=subject:$category&key=$api_key');
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
          averageRating: volumeInfo['averagerating']?.toString() ?? 'Not yet rated.',
        );

        books.add(book);
      }

      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<Book>> getTopSellersBook() async {
    final url = Uri.parse('$_baseUrl?q=best sellers&key=$api_key');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final List<Book> books = [];
      final List<dynamic> items = json['items'];

      for (final item in items) {
        final volumeInfo = item['volumeInfo'];

        final book = Book(
          title: volumeInfo['title'] ?? '',
          author: volumeInfo['authors']?.join(', ') ?? 'Unknown author.',
          description: volumeInfo['description'] ?? 'No description available.',
          thumbnailUrl: volumeInfo['imageLinks']?['thumbnail'] ?? '',
          publisher: volumeInfo['publisher'] ?? 'Unknown publsher.',
          averageRating: volumeInfo['averagerating']?.toString() ?? 'Not yet rated.',
        );

        books.add(book);
      }

      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }
}
