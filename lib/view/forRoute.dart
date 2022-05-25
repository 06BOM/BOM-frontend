import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'main_menu_screen.dart';

class ForRoute extends ConsumerStatefulWidget {
  static String routeName = '/for-main';
  const ForRoute({Key? key}) : super(key: key);

  @override
  ConsumerState<ForRoute> createState() => _ForRouteState();
}

class _ForRouteState extends ConsumerState<ForRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('게임 화면으로 이동'),
          onPressed: () => Navigator.pushNamed(context, MainMenuScreen.routeName),
        ),
      ),
    );
  }
}
