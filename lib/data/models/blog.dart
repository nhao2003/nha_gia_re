class Blog {
  String id;
  DateTime createAt;
  String title;
  String shortDescription;
  String author;
  String content;
  String imageLink;
  int view;

  Blog({
    required this.id,
    required this.createAt,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.author,
    required this.imageLink,
    required this.view,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] as String,
      createAt: DateTime.parse(json['create_at'] as String),
      title: json['title'] as String,
      shortDescription: json['short_description'] as String,
      author: json['author'] as String,
      content: json['content'] as String,
      imageLink: json['image_link'] as String,
      view: json['view_count'],
    );
  }
}
