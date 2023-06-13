import 'package:flutter/material.dart';
import 'package:untitled/utils/todo-tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //list of to do tasks
  List toDoList = [
    ['Что-то сделать', true],
    ['Что-то сделать еще', false],
    ['Что-то сделать еще', false],
    ['Что-то сделать', true],
  ];

  //checkbox was checked
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog();
      },
    );
  }

  //delete a task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f6f2),
      body: CustomScrollView(
        slivers: [
          //sliver appbar
          SliverAppBar(
            backgroundColor: const Color(0xfff7f6f2),
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                margin: const EdgeInsets.only(left: 0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Мои дела',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          height: 32 / 38,
                        )),
                    Text('ttt', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
          ),

          //sliver items
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffffffff),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: toDoList.length,
                      itemBuilder: (context, index) {
                        return ToDoTile(
                          taskName: toDoList[index][0],
                          taskCompleted: toDoList[index][1],
                          onChanged: (value) => checkBoxChanged(value, index),
                          deleteFunction: (context) => deleteTask(index),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        child: const Align(
                          alignment: Alignment(-0.65, 0.0),
                          child: Text(
                            'Новое',
                            style: TextStyle(
                              fontSize: 20,
                              height: 16 / 20,
                              color: Color(0x4D000000),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      //FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
