import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f6f2),
      body: Column(
        children: [
          Row(),
          Container(height: 300),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              //height: 100,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Что надо сделать...',
                  contentPadding: EdgeInsets.only(bottom: 100),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 3.0)),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    height: 16 / 20,
                    color: Color(0x4D000000),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
