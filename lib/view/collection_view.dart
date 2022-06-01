import 'package:bom_front/view/components/bom_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/bottom_navigation.dart';
import 'components/plan/appbar.dart';

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
    return Scaffold(
      appBar: const BomAppBar(title: '캐릭터 도감'),
      drawer: BomMenu(),
      body: Center(
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
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
