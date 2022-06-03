import 'package:flutter/material.dart';

class BomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? screenName;

  const BomAppBar({Key? key, this.title, this.screenName})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<BomAppBar> createState() => _BomAppBarState();

  @override
  final Size preferredSize; // default is 56.0
}

class _BomAppBarState extends State<BomAppBar> {
  Icon searchIcon = Icon(Icons.search, color: Colors.grey);
  Widget titleWidget = const Text('');

  @override
  Widget build(BuildContext context) {
    print('${widget.title ?? ' '} in BomAppBar');
    return AppBar(
      title: widget.title != null
          ? Text(widget.title!,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600))
          : titleWidget,
      centerTitle: widget.title != null ? true : false,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      // // 좌측
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.grey),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          iconSize: 30.0,
        ),
      ),
      // 우측
      actions: [
        if (widget.screenName == null) ...[
          IconButton(
            icon: const Icon(Icons.verified, color: Colors.grey),
            onPressed: () {},
            iconSize: 30.0,
          )
        ] else if (widget.screenName == 'collection') ...[
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.grey),
            onPressed: () {},
            iconSize: 30.0,
          )
        ] else if (widget.screenName == 'game') ...[
          IconButton(
            icon: searchIcon,
            onPressed: () {
              setState(() => {
                    if (this.searchIcon.icon == Icons.search)
                      {
                        this.searchIcon =
                            Icon(Icons.cancel, color: Colors.grey),
                        this.titleWidget = Container(
                          height: 45,
                          child: TextField(
                            // textAlign: TextAlign.start,
                            //   textAlignVertical: TextAlignVertical(y: 100.0),
                              keyboardType: TextInputType.text,
                              onChanged: (text) {
                                print(text);
                              },
                              textInputAction: TextInputAction.go,
                              decoration: InputDecoration(
                                hintText: "검색",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              )),
                        )
                      }
                    else
                      {
                        this.searchIcon =
                            Icon(Icons.search, color: Colors.grey),
                        this.titleWidget = Text('')
                      }
                  });
            },
            iconSize: 30.0,
          )
        ],
      ],
    );
  }
}
