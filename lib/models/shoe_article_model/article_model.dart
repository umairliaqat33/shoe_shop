import 'package:json_annotation/json_annotation.dart';
import 'package:shoe_shop/models/article_size_model/article_size_model.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  final String articleNumber;
  final List<ArticleSizeModel> articleSizeModelList;

  ArticleModel({
    required this.articleNumber,
    required this.articleSizeModelList,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
