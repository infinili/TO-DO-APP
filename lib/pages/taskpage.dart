import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/utils/data.dart';

class TaskPage extends StatefulWidget {
  final int index;
  final bool touched;
  final bool showAll;
  final String? title;
  final String? titleFromUnDone;

  const TaskPage({
    super.key,
    this.index = 0,
    this.touched = false,
    this.showAll = true,
    this.title,
    this.titleFromUnDone,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    {
      String? text = '';
      if (widget.showAll) {
        text = widget.title;
      } else {
        text = widget.titleFromUnDone;
      }
      myController = TextEditingController(text: text);
    }
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void renew(Data provider) {
    provider.setPriority(0);
    provider.getDoneList();
    provider.getUnDoneList();
    provider.touch(false);
  }

  @override
  Widget build(BuildContext context) {
    Data provider = Provider.of<Data>(context);

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
                    if (provider.taskTouched) {
                      provider.remake(widget.index, myController.text, false,
                          provider.priority);
                    } else {
                      provider.createNewTask(
                          myController.text, false, provider.priority);
                    }
                    renew(provider);
                    Navigator.of(context).pop();
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
                            controller: myController,
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
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Важность',
                              style: TextStyle(
                                fontSize: 16,
                                height: 20 / 16,
                              ),
                            ),
                            DropdownButton<int>(
                              iconSize: 0,
                              elevation: 8,
                              underline: const Divider(
                                color: Colors.transparent,
                              ),
                              alignment: Alignment.centerLeft,
                              value: provider.priority,
                              items: const [
                                DropdownMenuItem(
                                  value: 0,
                                  child: Text(
                                    'Нет',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 20 / 16,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    'Низкий',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 20 / 16,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text(
                                    '!!Высокий',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      height: 20 / 16,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) => provider.setPriority(value),
                            ),
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
                      padding: EdgeInsets.only(left: 16, top: 20),
                      child: Row(
                        children: [
                          AbsorbPointer(
                            absorbing: !provider.taskTouched ? true : false,
                            child: InkWell(
                              onTap: () => provider.deleteTask(widget.index),
                              child: Icon(
                                Icons.delete,
                                color: provider.taskTouched
                                    ? Colors.red
                                    : const Color(0x4D000000),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          AbsorbPointer(
                            absorbing: !provider.taskTouched ? true : false,
                            child: InkWell(
                              onTap: () {
                                provider.deleteTask(widget.index);
                                renew(provider);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Удалить',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 20 / 16,
                                  color: provider.taskTouched
                                      ? Colors.red
                                      : const Color(0x4D000000),
                                ),
                              ),
                            ),
                          ),
                        ],
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
