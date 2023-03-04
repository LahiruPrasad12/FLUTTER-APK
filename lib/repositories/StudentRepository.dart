import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/student.dart';

class StudentRepository {
  final CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection('students');

  List<Student> studentList(QuerySnapshot snapshot) {
    snapshot.docs.forEach((element) {
      print(element.data());
    });
    return snapshot.docs.map((e) {
      return Student(
        e.id,
        e.get("name"),
        e.get("birthday"),
      );
    }).toList();
  }

  Stream<List<Student>> listStudents() {
    return _studentCollection.snapshots().map(studentList);
  }

  Future<void> addStudent(Student student) {
    return _studentCollection.add(student.toMap());
  }

  Future<void> updateStudent(Student student) {
    return _studentCollection.doc(student.id).update(student.toMap());
  }

  Future<void> deleteStudent(Student student) {
    return _studentCollection.doc(student.id).delete();
  }
}
