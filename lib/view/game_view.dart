import 'package:flutter/material.dart';

import 'components/bom_menu.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/appbar.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: BomAppBar(screenName: 'game',),
        drawer: BomMenu(),
        body: Center(child: Text('게임')),
        bottomNavigationBar: BottomNavigationBarWidget(),
        );
  }
}
