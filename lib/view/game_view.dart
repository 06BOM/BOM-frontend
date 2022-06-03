import 'package:bom_front/provider/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/bom_menu.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/appbar.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {

  @override
  Widget build(BuildContext context) {
    print(ref.watch(roomListProvider));
    print(ref.read(roomListProvider.notifier).searchTheRoom());
    return const Scaffold(
        appBar: BomAppBar(screenName: 'game',),
        drawer: BomMenu(),
        body: Center(child: Text('게임')),
        bottomNavigationBar: BottomNavigationBarWidget(),
        );
  }
}
