class Job {
  int id;
  String? userId;
  String company;
  String position;
  String state;
  String city;
  String time;
  String salary;
  String telefon;
  String? img;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Job({
    required this.id,
    this.userId,
    required this.company,
    required this.position,
    required this.state,
    required this.city,
    required this.time,
    required this.salary,
    required this.telefon,
    this.img,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a Job object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'company': company,
      'position': position,
      'state': state,
      'city': city,
      'time': time,
      'salary': salary,
      'telefon': telefon,
      'img': img,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Factory constructor to create a Job object from JSON.
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      userId: json['user_id'],
      company: json['company'],
      position: json['position'],
      state: json['state'],
      city: json['city'],
      time: json['time'],
      salary: json['salary'],
      telefon: json['telefon'],
      img: json['img'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
