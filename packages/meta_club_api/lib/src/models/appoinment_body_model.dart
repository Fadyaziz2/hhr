class AppointmentBody {
  String? title;
  String? description;
  String? location;
  String? date;
  String? appointmentStartDate;
  String? appointmentEndDate;
  int? appointmentWith;
  int? previewId;

  AppointmentBody() {
    title = this.title;
    description = this.description;
    location = this.location;
    date = this.date;
    appointmentStartDate = this.appointmentStartDate;
    appointmentEndDate = this.appointmentEndDate;
    appointmentWith = this.appointmentWith;
    previewId = previewId;
  }
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['location'] = location;
    map['date'] = date;
    map['appoinment_with'] = appointmentWith;
    map['appoinment_start_at'] = appointmentStartDate;
    map['appoinment_end_at'] = appointmentEndDate;
    map["file_id"] = previewId;
    return map;
  }
}
