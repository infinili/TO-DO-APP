import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/task.dart';
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
  bool _isCollapsed = true;
  bool _isHide = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Data provider = Provider.of<Data>(context);
    return FutureBuilder(
      future: provider.init(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notif) {
              setState(() {
                _isCollapsed = _scrollController.offset <= 110;
              });
              return false;
            },
            child: Scaffold(
              body: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: false,
                    snap: false,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    expandedHeight: 190,
                    collapsedHeight: 80,
                    flexibleSpace: FlexibleSpaceBar(
                      title: (_isCollapsed)
                          ? ListTile(
                              title: Text('Мои дела',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              subtitle: Text(
                                  "Выполнено ${provider.completedCnt}",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              trailing: Padding(
                                padding: const EdgeInsets.only(top: 36),
                                child: SizedBox(
                                    width: 21,
                                    height: 21,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        _isHide = !_isHide;
                                        provider.reShow(_isHide);
                                      },
                                      icon: Icon(
                                        (!_isHide)
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: const Color(0xFF007AFF),
                                        size: 20,
                                      ),
                                    )),
                              ),
                            )
                          : Row(
                              children: [
                                Text('Мои дела',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 14),
                                  child: IconButton(
                                    onPressed: () {
                                      _isHide = !_isHide;
                                      provider.reShow(_isHide);
                                    },
                                    icon: Icon(
                                      (!_isHide)
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).iconTheme.color,
                                      size: 21,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      titlePadding: (_isCollapsed)
                          ? const EdgeInsets.only(left: 45, bottom: 18)
                          : const EdgeInsets.only(left: 20, bottom: 18),
                    ),
                  ),
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
    Data provider = Provider.of<Data>(context);
    return Column(
      children:
          generateList(provider.getTasks, provider.getCount, 'Новое', context),
    );
  }
}

List<Widget> generateList(
    List<Task> data, int count, String neww, BuildContext context) {
  Data provider = Provider.of<Data>(context);
  List<Widget> retval = [];
  if (provider.showAll) {
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































// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
  

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final _scrollController = ScrollController();
//   bool _isCollapsed = true;
//   bool _showAll = false;

//   @override
//   Widget build(BuildContext context) {
//     Data provider = Provider.of<Data>(context);
//     return FutureBuilder(
//       future: provider.init()
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return NotificationListener<ScrollNotification>(
//             onNotification: (notif) {
//               setState(() {
//                 _isCollapsed = _scrollController.offset <= 110;
//               });
//               return false;
//             },
//             child: Scaffold(
//               backgroundColor: const Color(0xfff7f6f2),
//               body: CustomScrollView(
//                 controller: _scrollController,
//                 slivers: [
//                   SliverPersistentHeader(
//                     pinned: true,
//                     delegate: HomeAppBarDelegate(
//                       openedHeight: 164,
//                       closedHeight: 84,
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Theme.of(context).cardColor,
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: Colors.grey,
//                                 offset: Offset(0.0, 1.0),
//                                 blurRadius: 6.0,
//                               )
//                             ]),
//                         child: SliverList(
//                           delegate: SliverChildBuilderDelegate(
//                             (context, int index) {
//                               return Column(
//                                 children: [
//                                   Padding(
//                                       padding:
//                                           const EdgeInsets.symmetric(horizontal: 10.0),
//                                       child: Material(
//                                           elevation: 2.0,
//                                           color: Theme.of(context).cardColor,
//                                           shape: const RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(8.0))),
//                                           child: const MainList())),
//                                   const SizedBox(
//                                     height: 80,
//                                   )
//                                 ],
//                               );
//                             },
//                             childCount: 1,
//                           ),
//                         ),
//                         // child: Column(
//                         //   mainAxisAlignment: MainAxisAlignment.center,
//                         //   mainAxisSize: MainAxisSize.min,
//                         //   children: [
//                         //     const ToDoTileList(),
//                         //     Padding(
//                         //       padding: const EdgeInsets.symmetric(vertical: 20),
//                         //       child: InkWell(
//                         //         onTap: () => Navigator.of(context)
//                         //             .push(MaterialPageRoute(builder: (context) {
//                         //           return const TaskPage();
//                         //         })),
//                         //         child: InkWell(
//                         //           onTap: () {
//                         //             Navigator.of(context)
//                         //                 .push(MaterialPageRoute(builder: (context) {
//                         //               return const TaskPage();
//                         //             }));
//                         //           },
//                         //           child: Container(
//                         //             child: const Align(
//                         //               alignment: Alignment(-0.5, 0.0),
//                         //               child: Text(
//                         //                 'Новое',
//                         //                 style: TextStyle(
//                         //                   fontSize: 20,
//                         //                   height: 20 / 16,
//                         //                   color: Color(0x4D000000),
//                         //                 ),
//                         //               ),
//                         //             ),
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ),
//                         //   ],
//                         // ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               floatingActionButton: FloatingActionButton(
//                 child: const Icon(Icons.add),
//                 onPressed: () {
//                   MyLogger.instance.mes('Edit page for the new task is opened');
//                   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                     return const MainList();
//                   }));
//                 },
//               ),
//             ),
//           );
//         }
//       }
//     );
//   }
// }

// class MainList extends StatefulWidget {
//   const MainList({Key? key}) : super(key: key);

//   @override
//   State<MainList> createState() => _MainListState();
// }

// class _MainListState extends State<MainList> {
//   @override
//   Widget build(BuildContext context) {
//     Data provider = Provider.of<Data>(context);
//     return Column(
//       children:
//           generateList(provider.getTasks, provider.getCount, 'Новое', context),
//     );
//   }
// }

// List<Widget> generateList(
//     List<Task> data, int count, String neww, BuildContext context) {
//   List<Widget> retval = [];
//   Data provider = Provider.of<Data>(context);
//   if (provider.showAll) {
//     for (int i = 0; i < count; i++) {
//       // context
//       //     .watch<Controller>()
//       //     .logger
//       //     .i(("${data[i].id} ${data[i].completed}"));
//       if (!data[i].completed) {
//         // context
//         //     .watch<Controller>()
//         //     .logger
//         //     .i("${data[i].id} ${data[i].completed}");
//         retval.add(TaskTile(id: data[i].id, task: data[i]));
//       }
//     }
//   } else {
//     for (int i = 0; i < count; i++) {
//       // context
//       //     .watch<Controller>()
//       //     .logger
//       //     .i("${data[i].id} ${data[i].completed}");
//       retval.add(TaskTile(id: data[i].id, task: data[i]));
//     }
//   }
//   retval.add(
//     SizedBox(
//       width: double.infinity,
//       child: TextButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const TaskPage(
//                         task: null,
//                       )));
//         },
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
//             child: Text(
//               neww,
//               style: Theme.of(context).textTheme.displayMedium,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );

//   return retval;
// }
