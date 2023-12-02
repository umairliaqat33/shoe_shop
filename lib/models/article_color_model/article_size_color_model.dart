import 'package:json_annotation/json_annotation.dart';

part 'article_size_color_model.g.dart';

@JsonSerializable()
class ArticleSizeColorModel {
  final int color;
  final int quantity;
  final String colorName;
  ArticleSizeColorModel({
    required this.color,
    required this.quantity,
    required this.colorName,
  });

  factory ArticleSizeColorModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleSizeColorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleSizeColorModelToJson(this);
}
