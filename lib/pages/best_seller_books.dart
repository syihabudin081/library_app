import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stock_app/common/styles.dart';
import 'package:stock_app/pages/book_detail.dart';
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

  Future <void> _getBooks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await _apiService.getTopSellersBook();
      if(mounted){
        setState(() {
        _books = books;
      });
      }
    } catch (e) {
      // Handle error here
      debugPrint('Error: $e');
    } finally {
      if(mounted){
        setState(() {
        _isLoading = false;
      });
      }
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
      backgroundColor: secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Best Seller Books', style: TextStyle(color: accentColor3),),
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
                    color: accentColor3,
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: SizedBox(
                        width: 80.0, // Provide a specific width here
                        child: book.thumbnailUrl.isNotEmpty
                            ? Image.network(book.thumbnailUrl)
                            : Container(),
                      ),
                      title: Text(book.title, style: const TextStyle(color: accentColor1, fontWeight: FontWeight.bold),),
                      subtitle: Text(book.author, style: const TextStyle(fontWeight: FontWeight.bold),),
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

