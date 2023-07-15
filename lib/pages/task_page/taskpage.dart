import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/task.dart';
import 'package:untitled/generated/l10n.dart';
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
  bool _isUploadedDateTime = false;
  bool _isButtonDisabled = true;
  DateTime? _selectedDate;
  String _toDate = "";
  String _priority = "basic";

  @override
  void initState() {
    if (widget._task != null) {
      setState(() {
        _isButtonDisabled = false;
      });
    }
    inputController = TextEditingController(text: widget._task?.title ?? "");
    priorityController =
        TextEditingController(text: widget._task?.priority ?? "basic");
    _priority = widget._task?.priority ?? "basic";
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
        _toDate = "${tmp.day} ${months[tmp.month - 1]} ${tmp.year}";
      } else {
        _isSwitched = false;
      }
    });
    return _selectedDate;
  }

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

  void _setDate(DateTime? date) {
    if (date != null) {
      setState(() {
        _isSwitched = true;
        _toDate = convertDateTime(date);
        _selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;

    if (priorityController.text == "") {
      priorityController.text = S.of(context).none;
    }
    if (!_isUploadedDateTime) {
      _setDate(widget._task?.date);
      _isUploadedDateTime = true;
    }
    _setDate(widget._task?.date);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            pinned: true,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  color: Theme.of(context).secondaryHeaderColor,
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
                        context.read<Prov>().addTask(inputController.text,
                            false, _priority, _selectedDate);
                        Navigator.pop(context);
                      } else {
                        context.read<Prov>().changeTask(widget._task!,
                            inputController.text, _priority, _selectedDate);
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    S.of(context).save,
                    style: const TextStyle(
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
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(16),
                              hintText: S.of(context).what_need_to_do,
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
                          label: Text(S.of(context).priority),
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          initialSelection: _priority,
                          trailingIcon: const Icon(
                            Icons.add,
                            size: 0,
                          ),
                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                                value: "basic", label: S.of(context).none),
                            DropdownMenuEntry(
                                value: "low", label: S.of(context).low),
                            DropdownMenuEntry(
                                value: "important",
                                label: S.of(context).high,
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
                                  S.of(context).do_before,
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
                                  Text(S.of(context).do_before,
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
                      padding: const EdgeInsets.only(left: 5, top: 20),
                      child: TextButton(
                        onPressed: () {
                          if (_isButtonDisabled) return;
                          context.read<Prov>().deleteTask(widget._task!.id);
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
                              S.of(context).delete,
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
