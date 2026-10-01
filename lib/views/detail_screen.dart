import 'package:flutter/material.dart';
import '../models/book.dart';
import 'form_screen.dart';

class DetailScreen extends StatefulWidget {
  final Book book;
  final Function(Book) onUpdate;
  final Function(String) onDelete;

  const DetailScreen({
    super.key,
    required this.book,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Book _currentBook;

  @override
  void initState() {
    super.initState();
    _currentBook = widget.book;
  }

  void _navigateToEdit() async {
    final updatedBook = await Navigator.push<Book>(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(bookToEdit: _currentBook),
      ),
    );

    if (updatedBook != null) {
      setState(() {
        _currentBook = updatedBook;
      });
      widget.onUpdate(updatedBook);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Livro atualizado com sucesso!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentBook.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Editar Livro',
            onPressed: _navigateToEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Excluir Livro',
            onPressed: () {
              widget.onDelete(_currentBook.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.menu_book,
                  size: 48,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _currentBook.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Autor: ${_currentBook.author}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(_currentBook.genre),
            ),
            const Divider(height: 32),
            Text(
              'Avaliação do Leitor:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < _currentBook.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber[700],
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${_currentBook.rating} / 5',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}