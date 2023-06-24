import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/task.dart';
import 'package:untitled/pages/task_page/taskpage.dart';
import 'package:untitled/provider/provider.dart';

class TaskTile extends StatefulWidget {
  final Task _task;
  final int id;

  const TaskTile({Key? key, required this.id, required Task task})
      : _task = task,
        super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool _isChecked = false;

  String convertDateTime(DateTime dt) {
    List<String> months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];
    return "${dt.day} ${months[dt.month - 1]} ${dt.year}";
  }

  @override
  Widget build(BuildContext context) {
    Data provider = Provider.of<Data>(context);
    _isChecked = widget._task.completed;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Dismissible(
        key: UniqueKey(),
        confirmDismiss: (DismissDirection direction) {
          if (direction == DismissDirection.startToEnd) {
            _isChecked = !_isChecked;
            provider.changeActive(widget.id, _isChecked);
            return Future.value(false);
          } else {
            provider.deleteTask(widget.id);
          }
          return Future(() => null);
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget._task.priority == '!! Высокий')
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5, right: 10),
                    child: SizedBox(
                        width: 18,
                        height: 18,
                        child: Material(
                            color: const Color.fromRGBO(254, 216, 214, 1),
                            child: Checkbox(
                              value: _isChecked,
                              checkColor: Colors.white,
                              activeColor: Colors.green,
                              side: MaterialStateBorderSide.resolveWith(
                                  (states) => (!_isChecked)
                                      ? const BorderSide(
                                          width: 2.2,
                                          color: Color.fromRGBO(252, 33, 37, 1))
                                      : const BorderSide(
                                          width: 2.2,
                                          color: Color.fromRGBO(0, 0, 0, 0))),
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                                if (_isChecked) {
                                  provider.changeActive(widget.id, true);
                                } else {
                                  provider.changeActive(widget.id, false);
                                }
                              },
                            ))))
                : Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5, right: 10),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: Checkbox(
                        value: _isChecked,
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => (!_isChecked)
                              ? BorderSide(
                                  width: 2.2,
                                  color: (Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .color)!)
                              : const BorderSide(
                                  width: 2.2,
                                  color: Color.fromRGBO(0, 0, 0, 0)),
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                          if (_isChecked) {
                            provider.changeActive(widget.id, true);
                          } else {
                            provider.changeActive(widget.id, false);
                          }
                        },
                      ),
                    ),
                  ),
            (widget._task.priority == '!! Высокий')
                ? const Padding(
                    padding: EdgeInsets.only(top: 5, right: 2),
                    child: Text(
                      '!!',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ))
                : const SizedBox.shrink(),
            (widget._task.priority == 'Низкий')
                ? const Padding(
                    padding: EdgeInsets.only(top: 5, right: 2),
                    child: Icon(Icons.arrow_downward, size: 20))
                : const SizedBox.shrink(),
            (widget._task.date == null)
                ? Expanded(
                    flex: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        widget._task.title,
                        style: TextStyle(
                          color: (_isChecked)
                              ? Theme.of(context).textTheme.bodySmall!.color
                              : Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 16,
                          height: 20 / 16,
                          decoration: (_isChecked)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  )
                : Expanded(
                    flex: 50,
                    child: ListTile(
                      dense: true,
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        widget._task.title,
                        style: TextStyle(
                          color: (_isChecked)
                              ? Theme.of(context).textTheme.bodySmall!.color
                              : Theme.of(context).textTheme.bodyMedium!.color,
                          fontSize: 16,
                          height: 20 / 16,
                          decoration: (_isChecked)
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      subtitle: Text(
                        convertDateTime(widget._task.date!),
                        style: TextStyle(
                            color: (!_isChecked)
                                ? const Color(0x99000000)
                                : Theme.of(context).textTheme.bodySmall!.color,
                            fontSize: 14,
                            height: 20 / 14),
                      ),
                    ),
                  ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: IconButton(
                padding: const EdgeInsets.only(right: 15, left: 10),
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskPage(
                                task: widget._task,
                              )));
                },
                icon: Icon(
                  Icons.info_outline,
                  size: 25,
                  color: Theme.of(context).textTheme.bodySmall!.color,
                ),
              ),
            ),
          ],
        ),
        // child: ListTile(
        //   leading: Theme(
        //     data: Theme.of(context).copyWith(
        //       unselectedWidgetColor: const Color(0x4D000000),
        //     ),
        //     child: Checkbox(
        //       activeColor: Colors.green,
        //       value: _isChecked,
        //       onChanged: (bool? value) {
        //         if (_isChecked) {
        //           provider.changeActive(widget.id, true);
        //         } else {
        //           provider.changeActive(widget.id, false);
        //         }
        //       },
        //     ),
        //   ),
        //   title: Baseline(
        //     baseline: 20,
        //     baselineType: TextBaseline.alphabetic,
        //     child: RichText(
        //       overflow: TextOverflow.ellipsis,
        //       maxLines: 3,
        //       text: TextSpan(
        //         children: [
        //           WidgetSpan(
        //             child: widget._task.priority == 'Высокий'
        //                 ? const Text(
        //                     '!!',
        //                     style: TextStyle(
        //                       color: Colors.red,
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: 20,
        //                     ),
        //                   )
        //                 : widget._task.priority == 'Низкий'
        //                     ? const Icon(Icons.arrow_downward, size: 20)
        //                     : const Text(''),
        //           ),
        //           TextSpan(
        //             text: widget._task.title,
        //             style: TextStyle(
        //               fontSize: 16,
        //               height: 20 / 16,
        //               color: Colors.black,
        //               decoration: (_isChecked)
        //                   ? TextDecoration.lineThrough
        //                   : TextDecoration.none,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   subtitle: Text(
        //     convertDateTime(widget._task.date!),
        //     style: Theme.of(context).textTheme.titleMedium,
        //   ),
        //   trailing: InkWell(
        //     onTap: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => TaskPage(
        //                     task: widget._task,
        //                   )));
        //     },
        //     child: Icon(
        //       Icons.info_outlined,
        //       color: Theme.of(context).secondaryHeaderColor,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}







