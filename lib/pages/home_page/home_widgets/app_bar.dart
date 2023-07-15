import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/generated/l10n.dart';
import 'package:untitled/pages/home_page/home_provider.dart';
import 'package:untitled/provider/provider.dart';

class Appbar extends StatefulWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      expandedHeight: 190,
      collapsedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        title: (context.watch<HomeProv>().isCollapsed)
            ? ListTile(
                title: Text(S.of(context).title,
                    style: Theme.of(context).textTheme.headlineSmall),
                subtitle: Text(
                    "${S.of(context).done}${context.watch<Prov>().completedCnt}",
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
                          setState(() {
                            _showAll = !_showAll;
                          });
                          context.read<HomeProv>().reShow = _showAll;
                        },
                        icon: Icon(
                          (!_showAll) ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).iconTheme.color,
                          size: 20,
                        ),
                      )),
                ),
              )
            : Row(
                children: [
                  Text(S.of(context).title,
                      style: Theme.of(context).textTheme.titleLarge),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _showAll = !_showAll;
                        });
                        context.read<HomeProv>().reShow = _showAll;
                      },
                      icon: Icon(
                        (!_showAll) ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).iconTheme.color,
                        size: 21,
                      ),
                    ),
                  ),
                ],
              ),
        titlePadding: (context.watch<HomeProv>().isCollapsed)
            ? const EdgeInsets.only(left: 45, bottom: 18)
            : const EdgeInsets.only(left: 20, bottom: 18),
      ),
    );
  }
}
