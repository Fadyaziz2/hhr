import 'package:equatable/equatable.dart';

class SubmitLeaveModel extends Equatable{
  bool? result;
  String? message;

  SubmitLeaveModel({
    this.result,
    this.message,
  });

  factory SubmitLeaveModel.fromJson(Map<String, dynamic> json) => SubmitLeaveModel(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message
  };

  @override
  List<Object?> get props => [result,message];
}
