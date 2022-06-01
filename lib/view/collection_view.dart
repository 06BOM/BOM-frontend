import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionScreen extends ConsumerStatefulWidget {
  const CollectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends ConsumerState<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            // focusNode: _focus,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              // _streamSearch.add(text);
            },
            decoration: InputDecoration(
                hintText: '검색',
                border: InputBorder.none,
                icon: Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: Icon(Icons.search))),
          ),
        ],
      ),
    );
  }
}
