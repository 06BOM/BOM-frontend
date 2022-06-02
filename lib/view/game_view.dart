import 'package:flutter/material.dart';

import 'components/bom_menu.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/appbar.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: BomAppBar(),
        drawer: BomMenu(),
        body: Center(child: Text('게임')),
        bottomNavigationBar: BottomNavigationBarWidget(),
        );
  }
}
