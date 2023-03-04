class Student {
  String id;
  String name;
  String birthday;

  Student(this.id, this.name, this.birthday);

  Map<String, dynamic> toMap() {
    return {'name': name, 'birthday': birthday};
  }

  factory Student.fromMap(String id, Map<String, dynamic> data) {
    return Student(id, data['name'], data['birthday']);
  }
}
