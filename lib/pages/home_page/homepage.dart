import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/task.dart';
import 'package:untitled/generated/l10n.dart';
import 'package:untitled/pages/home_page/home_provider.dart';
import 'package:untitled/pages/home_page/home_widgets/app_bar.dart';
import 'package:untitled/pages/task_page/taskpage.dart';
import 'package:untitled/pages/home_page/home_widgets/todo_tile_list.dart';
import 'package:untitled/provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  //bool _showAll = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<Prov>().init(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notif) {
              context
                  .read<HomeProv>()
                  .setIsCollapsed(_scrollController.offset <= 110);
              return false;
            },
            child: Scaffold(
              body: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  const Appbar(),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, int index) {
                        return Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Material(
                                    elevation: 2.0,
                                    color: Theme.of(context).cardColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    child: const MainList())),
                            const SizedBox(
                              height: 80,
                            )
                          ],
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TaskPage(task: null)));
                },
                backgroundColor: const Color(0xFF007AFF),
                child: const Icon(Icons.add),
              ),
            ),
          );
        } else if (!snapshot.hasError) {
          return const CircularProgressIndicator();
        } else {
          return Text(snapshot.error.toString());
        }
      },
    );
  }
}

class MainList extends StatefulWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: generateList(context.watch<Prov>().getTasks,
          context.watch<Prov>().getCount, S.of(context)!.neww, context),
    );
  }
}

List<Widget> generateList(
    List<Task> data, int count, String neww, BuildContext context) {
  List<Widget> retval = [];
  if (context.watch<HomeProv>().showAll) {
    for (int i = 0; i < count; i++) {
      if (!data[i].completed) {
        retval.add(TaskTile(id: data[i].id, task: data[i]));
      }
    }
  } else {
    for (int i = 0; i < count; i++) {
      retval.add(TaskTile(id: data[i].id, task: data[i]));
    }
  }
  retval.add(
    SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TaskPage(
                        task: null,
                      )));
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 53),
            child: Text(
              neww,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    ),
  );
  return retval;
}
