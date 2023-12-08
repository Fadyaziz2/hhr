import 'package:equatable/equatable.dart';

class CompanyListModel extends Equatable {
  final bool? result;
  final String? message;
  final List<CompanyList>? companyList;

  const CompanyListModel({
    this.result,
    this.message,
    this.companyList,
  });

  factory CompanyListModel.fromJson(Map<String, dynamic> json) =>
      CompanyListModel(
        result: json["result"],
        message: json["message"],
        companyList: json["data"] == null ? [] : List<CompanyList>.from(
            json["data"]!.map((x) => CompanyList.fromJson(x))),
      );

  @override
  List<Object?> get props => [result, message, companyList];

}

class CompanyList extends Equatable{
  final int? id;
  final String? companyName;
  final String? subdomain;
  final String? url;

  const CompanyList({
    this.id,
    this.companyName,
    this.subdomain,
    this.url,
  });

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    id: json["id"],
    companyName: json["company_name"],
    subdomain: json["subdomain"],
    url: json["url"],
  );

  @override
  List<Object?> get props => [id, companyName, subdomain,url];
}
