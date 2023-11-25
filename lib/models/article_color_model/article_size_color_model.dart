import 'package:json_annotation/json_annotation.dart';

part 'article_size_color_model.g.dart';

@JsonSerializable()
class ArticleSizeColorModel {
  final int color;
  final int quantity;
  ArticleSizeColorModel({
    required this.color,
    required this.quantity,
  });

  factory ArticleSizeColorModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleSizeColorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleSizeColorModelToJson(this);
}
