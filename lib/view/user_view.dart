import 'package:flutter/material.dart';
import 'components/bom_menu.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/appbar.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BomAppBar(),
      drawer: BomMenu(),
      body: Center(child: Text('내정보')),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
