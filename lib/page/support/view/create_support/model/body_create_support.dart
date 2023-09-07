import 'package:equatable/equatable.dart';

class BodyCreateSupport {
  String? subject;
  String? description;
  int? priorityId;
  String? previewURL;

  BodyCreateSupport({String? subject, String? description, int? priority,String? previewUrl}) {
    subject = this.subject;
    description = this.description;
    priority = priorityId;
    previewUrl = previewURL;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["subject"] = subject;
    map["description"] = description;
    map["priority_id"] = priorityId;
    map["preview_url"] = previewURL;

    return map;
  }
}

class BodyPrioritySupport{
  int? priorityId;
  String? priorityName;

  BodyPrioritySupport({String? priorityName, int? priorityId}) {
    priorityId = this.priorityId;
    priorityName = this.priorityName;
  }

  Map<String, dynamic> toJson(){
    var map = <String, dynamic>{};
    map["priority_id"] = priorityId;
    map["priority_name"] = priorityName;
    return map;
  }
}
