import 'package:flutter/material.dart';
import 'package:untitled/pages/taskpage.dart';
import 'package:untitled/utils/todo-tile-list.dart';
import 'package:provider/provider.dart';
import 'package:untitled/utils/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Data provider = Provider.of<Data>(context);

    return Scaffold(
      backgroundColor: const Color(0xfff7f6f2),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xfff7f6f2),
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                margin: const EdgeInsets.only(left: 0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Мои дела',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          height: 38 / 32,
                        )),
                    InkWell(
                      onTap: () {
                        provider.reShow();
                        if (!provider.showAll) {
                          provider.getUnDoneList();
                        }
                      },
                      child: provider.showAll
                          ? const Icon(Icons.visibility_off,
                              color: Color(0xff007aff))
                          : const Icon(Icons.visibility,
                              color: Color(0xff007aff)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffffffff),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ToDoTileList(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: InkWell(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const TaskPage();
                        })),
                        child: InkWell(
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const TaskPage();
                          })),
                          child: Container(
                            child: const Align(
                              alignment: Alignment(-0.5, 0.0),
                              child: Text(
                                'Новое',
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 20 / 16,
                                  color: Color(0x4D000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const TaskPage();
        })),
      ),
    );
  }
}
