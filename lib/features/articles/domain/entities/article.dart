class Article {
  String publishedDate;
  String title;
  Article({
    required this.publishedDate,
    required this.title,
  });

  @override
  String toString() => 'Article(publishedDate: $publishedDate, title: $title)';
}
