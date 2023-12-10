// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      articleNumber: json['articleNumber'] as String,
      articleSizeModelList: (json['articleSizeModelList'] as List<dynamic>)
          .map((e) => ArticleSizeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'articleNumber': instance.articleNumber,
      'articleSizeModelList':
          instance.articleSizeModelList.map((e) => e.toJson()).toList(),
    };
