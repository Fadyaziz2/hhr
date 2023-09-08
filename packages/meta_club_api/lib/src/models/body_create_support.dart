
import 'package:equatable/equatable.dart';

class BodyCreateSupport {
  String? subject;
  String? description;
  int? priorityId;
  int? previewId;

  BodyCreateSupport({String? subject, String? description, int? priority,int? previewId}) {
    subject = this.subject;
    description = this.description;
    priority = priorityId;
    previewId = this.previewId;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["subject"] = subject;
    map["description"] = description;
    map["priority_id"] = priorityId;
    map["file_id"] = previewId;

    return map;
  }
}

class BodyPrioritySupport extends Equatable{
  final int? priorityId;
  final String? priorityName;

  BodyPrioritySupport({this.priorityName, this.priorityId});

  Map<String, dynamic> toJson(){
    var map = <String, dynamic>{};
    map["priority_id"] = priorityId;
    map["priority_name"] = priorityName;
    return map;
  }

  @override
  List<Object?> get props => [priorityId,priorityName];
}
