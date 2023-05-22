import 'package:flutter/material.dart';
import 'package:stock_app/common/styles.dart';
import 'package:stock_app/pages/bookDetail.dart';
import 'package:stock_app/service/api_service.dart';
import 'package:stock_app/models/book.dart';

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
      backgroundColor: secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Book Categories',style: TextStyle(color: accentColor3),),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor1,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeCategory('Fiction'),
                    child: const Text('Fiction'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor1,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeCategory('Biography'),
                    child: const Text('Biography'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor1,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeCategory('Business'),
                    child: const Text('Business'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor1,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _changeCategory('Entertainment'),
                    child: const Text('Entertainment'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            CircularProgressIndicator()
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
