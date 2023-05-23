import 'package:flutter/material.dart';
import 'package:stock_app/common/styles.dart';
import 'package:stock_app/models/book.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor3,
      appBar: AppBar(
        title: Text(
          book.title,
          style: const TextStyle(color: accentColor3),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              book.thumbnailUrl.isNotEmpty
                  ? Image.network(book.thumbnailUrl)
                  : const Image(
                      image: AssetImage('assets/images/no-thumbnail.png'),
                    ),
              const SizedBox(height: 16.0),
              Text(
                'Author: ${book.author}',
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Publisher: ${book.publisher}',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Average Rating: ${book.averageRating}',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Description:',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: accentColor1),
              ),
              const SizedBox(height: 8.0),
              book.description.isNotEmpty
                  ? Text(
                      book.description,
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.justify,
                    )
                  : const Text('No description available'),
              const SizedBox(height: 32.0),
              IconButton(
                onPressed: () {
                  launchURL("https://books.google.co.id/books?id=${book.id}");
                },
                icon: const Icon(
                  Icons.travel_explore,
                ),
                iconSize: 35,
                color: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
