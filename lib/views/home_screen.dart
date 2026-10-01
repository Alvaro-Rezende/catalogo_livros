import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';
import 'detail_screen.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Book> _books = [];

  void _addBook(Book book) {
    setState(() {
      _books.add(book);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Livro adicionado ao acervo!')),
    );
  }

  void _updateBook(Book updated) {
    setState(() {
      final index = _books.indexWhere((b) => b.id == updated.id);
      if (index != -1) {
        _books[index] = updated;
      }
    });
  }

  void _deleteBook(String id) {
    setState(() {
      _books.removeWhere((b) => b.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Livro removido do acervo.')),
    );
  }

  void _navigateToCreate() async {
    final newBook = await Navigator.push<Book>(
      context,
      MaterialPageRoute(builder: (context) => const FormScreen()),
    );
    if (newBook != null) {
      _addBook(newBook);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Acervo de Livros'),
      ),
      body: _books.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.library_books_outlined,
                      size: 72,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Seu acervo está vazio',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Toque no botão "+" abaixo para cadastrar seu primeiro livro.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return BookCard(
                  book: book,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          book: book,
                          onUpdate: _updateBook,
                          onDelete: _deleteBook,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Adicionar Livro',
        onPressed: _navigateToCreate,
        child: const Icon(Icons.add),
      ),
    );
  }
}