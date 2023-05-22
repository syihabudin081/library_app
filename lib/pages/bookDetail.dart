import 'package:flutter/material.dart';
import 'package:stock_app/models/book.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              book.thumbnailUrl != null && book.thumbnailUrl!.isNotEmpty
                  ? Image.network(book.thumbnailUrl!)
                  : const Text('No image available'),

              SizedBox(height: 16.0),
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
