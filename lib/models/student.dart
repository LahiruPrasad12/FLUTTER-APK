class Student {
  String studentID;
  String name;
  String birthday;

  Student(this.studentID, this.name, this.birthday);

  Map<String, dynamic> toMap() {
    return {'name': name, 'birthday': birthday};
  }

  factory Student.fromMap(String id, Map<String, dynamic> data) {
    return Student(id, data['name'], data['birthday']);
  }
}
