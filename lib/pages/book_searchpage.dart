import 'package:flutter/material.dart';
import 'package:stock_app/pages/bookDetail.dart';
import 'package:stock_app/pages/homePage.dart';
import 'package:stock_app/service/api_service.dart';

import '../models/book.dart';

class BookSearchPage extends StatefulWidget {
  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<Book> _books = [];
  bool _isLoading = false;

  void _searchBooks(String query) async {
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
      print('Error: $e');
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
      appBar: AppBar(
        title: Text('Book Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
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
            CircularProgressIndicator()
          else if (_books.isEmpty)
            Text('No books found')
          else
            Expanded(
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];

                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: SizedBox(
                        width: 80.0, // Provide a specific width here
                        child: book.thumbnailUrl.isNotEmpty
                            ? Image.network(book.thumbnailUrl)
                            : Container(),
                      ),
                      title: Text(book.title),
                      subtitle: Text(book.author),
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

