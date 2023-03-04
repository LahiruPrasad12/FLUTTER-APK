import 'dart:convert';

import 'package:crud/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class LoadDummyData extends StatefulWidget {
  const LoadDummyData({super.key});

  @override
  State<LoadDummyData> createState() => _LoadDummyDataState();
}

class _LoadDummyDataState extends State<LoadDummyData> {
  late Future<List<String>> _data;

  Future<List<String>> fetchData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body) as List<dynamic>;
      log('data: $jsonList');
      log("message");
      return jsonList.map((e) => e['name'] as String).toList();
    } else {
      throw Exception("Faild load");
    }
  }

  @override
  void initState() {
    super.initState();
    _data = fetchData();
  }

  _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Load Data"),
      ),
      body: Column(
        children: [
          Center(
              child: ElevatedButton(
            onPressed: _navigateToLogin,
            child: const Text("Login"),
          )),
          Center(
              child: FutureBuilder<List<String>>(
            future: _data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index]),
                    );
                  },
                  itemCount: snapshot.data?.length,
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return const CircularProgressIndicator();
            },
          )),
        ],
      ),
    );
  }
}
