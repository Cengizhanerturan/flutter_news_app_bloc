import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String? content;

  const NewsModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromMap(Map<String, dynamic> json) {
    return NewsModel(
      source: Source.decoder(json["source"]),
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"] ?? '',
      publishedAt: DateTime.parse(json["publishedAt"]),
      content: json["content"],
    );
  }

  Map<String, dynamic> toMap() => {
    "source": source.toMap(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content,
  };

  static List<NewsModel> decoder(dynamic data) {
    return (data as List)
        .map((e) => NewsModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  List<Object?> get props => [title, urlToImage, content];
}

class Source {
  final String? id;
  final String name;

  Source({required this.id, required this.name});

  factory Source.fromMap(Map<String, dynamic> json) =>
      Source(id: json["id"], name: json["name"]);

  Map<String, dynamic> toMap() => {"id": id, "name": name};

  static Source decoder(dynamic data) {
    final map = Map<String, dynamic>.from(data);
    return Source.fromMap(map);
  }
}
