import 'package:flutter/material.dart';

class BomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<BomAppBar> createState() => _BomAppBarState();

  @override
  final Size preferredSize; // default is 56.0
}

class _BomAppBarState extends State<BomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(''),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      // // 좌측
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: Colors.grey),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          iconSize: 30.0,
        ),
      ),
      // 우측
      actions: [
        IconButton(
          icon: const Icon(Icons.verified, color: Colors.grey),
          onPressed: () {},
          iconSize: 30.0,
        )
      ],
    );
  }
}
