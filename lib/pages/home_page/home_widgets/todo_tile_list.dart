import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app/di.dart';
import 'package:untitled/data/task.dart';
import 'package:untitled/generated/l10n.dart';
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
  final configRepository = Loc.configRepository;

  bool _isChecked = false;

  String convertDateTime(DateTime dt) {
    List<String> months = [
      S.of(context).jan,
      S.of(context).feb,
      S.of(context).mar,
      S.of(context).apr,
      S.of(context).may,
      S.of(context).jun,
      S.of(context).jul,
      S.of(context).aug,
      S.of(context).sep,
      S.of(context).oct,
      S.of(context).nov,
      S.of(context).dec,
    ];
    return "${dt.day} ${months[dt.month - 1]} ${dt.year}";
  }

  @override
  Widget build(BuildContext context) {
    _isChecked = widget._task.completed;

    final usePurpleColor = configRepository.usePurpleColor;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Dismissible(
        key: UniqueKey(),
        confirmDismiss: (DismissDirection direction) {
          if (direction == DismissDirection.startToEnd) {
            setState(() {
              _isChecked = !_isChecked;
            });
            context.read<Prov>().changeActive(widget.id, _isChecked);
            return Future.value(false);
          } else {
            context.read<Prov>().deleteTask(widget._task.id);
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
            (widget._task.priority == "important")
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5, right: 10),
                    child: SizedBox(
                        width: 18,
                        height: 18,
                        child: Material(
                            color: usePurpleColor
                                ? const Color(0xffdecbfc)
                                : const Color.fromRGBO(254, 216, 214, 1),
                            child: Checkbox(
                              value: _isChecked,
                              checkColor: Colors.white,
                              activeColor: Colors.green,
                              side: MaterialStateBorderSide.resolveWith(
                                  (states) => (!_isChecked)
                                      ? BorderSide(
                                          width: 2.2,
                                          color: usePurpleColor
                                              ? const Color(0xff793cd8)
                                              : const Color.fromRGBO(
                                                  252, 33, 37, 1))
                                      : const BorderSide(
                                          width: 2.2,
                                          color: Color.fromRGBO(0, 0, 0, 0))),
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                                if (_isChecked) {
                                  context
                                      .read<Prov>()
                                      .changeActive(widget.id, true);
                                } else {
                                  context
                                      .read<Prov>()
                                      .changeActive(widget.id, false);
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
                            context.read<Prov>().changeActive(widget.id, true);
                          } else {
                            context.read<Prov>().changeActive(widget.id, false);
                          }
                        },
                      ),
                    ),
                  ),
            (widget._task.priority == "important")
                ? Padding(
                    padding: const EdgeInsets.only(top: 5, right: 2),
                    child: Text(
                      '!!',
                      style: TextStyle(
                        color: usePurpleColor
                            ? const Color(0xff793cd8)
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ))
                : const SizedBox.shrink(),
            (widget._task.priority == "low")
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
                        style: Theme.of(context).textTheme.bodySmall,
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
      ),
    );
  }
}
