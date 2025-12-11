import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  @JsonKey(defaultValue: '')
  final String title;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: '')
  final String url;

  @JsonKey(defaultValue: '')
  final String urlToImage;

  @JsonKey(defaultValue: '')
  final String content;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
