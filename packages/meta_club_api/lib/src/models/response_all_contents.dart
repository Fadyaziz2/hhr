import 'package:equatable/equatable.dart';

class ResponseAllContents extends Equatable {
  bool? result;
  String? message;
  ContentData? data;

  ResponseAllContents({
    this.result,
    this.message,
    this.data,
  });

  factory ResponseAllContents.fromJson(Map<String, dynamic> json) =>
      ResponseAllContents(
        result: json["result"],
        message: json["message"],
        data: json["data"] == null ? null : ContentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": data?.toJson(),
      };
  @override
  List<Object?> get props => [result, message, data];
}

class ContentData extends Equatable {
  List<ContentDatum>? contents;

  ContentData({
    this.contents,
  });

  factory ContentData.fromJson(Map<String, dynamic> json) => ContentData(
        contents: json["contents"] == null
            ? []
            : List<ContentDatum>.from(
                json["contents"]!.map((x) => ContentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contents": contents == null
            ? []
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
      };
  @override
  List<Object?> get props => [contents];
}

class ContentDatum extends Equatable {
  int? id;
  int? companyId;
  int? userId;
  String? type;
  String? title;
  String? slug;
  String? content;
  String? metaTitle;
  String? metaDescription;
  String? keywords;
  String? metaImage;
  int? createdBy;
  int? updatedBy;
  int? statusId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? branchId;

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
    this.createdBy,
    this.updatedBy,
    this.statusId,
    this.createdAt,
    this.updatedAt,
    this.branchId,
  });

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
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        statusId: json["status_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        branchId: json["branch_id"],
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
        "created_by": createdBy,
        "updated_by": updatedBy,
        "status_id": statusId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "branch_id": branchId,
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
        metaImage,
        createdBy,
        updatedBy,
        statusId,
        createdAt,
        updatedAt,
        branchId
      ];
}
