// ignore_for_file: dead_code

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/loader.dart';
import 'package:crud/models/student.dart';
import 'package:crud/repositories/StudentRepository.dart';
import 'package:crud/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Confirmation Required"),
                      content: const Text("Are you sure to log out? "),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return const LoginPage();
                            }));
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("students").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Loader();
              }
              // List<Student>? listRecipies = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "All Recipies",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: Colors.grey[600],
                    ),
                    const SizedBox(height: 20),
                    ListView(
                      children: snapshot.data!.docs.map<Widget>((document) {
                        return ListTile(
                          title: Text(document['name']),
                          subtitle: Text(document['birthday']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // StudentRepository().deleteStudent(document.studentId);
                            },
                          ),
                        );
                      }).toList(),
                      shrinkWrap: true,
                      // itemCount: listRecipies!.length,
                      // itemBuilder: (context, index) {
                      //   return ListTile(
                      //     onTap: () => {
                      //       showDialog(
                      //         builder: (context) => SimpleDialog(
                      //           contentPadding: const EdgeInsets.symmetric(
                      //             horizontal: 25,
                      //             vertical: 20,
                      //           ),
                      //           backgroundColor: Colors.grey[800],
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20),
                      //           ),
                      //           title: Row(
                      //             children: [
                      //               const Text(
                      //                 "Add Task",
                      //                 style: TextStyle(
                      //                   fontSize: 20,
                      //                   color: Colors.white,
                      //                 ),
                      //               ),
                      //               const Spacer(),
                      //               IconButton(
                      //                 icon: const Icon(
                      //                   Icons.cancel,
                      //                   color: Colors.grey,
                      //                   size: 30,
                      //                 ),
                      //                 onPressed: () => Navigator.pop(context),
                      //               )
                      //             ],
                      //           ),
                      //           children: [
                      //             const Divider(),
                      //             TextFormField(
                      //               controller: _nameController,
                      //               style: const TextStyle(
                      //                 fontSize: 18,
                      //                 height: 1.5,
                      //                 color: Colors.white,
                      //               ),
                      //               autofocus: true,
                      //               decoration: const InputDecoration(
                      //                 hintText: "type your task here",
                      //                 hintStyle:
                      //                     TextStyle(color: Colors.white70),
                      //                 border: InputBorder.none,
                      //               ),
                      //             ),
                      //             TextFormField(
                      //               controller: _birthdayController,
                      //               style: const TextStyle(
                      //                 fontSize: 18,
                      //                 height: 1.5,
                      //                 color: Colors.white,
                      //               ),
                      //               autofocus: true,
                      //               decoration: const InputDecoration(
                      //                 hintText: "type your ingredients here",
                      //                 hintStyle:
                      //                     TextStyle(color: Colors.white70),
                      //                 border: InputBorder.none,
                      //               ),
                      //             ),
                      //             TextFormField(
                      //               // controller: recipieDescription,
                      //               style: const TextStyle(
                      //                 fontSize: 18,
                      //                 height: 1.5,
                      //                 color: Colors.white,
                      //               ),
                      //               autofocus: true,
                      //               decoration: const InputDecoration(
                      //                 hintText: "type your description here",
                      //                 hintStyle:
                      //                     TextStyle(color: Colors.white70),
                      //                 border: InputBorder.none,
                      //               ),
                      //             ),
                      //             const SizedBox(height: 20),
                      //             SizedBox(
                      //               width: width,
                      //               height: 50,
                      //               child: ElevatedButton(
                      //                 onPressed: () async {
                      //                   if (_nameController.text.isNotEmpty) {
                      //                     await StudentRepository()
                      //                         .updateStudent(Student(
                      //                             listRecipies[index].studentID,
                      //                             _nameController.text.trim(),
                      //                             _birthdayController.text
                      //                                 .trim()));
                      //                     // ignore: use_build_context_synchronously
                      //                     Navigator.pop(context);
                      //                   }
                      //                 },
                      //                 style: ElevatedButton.styleFrom(
                      //                   primary: Colors.blue,
                      //                   minimumSize: const Size(60, 60),
                      //                   elevation: 10,
                      //                 ),
                      //                 child: const Text("Add"),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //         context: context,
                      //       ),
                      //     },
                      //     leading: Text(
                      //       listRecipies[index].name,
                      //       style: const TextStyle(
                      //         fontSize: 25,
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //     title: Text(
                      //       listRecipies[index].birthday,
                      //       style: const TextStyle(
                      //         fontSize: 25,
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //     trailing: TextButton(
                      //       onPressed: () async {
                      //         await StudentRepository().listStudents();
                      //       },
                      //       child: const Icon(Icons.delete),
                      //     ),
                      //   );
                      // },
                    )
                  ],
                ),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
            builder: (context) => SimpleDialog(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 20,
              ),
              backgroundColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  const Text(
                    "Add Task",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              children: [
                const Divider(),
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "type your name here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
                TextFormField(
                  controller: _birthdayController,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.white,
                  ),
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "type your birthday here",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_nameController.text.isNotEmpty) {
                        await StudentRepository().addStudent(Student(
                            "1",
                            _nameController.text.trim(),
                            _birthdayController.text.trim()));
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text("Add"),
                  ),
                )
              ],
            ),
            context: context,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
