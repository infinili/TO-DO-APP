import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/task.dart';
import 'package:untitled/logger/logger.dart';
import 'package:untitled/provider/provider.dart';

class TaskPage extends StatefulWidget {
  final Task? _task;

  const TaskPage({Key? key, required Task? task})
      : _task = task,
        super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController inputController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  bool _isSwitched = false;
  bool _emptyText = false;
  bool _isButtonDisabled = true;
  DateTime? _selectedDate;
  String _toDate = "";
  String _priority = "";

  @override
  void initState() {
    if (widget._task != null) {
      setState(() {
        _isButtonDisabled = false;
      });
    }
    inputController = TextEditingController(text: widget._task?.title ?? "");
    priorityController =
        TextEditingController(text: widget._task?.priority ?? "");
    _priority = widget._task?.priority ?? "";
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    priorityController.dispose();
    super.dispose();
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final tmp = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));
    setState(() {
      _selectedDate = tmp;
      if (tmp != null) {
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
        _toDate = "${tmp.day} ${months[tmp.month - 1]} ${tmp.year}";
      } else {
        _isSwitched = false;
      }
    });
    return _selectedDate;
  }

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

  void _setDate(DateTime? date) {
    if (date != null) {
      setState(() {
        _isSwitched = true;
        _toDate = convertDateTime(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Data provider = Provider.of<Data>(context);
    double widthScreen = MediaQuery.of(context).size.width;

    if (priorityController.text == "") {
      priorityController.text = 'Нет';
    }
    _setDate(widget._task?.date);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xfff7f6f2),
            pinned: true,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    MyLogger.instance.mes('Editing page is closed');
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _emptyText = inputController.text == "";
                    });
                    if (!_emptyText) {
                      if (widget._task == null) {
                        provider.addTask(inputController.text, false, _priority,
                            _selectedDate);
                        Navigator.pop(context);
                      } else {
                        provider.changeTask(widget._task!, inputController.text,
                            _priority, _selectedDate);
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text(
                    'СОХРАНИТЬ',
                    style: TextStyle(
                      fontSize: 14,
                      height: 24 / 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 23),
                      child: Card(
                        margin: EdgeInsets.zero,
                        semanticContainer: false,
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              minHeight: 104, maxHeight: 1000),
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(16),
                              hintText: 'Что надо сделать...',
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                            controller: inputController,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16, left: 16, top: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownMenu<String>(
                          controller: priorityController,
                          label: const Text('Важность'),
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          initialSelection: _priority,
                          trailingIcon: const Icon(
                            Icons.add,
                            size: 0,
                          ),
                          dropdownMenuEntries: [
                            const DropdownMenuEntry(value: 'Нет', label: 'Нет'),
                            const DropdownMenuEntry(
                                value: 'Низкий', label: 'Низкий'),
                            DropdownMenuEntry(
                                value: '!! Высокий',
                                label: '!! Высокий',
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.red)),
                          ],
                          inputDecorationTheme: InputDecorationTheme(
                            filled: false,
                            outlineBorder: BorderSide.none,
                            border: InputBorder.none,
                            constraints: const BoxConstraints(maxHeight: 30),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 21.5),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0.0),
                          ),
                          onSelected: (String? text) {
                            setState(() {
                              _priority = text!;
                            });
                          },
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 10,
                      ),
                      child: Divider(
                        height: 0.5,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8),
                      child: SizedBox(
                        height: 60,
                        child: (_isSwitched)
                            ? ListTile(
                                minLeadingWidth: widthScreen,
                                contentPadding: EdgeInsets.zero,
                                subtitle: Text(
                                  _toDate,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                title: Text(
                                  'Сделать до',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                trailing: Switch(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: _isSwitched,
                                  activeColor: const Color(0xFF007AFF),
                                  inactiveThumbColor:
                                      Theme.of(context).disabledColor,
                                  onChanged: (value) {
                                    setState(() {
                                      _isSwitched = !_isSwitched;
                                      if (_isSwitched) {
                                        pickDate(context);
                                      } else {
                                        _toDate = "";
                                      }
                                    });
                                  },
                                ),
                              )
                            : Row(
                                children: [
                                  Text('Сделать до',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  const Spacer(),
                                  Switch(
                                    value: _isSwitched,
                                    onChanged: (val) {
                                      setState(() {
                                        _isSwitched = !_isSwitched;
                                        if (_isSwitched) {
                                          pickDate(context);
                                        } else {
                                          _toDate = "";
                                        }
                                      });
                                    },
                                    activeColor: const Color(0xFF007AFF),
                                    inactiveThumbColor:
                                        Theme.of(context).cardColor,
                                  )
                                ],
                              ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 0,
                      ),
                      child: Divider(
                        height: 0.5,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, top: 20),
                      child: TextButton(
                        onPressed: () {
                          if (_isButtonDisabled) return;
                          provider.deleteTask(widget._task!.id);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 0, right: 10),
                              child: Icon(
                                Icons.delete,
                                color: (_isButtonDisabled)
                                    ? Theme.of(context).disabledColor
                                    : const Color(0xFFFF3B30),
                              ),
                            ),
                            Text(
                              'Удалить',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: (_isButtonDisabled)
                                          ? Theme.of(context).disabledColor
                                          : const Color(0xFFFF3B30)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}






// class TaskPage extends StatefulWidget {
//   final int index;
//   final bool touched;
//   final bool? showAll;
//   final String? title;
//   final String? titleFromUnDone;

//   const TaskPage({
//     super.key,
//     this.touched = false,
//     this.showAll,
//     this.title,
//     this.titleFromUnDone,
//     this.index = 0,
//   });

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   TextEditingController myController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     {
//       String? text = '';
//       if (widget.showAll == true) {
//         text = widget.title;
//       } else {
//         text = widget.titleFromUnDone;
//       }
//       myController = TextEditingController(text: text);
//     }
//   }

//   @override
//   void dispose() {
//     myController.dispose();
//     super.dispose();
//   }

//   void renew(Data provider) {
//     provider.setPriority(0);
//     provider.getDoneList();
//     provider.getUnDoneList();
//     provider.touch(false);
//   }

//   Future<void> selectTaskDate(BuildContext context, Data provider) async {
//     await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2025),
//       locale: const Locale('ru'),
//     ).then((value) {
//       provider.changeDate(value);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Data provider = Provider.of<Data>(context);
//     double widthScreen = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: const Color(0xfff7f6f2),
//             pinned: true,
//             leading: Builder(
//               builder: (BuildContext context) {
//                 return IconButton(
//                   color: Colors.black,
//                   icon: const Icon(Icons.close),
//                   onPressed: () {
//                     MyLogger.instance.mes('Editing page is closed');
//                     Navigator.of(context).pop();
//                   },
//                 );
//               },
//             ),
//             actions: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(right: 15),
//                 child: TextButton(
//                   onPressed: () {
//                     if (provider.taskTouched) {
//                       provider.remake(
//                           widget.index,
//                           myController.text,
//                           false,
//                           provider.priority,
//                           provider.switcher ? '${provider.selectedDay}' : '');
//                     } else {
//                       provider.createNewTask(
//                           myController.text,
//                           false,
//                           provider.priority,
//                           provider.switcher ? '${provider.selectedDay}' : '');
//                     }
//                     renew(provider);
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text(
//                     'СОХРАНИТЬ',
//                     style: TextStyle(
//                       fontSize: 14,
//                       height: 24 / 14,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(left: 16.0, right: 16, top: 23),
//                       child: Card(
//                         margin: EdgeInsets.zero,
//                         semanticContainer: false,
//                         elevation: 2,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: ConstrainedBox(
//                           constraints: const BoxConstraints(
//                               minHeight: 104, maxHeight: 1000),
//                           child: TextField(
//                             textInputAction: TextInputAction.done,
//                             textCapitalization: TextCapitalization.words,
//                             decoration: const InputDecoration(
//                               contentPadding: EdgeInsets.all(16),
//                               hintText: 'Что надо сделать...',
//                               border: InputBorder.none,
//                             ),
//                             maxLines: null,
//                             controller: myController,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(right: 16, left: 16, top: 16),
//                       child: SizedBox(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Важность',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 height: 20 / 16,
//                               ),
//                             ),
//                             DropdownButton<int>(
//                               iconSize: 0,
//                               elevation: 8,
//                               underline: const Divider(
//                                 color: Colors.transparent,
//                               ),
//                               alignment: Alignment.centerLeft,
//                               value: provider.priority,
//                               items: const [
//                                 DropdownMenuItem(
//                                   value: 0,
//                                   child: Text(
//                                     'Нет',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       height: 20 / 16,
//                                     ),
//                                   ),
//                                 ),
//                                 DropdownMenuItem(
//                                   value: 1,
//                                   child: Text(
//                                     'Низкий',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       height: 20 / 16,
//                                     ),
//                                   ),
//                                 ),
//                                 DropdownMenuItem(
//                                   value: 2,
//                                   child: Text(
//                                     '!!Высокий',
//                                     style: TextStyle(
//                                       color: Colors.red,
//                                       fontSize: 16,
//                                       height: 20 / 16,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                               onChanged: (value) => provider.setPriority(value),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 16.0, right: 8),
//                       child: ListTile(
//                         minLeadingWidth: widthScreen,
//                         contentPadding: EdgeInsets.zero,
//                         subtitle: provider.switcher
//                             ? Text(
//                                 provider.selectedDay!,
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               )
//                             : const Text(''),
//                         title: Text(
//                           'Сделать до',
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                         trailing: Switch(
//                           materialTapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                           value: provider.switcher,
//                           onChanged: (value) async {
//                             provider.changeButton(value);
//                             if (provider.switcher) {
//                               await selectTaskDate(context, provider);
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(
//                         left: 16,
//                         right: 16,
//                         top: 0,
//                       ),
//                       child: Divider(
//                         height: 0.5,
//                         thickness: 1,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 16, top: 20),
//                       child: Row(
//                         children: [
//                           AbsorbPointer(
//                             absorbing: !provider.taskTouched ? true : false,
//                             child: InkWell(
//                               onTap: () => provider.deleteTask(widget.index),
//                               child: Icon(
//                                 Icons.delete,
//                                 color: provider.taskTouched
//                                     ? Colors.red
//                                     : const Color(0x4D000000),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           AbsorbPointer(
//                             absorbing: !provider.taskTouched ? true : false,
//                             child: InkWell(
//                               onTap: () {
//                                 provider.deleteTask(widget.index);
//                                 renew(provider);
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text(
//                                 'Удалить',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   height: 20 / 16,
//                                   color: provider.taskTouched
//                                       ? Colors.red
//                                       : const Color(0x4D000000),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//               childCount: 1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
