class Blog {
  String id;
  DateTime createAt;
  String title;
  String shortDescription;
  String author;
  String link;
  String imageLink;
  int view;

  Blog({
    required this.id,
    required this.createAt,
    required this.title,
    required this.shortDescription,
    required this.author,
    required this.link,
    required this.imageLink,
    required this.view,
  });
  static List<Blog> fakeBlogList = [
    Blog(
      id: "1",
      createAt: DateTime(2023, 6, 1),
      title: "Blog Title 1",
      shortDescription: "Short description 1",
      author:"Nhật Hào",
      link: "https://example.com/blog/1",
      imageLink: "https://picsum.photos/200/300?random=1",
      view: 100,
    ),
    Blog(
      id: "2",
      createAt: DateTime(2023, 6, 2),
      title: "Blog Title 2",
      shortDescription: "Short description 2",
      author:"Nhật Hào",
      link: "https://example.com/blog/2",
      imageLink: "https://picsum.photos/200/300?random=2",
      view: 200,
    ),
    Blog(
      id: "3",
      createAt: DateTime(2023, 6, 3),
      title: "Blog Title 3",
      shortDescription: "Short description 3",
      author:"Nhật Hào",
      link: "https://example.com/blog/3",
      imageLink: "https://picsum.photos/200/300?random=3",
      view: 300,
    ),
  ];

}
