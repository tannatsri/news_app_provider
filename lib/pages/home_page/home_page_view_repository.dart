class NewsArticle {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  NewsArticle({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  NewsArticle copyWith({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) =>
      NewsArticle(
        source: source ?? this.source,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  factory NewsArticle.fromMap(Map<String, dynamic> json) => NewsArticle(
    source: json['source'] == null ? null : Source.fromMap(json['source']),
    author: json['author'],
    title: json['title'],
    description: json['description'],
    url: json['url'],
    urlToImage: json['urlToImage'],
    publishedAt: json['publishedAt'],
    content: json['content'],
  );

  @override
  String toString() {
    return '{ source: ${source.toString()}, author: $author, title: $title }';
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  factory Source.fromMap(Map<String, dynamic> json) => Source(
    id: json['id'],
    name: json['name'],
  );

  @override
  String toString() {
    return '{ id: $id, name: $name }';
  }
}

class NewsResponseData {
  String? status;
  int? totalResults;
  List<NewsArticle>? articles;

  NewsResponseData({this.status, this.totalResults, this.articles});

  factory NewsResponseData.fromMap(Map<String, dynamic> json) =>
      NewsResponseData(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: (json['articles'] as List<dynamic>?)
            ?.map((article) => NewsArticle.fromMap(article))
            .toList(),
      );

  @override
  String toString() {
    return '{ status: $status, totalResults: $totalResults, articles: ${articles.toString()} }';
  }
}
