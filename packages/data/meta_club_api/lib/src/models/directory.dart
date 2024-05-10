class Directories {

  final List<Directory> directories;

  Directories({required this.directories});

  factory Directories.fromJson(Map<String, dynamic> json) {
    return Directories(
        directories: (json['data']['items'] as List)
            .map((e) => Directory.fromJson(e))
            .toList());
  }
}

class Directory {
  final int? id;
  final String? name;
  final String? avatar;
  final String? designation;
  final String? phone;
  final String? email;

  Directory(
      {this.id,
      this.name,
      this.avatar,
      this.designation,
      this.phone,
      this.email});

  factory Directory.fromJson(Map<String, dynamic> json) {
    return Directory(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      designation: json['designation'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'designation': designation,
        'phone': phone,
        'email': email
      };
}
