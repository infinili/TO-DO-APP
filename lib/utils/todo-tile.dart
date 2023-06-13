import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? checkFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.checkFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Color(0xFFFF3B30),
            )
          ],
        ),
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: checkFunction,
              icon: Icons.check,
              backgroundColor: Color(0xff34C759),
            ),
          ],
        ),
        child: Container(
          height: 80,
          child: Row(
            children: [
              //checkbox
              Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: const Color(0x4D000000),
                ),
                child: Checkbox(
                  activeColor: Color(0xff34C759),
                  value: taskCompleted,
                  onChanged: onChanged,
                ),
              ),

              //task name
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 20,
                  height: 20 / 32,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
