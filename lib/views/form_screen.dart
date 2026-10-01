import 'package:flutter/material.dart';
import '../models/book.dart';

class FormScreen extends StatefulWidget {
  final Book? bookToEdit;

  const FormScreen({super.key, this.bookToEdit});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _genreController;
  int _rating = 3;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.bookToEdit?.title ?? '');
    _authorController = TextEditingController(text: widget.bookToEdit?.author ?? '');
    _genreController = TextEditingController(text: widget.bookToEdit?.genre ?? '');
    _rating = widget.bookToEdit?.rating ?? 3;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _genreController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final book = Book(
        id: widget.bookToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        genre: _genreController.text.trim(),
        rating: _rating,
      );
      Navigator.pop(context, book);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.bookToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Livro' : 'Novo Livro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título do Livro',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o título do livro';
                  }
                  if (value.trim().length < 2) {
                    return 'O título deve ter pelo menos 2 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Autor',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o autor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _genreController,
                decoration: const InputDecoration(
                  labelText: 'Gênero literário',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o gênero literário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Nota (1 a 5 estrelas):',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Slider(
                value: _rating.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: '$_rating estrelas',
                onChanged: (val) {
                  setState(() {
                    _rating = val.round();
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _save,
                icon: const Icon(Icons.check),
                label: Text(isEditing ? 'Salvar Alterações' : 'Cadastrar Livro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}