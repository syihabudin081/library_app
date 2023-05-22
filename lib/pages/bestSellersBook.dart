import 'package:flutter/material.dart';
import 'package:stock_app/pages/bookDetail.dart';
import 'package:stock_app/pages/homePage.dart';
import 'package:stock_app/service/api_service.dart';

import '../models/book.dart';

class BestSellerBooks extends StatefulWidget {
  const BestSellerBooks({Key? key}) : super(key: key);
  static const routeName = '/best_seller';
  @override
  BestSellerBooksState createState() => BestSellerBooksState();
}

class BestSellerBooksState extends State<BestSellerBooks> {
  final ApiService _apiService = ApiService();
  List<Book> _books = [];
  bool _isLoading = false;

  void _getBooks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await _apiService.getTopSellersBook();
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
  void initState() {
    super.initState();
    _getBooks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Best Seller Books'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isLoading)
          const Center(
            child:  CircularProgressIndicator(),
          )
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

