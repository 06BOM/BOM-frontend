import 'package:flutter/material.dart';

class BomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;

  const BomAppBar({Key? key, this.title})
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
    print('${widget.title ?? ' '} in BomAppBar');
    return AppBar(
      title: widget.title != null ? Text(widget.title!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)) : Text(''),
      centerTitle: widget.title != null ? true : false,
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
