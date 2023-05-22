import 'package:flutter/material.dart';
import 'package:stock_app/service/api_service.dart';
import 'package:stock_app/models/book.dart';
import 'package:card_swiper/card_swiper.dart';

class BookCategories extends StatefulWidget {
  const BookCategories({Key? key}) : super(key: key);
  static const routeName = '/book_categories';
  @override
  BookCategoriesState createState() => BookCategoriesState();
}

class BookCategoriesState extends State<BookCategories> {
  final ApiService _apiService = ApiService();
  List<Book> _books = [];
  bool _isLoading = false;
  String _category = '';
  var listCategory = ["Technology", "Business", "Biography", "Computers"];

  void _changeCategory(String category) {
    setState(() {
      _category = category;
      _getCategory();
    });
  }

  void _getCategory() {
    switch (_category) {
      case 'Computers':
        return _getBooks(_category);
      case 'Fiction':
        return _getBooks(_category);
      default:
        return _getBooks(_category);
        ;
    }
  }

  void _getBooks(String category) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await _apiService.getBooksByCategory(category);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => _changeCategory('Computers'),
                    child: const Text('Computers'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeCategory('Fiction'),
                    child: const Text('Fiction'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeCategory('Biography'),
                    child: const Text('Biography'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeCategory('Business'),
                    child: const Text('Business'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeCategory('Entertainment'),
                    child: const Text('Entertainment'),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            CircularProgressIndicator()
          else if (_books.isEmpty)
            const Center(
              child: Text('No books found'),
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
