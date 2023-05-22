import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stock_app/common/styles.dart';
import 'package:stock_app/pages/book_detail.dart';
import 'package:stock_app/service/api_service.dart';

import '../models/book.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({Key? key}) : super(key: key);
  static const routeName = '/book_search';
  @override
  BookSearchPageState createState() => BookSearchPageState();
}

class BookSearchPageState extends State<BookSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<Book> _books = [];
  bool _isLoading = false;

  Future <void> _searchBooks(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await _apiService.searchBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      // Handle error here
      debugPrint('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Book Search', style: TextStyle(color: accentColor3),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: primaryColor),
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search books',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchBooks(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_books.isEmpty)
            const Center(
              child: Text('No books found', style: TextStyle(color: accentColor4),),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];

                  return Card(
                    color: accentColor3,
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: SizedBox(
                        width: 80.0, // Provide a specific width here
                        child: book.thumbnailUrl.isNotEmpty
                            ? Image.network(book.thumbnailUrl)
                            : Container(),
                      ),
                      title: Text(book.title, style: TextStyle(color: accentColor1, fontWeight: FontWeight.bold),),
                      subtitle: Text(book.author, style: TextStyle(fontWeight: FontWeight.bold),),
                      onTap: () {
                        // Handle book tap
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookDetailPage(book: book)));
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
