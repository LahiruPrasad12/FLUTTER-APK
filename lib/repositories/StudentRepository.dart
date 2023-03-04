import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/models/student.dart';

class StudentRepository {
  final CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection('students');

  List<Student> recipiesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Student(
        "1",
        e.get("name"),
        e.get("birthday"),
      );
    }).toList();
  }

  Stream<List<Student>> listStudents() {
    return _studentCollection.snapshots().map(recipiesList);
  }

  Future<void> addStudent(Student student) {
    return _studentCollection.add(student.toMap());
  }

  Future<void> updateStudent(Student student) {
    return _studentCollection.doc(student.studentID).update(student.toMap());
  }

  Future<void> deleteStudent(Student student) {
    return _studentCollection.doc(student.studentID).delete();
  }
}
