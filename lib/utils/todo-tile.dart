import 'package:flutter/material.dart';
import 'package:untitled/utils/data.dart';
import 'package:untitled/pages/taskpage.dart';

class ToDoTile extends StatelessWidget {
  final int index;
  final List toDoList;
  final Data provider;

  const ToDoTile({
    super.key,
    required this.index,
    required this.toDoList,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: const Color(0x4D000000),
        ),
        child: Checkbox(
          activeColor: const Color(0xff34C759),
          value: toDoList[index][1],
          onChanged: (bool? value) {
            provider.makeTaskCompleted(index, value);
            toDoList[index][1] = value;
            provider.getDoneList();
          },
        ),
      ),
      title: Baseline(
        baseline: 20,
        baselineType: TextBaseline.alphabetic,
        child: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          text: TextSpan(
            children: [
              WidgetSpan(
                child: toDoList[index][2] == 2
                    ? const Text(
                        '!!',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    : toDoList[index][2] == 1
                        ? Icon(Icons.arrow_downward, size: 20)
                        : const Text(''),
              ),
              TextSpan(
                text: " ${toDoList[index][0]}",
                style: TextStyle(
                  fontSize: 16,
                  height: 20 / 16,
                  color: Colors.black,
                  decoration: toDoList[index][1]
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
      //subtitle: ,
      trailing: InkWell(
        onTap: () {
          provider.touch(true);
          provider.setPriority(provider.toDoList[index][2]);
          Navigate(context);
        },
        child: const Icon(
          Icons.info_outlined,
          color: Color(0x4D000000),
        ),
      ),
    );
  }

  void Navigate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final bool showAll = provider.showAll;
      final bool touched = provider.taskTouched;
      final String? title = provider.toDoList[index][0];
      final String? titleFromUnDone =
          !provider.showAll ? provider.UnDoneList[index][0] ?? '' : null;
      return TaskPage(
        index: index,
        showAll: showAll,
        title: title,
        titleFromUnDone: titleFromUnDone,
      );
    }));
  }
}
