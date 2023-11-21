class BodyVisitNote{
  String? note;

  BodyVisitNote({
    this.note
});

  Map<String,dynamic> toJson() => {
    "note" : note
  };
}