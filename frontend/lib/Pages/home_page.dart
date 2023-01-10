import 'package:flutter/material.dart';
import 'package:frontend/Constants/api.dart';
import 'package:frontend/Models/Todo.dart';
import 'package:frontend/widgets/Todo_container.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> myTodos = [];
  bool isLoading = true;
  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(api));
      var data = json.decode(response.body);
      data.forEach((todo) {
        Todo t = Todo(
            id: todo["id"],
            title: todo["title"],
            desc: todo["desc"],
            isDone: todo["isDone"],
            date: todo["date"]);
        myTodos.add(t);
      });
      // var aa = response.body;
      // aa = json.decode(aa);
      // print(aa);
      // ignore: avoid_print
      print(myTodos.length);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error is $e");
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF001133),
        appBar: customAppBar(),
        body: isLoading
            ? const CircularProgressIndicator()
            : ListView(
                children: myTodos.map((e) {
                  return TodoContainer(
                      id: e.id, title: e.title, desc: e.desc, isDone: e.isDone);
                }).toList(),
              ));
  }
}
