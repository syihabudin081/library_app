import 'package:flutter/material.dart';
import 'package:stock_app/common/styles.dart';
import 'package:stock_app/models/book.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor3,
      appBar: AppBar(
        title: Text(book.title, style: TextStyle(color: accentColor3),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              book.thumbnailUrl.isNotEmpty
                  ? Image.network(book.thumbnailUrl)
                  : const Image(image: AssetImage('assets/images/no-thumbnail.png'),),

              const SizedBox(height: 16.0),
              Text(
                'Author: ${book.author}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Publisher: ${book.publisher}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Average Rating: ${book.averageRating}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Description:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              book.description != null && book.description!.isNotEmpty ?
                Text(
                  book.description!,
                  style: TextStyle(fontSize: 16.0),
                ) : Text('No description available'),
            ],
          ),
        ),
      ),
    );
  }
}
