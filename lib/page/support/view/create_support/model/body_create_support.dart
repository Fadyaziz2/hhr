class BodyCreateSupport {
  String? subject;
  String? description;
  String? priority;

  BodyCreateSupport({String? subject, String? description, String? priority}) {
    subject = this.subject;
    description = this.description;
    priority = this.priority;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["subject"] = subject;
    map["description"] = description;
    map["priority_id"] = priority;
    return map;
  }
}

class BodyPrioritySupport {
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
