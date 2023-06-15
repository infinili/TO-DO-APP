import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/utils/data.dart';
import 'package:untitled/utils/todo-tile.dart';

class ToDoTileList extends StatefulWidget {
  const ToDoTileList({super.key});

  @override
  State<ToDoTileList> createState() => _ToDoTileListState();
}

class _ToDoTileListState extends State<ToDoTileList> {
  @override
  Widget build(BuildContext context) {
    Data provider = Provider.of<Data>(context);
    List toDoList = provider.showAll ? provider.toDoList : provider.UnDoneList;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: toDoList.length,
      itemBuilder: (context, index) {
        return ClipRect(
          child: Dismissible(
            key: ValueKey(toDoList[index]),
            confirmDismiss: (direction) {
              if (direction == DismissDirection.startToEnd) {
                provider.makeTaskCompleted(index, true);
                toDoList[index][1] = true;
                provider.getDoneList();

                return Future.value(false);
              } else {
                return Future.value(true);
              }
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                if (provider.showAll) {
                  provider.deleteTask(index);
                } else {
                  provider.deleteTask(index);
                  provider.deleteUnDoneTask(index);
                }
              }
              provider.getDoneList();
            },
            background: Container(
              color: const Color(0xff34C759),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              color: const Color(0xffff3b30),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: ToDoTile(
              index: index,
              toDoList: toDoList,
              provider: provider,
            ),
          ),
        );
      },
    );
  }
}
