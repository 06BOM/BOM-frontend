import 'package:flutter/material.dart';
import 'components/bom_menu.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/appbar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BomAppBar(),
      drawer: BomMenu(),
      body: Center(child: Text('커뮤니티')),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