// class ToDoTileList extends StatefulWidget {
//   const ToDoTileList({super.key});

//   @override
//   State<ToDoTileList> createState() => _ToDoTileListState();
// }

// class _ToDoTileListState extends State<ToDoTileList> {
//   @override
//   Widget build(BuildContext context) {
//     Data provider = Provider.of<Data>(context);
//     List toDoList = provider.showAll ? provider.toDoList : provider.unDoneList;

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: toDoList.length,
//       itemBuilder: (context, index) {
//         return ClipRect(
//           child: Dismissible(
//             key: ValueKey(toDoList[index]),
//             confirmDismiss: (direction) {
//               if (direction == DismissDirection.startToEnd) {
//                 provider.makeTaskCompleted(index, true);
//                 toDoList[index][1] = true;
//                 provider.getDoneList();

//                 return Future.value(false);
//               } else {
//                 return Future.value(true);
//               }
//             },
//             onDismissed: (direction) {
//               if (direction == DismissDirection.endToStart) {
//                 if (provider.showAll) {
//                   provider.deleteTask(index);
//                 } else {
//                   provider.deleteTask(index);
//                   provider.deleteUnDoneTask(index);
//                 }
//               }
//               provider.getDoneList();
//             },
//             background: Container(
//               color: const Color(0xff34C759),
//               child: const Icon(
//                 Icons.check,
//                 color: Colors.white,
//               ),
//             ),
//             secondaryBackground: Container(
//               color: const Color(0xffff3b30),
//               child: const Icon(
//                 Icons.delete,
//                 color: Colors.white,
//               ),
//             ),
//             child: ToDoTile(
//               index: index,
//               toDoList: toDoList,
//               provider: provider,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }