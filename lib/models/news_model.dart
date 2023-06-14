class News {
  List<Data>? data;

  News({this.data});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      data: json['data'] != null
          ? List<Data>.from(json['data'].map((x) => Data.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
    };
  }
}

class Data {
  String? title;
  String? description;
  String? author;
  String? url;
  int? updated_at;
  String? news_site;
  String? thumb_2x;

  Data({
    this.title,
    this.description,
    this.author,
    this.url,
    this.updated_at,
    this.news_site,
    this.thumb_2x,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'],
      description: json['description'],
      author: json['author'],
      url: json['url'],
      updated_at: json['updated_at'],
      news_site: json['news_site'],
      thumb_2x: json['thumb_2x'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'author': author,
      'url': url,
      'updated_at': updated_at,
      'news_site': news_site,
      'thumb_2x': thumb_2x,
    };
  }
}