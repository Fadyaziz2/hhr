import 'package:equatable/equatable.dart';

class ResponseAllContents extends Equatable {
  ResponseAllContents({
    this.result,
    this.message,
    this.data,
  });

  bool? result;
  String? message;
  ContentData? data;

  factory ResponseAllContents.fromJson(Map<String, dynamic> json) =>
      ResponseAllContents(
        result: json["result"],
        message: json["message"],
        data: ContentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data!.toJson(),
      };

  @override
  List<Object?> get props => [
        result,
        message,
        data,
      ];
}

class ContentData extends Equatable {
  ContentData({
    this.contents,
  });

  final List<Content>? contents;

  factory ContentData.fromJson(Map<String, dynamic> json) => ContentData(
        contents: List<Content>.from(
            json["contents"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contents": List<dynamic>.from(contents!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [contents];
}

class ContentDatum extends Equatable {
  ContentDatum({
    this.id,
    this.companyId,
    this.userId,
    this.type,
    this.title,
    this.slug,
    this.content,
    this.metaTitle,
    this.metaDescription,
    this.keywords,
    this.metaImage,
  });

  int? id;
  int? companyId;
  int? userId;
  String? type;
  String? title;
  String? slug;
  String? content;
  String? metaTitle;
  dynamic metaDescription;
  String? keywords;
  String? metaImage;

  factory ContentDatum.fromJson(Map<String, dynamic> json) => ContentDatum(
        id: json["id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        type: json["type"],
        title: json["title"],
        slug: json["slug"],
        content: json["content"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        keywords: json["keywords"],
        metaImage: json["meta_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "user_id": userId,
        "type": type,
        "title": title,
        "slug": slug,
        "content": content,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "keywords": keywords,
        "meta_image": metaImage,
      };

  @override
  List<Object?> get props => [
        id,
        companyId,
        userId,
        type,
        title,
        slug,
        content,
        metaTitle,
        metaDescription,
        keywords,
        metaImage
      ];
}
