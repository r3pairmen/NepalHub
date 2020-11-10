import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_news/domain/entities/news_category_entity.dart';

class NewsCategoryModel extends NewsCategoryEntity {
  NewsCategoryModel({
    @required String id,
    @required String title,
    @required String code,
    @required String icon,
    @required int priority,
    @required bool isFollowed,
    @required int followerCount,
    @required bool isBlocked,
    @required Language language,
    @required DateTime updatedAt,
    @required DateTime createdAt,
  }) : super(
            id: id,
            title: title,
            code: code,
            icon: icon,
            priority: priority,
            isFollowed: isFollowed,
            followerCount: followerCount,
            isBlocked: isBlocked,
            language: language,
            updatedAt: updatedAt,
            createdAt: createdAt);

  factory NewsCategoryModel.fromJson(String str) =>
      NewsCategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewsCategoryModel.fromMap(Map<String, dynamic> json) =>
      NewsCategoryModel(
        id: json["id"].toString(),
        title: json["title"],
        code: json["code"],
        priority: json["priority"],
        language: (json["language"] as String).toLanguage,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        icon: (json["icon"] != null) ? json["icon"]["url"] : null,
        isFollowed: json["is_followed"],
        followerCount: json["follower_count"],
        isBlocked: json["is_blocked"],
      );
}
