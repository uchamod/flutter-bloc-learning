import 'package:cubit_todo_app/cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoAddPage extends StatefulWidget {
  const TodoAddPage({super.key});

  @override
  State<TodoAddPage> createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              //title
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: "title"),
              ),
              SizedBox(height: 8),
              //discription
              TextField(
                controller: _discriptionController,
                decoration: InputDecoration(hintText: "discription"),
              ),
              SizedBox(height: 16),
              //add new
              ElevatedButton(
                onPressed: () {
                  //this is same as usinf bloc provider read the todocubit class and get the method and execute
                  context.read<TodoCubit>().addTodo(
                    _titleController.text,
                    _discriptionController.text,
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  "add new item",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
