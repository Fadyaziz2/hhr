class AppoinmentBody {
  String? title;
  String? description;
  String? location;
  String? date;
  String? appoinmentStartDate;
  String? appoinmentEndDate;
  int? appoinmentWith;
  String? attachmentFile;

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['location'] = location;
    map['date'] = date;
    map['appoinment_with'] = appoinmentWith;
    map['appoinment_start_at'] = appoinmentStartDate;
    map['appoinment_end_at'] = appoinmentEndDate;
    map['attachment_file'] = attachmentFile;
    return map;
  }
}
