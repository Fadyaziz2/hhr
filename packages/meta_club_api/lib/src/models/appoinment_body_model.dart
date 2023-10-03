class AppoinmentBody {
  String? title;
  String? description;
  String? location;
  String? date;
  String? appoinmentStartDate;
  String? appoinmentEndDate;
  int? appoinmentWith;
  int? previewId;

  AppoinmentBody() {
    title = this.title;
    description = this.description;
    location = this.location;
    date = this.date;
    appoinmentStartDate = this.appoinmentStartDate;
    appoinmentEndDate = this.appoinmentEndDate;
    appoinmentWith = this.appoinmentWith;
    previewId = previewId;
  }
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['location'] = location;
    map['date'] = date;
    map['appoinment_with'] = appoinmentWith;
    map['appoinment_start_at'] = appoinmentStartDate;
    map['appoinment_end_at'] = appoinmentEndDate;
    map["file_id"] = previewId;
    return map;
  }
}
