class Book {
  final String id;
  final String title;
  final String author;
  final String genre;
  final int rating;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.rating,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? genre,
    int? rating,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      rating: rating ?? this.rating,
    );
  }
}