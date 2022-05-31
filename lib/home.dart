import 'package:bom_front/view/components/bottom_navigation.dart';
import 'package:bom_front/view/components/plan/appbar.dart';
import 'package:bom_front/view/hom_view.dart';
import 'package:bom_front/view/home_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationBarIndex = StateProvider<int>((ref) => 2);

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonIndex = ref.watch(bottomNavigationBarIndex);
    print('buttonIndex: $buttonIndex in home');
    return Scaffold(
      appBar: const BomAppBar(),
      body: _navigationBody(buttonIndex :buttonIndex),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.expand_less),
        backgroundColor: const Color(0xffffffff),
        foregroundColor: Colors.grey,
        hoverColor: Colors.white,
        hoverElevation: 0.0,
        elevation: 0.0,
        mini: true,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeDetailScreen()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }

  Widget _navigationBody({required int buttonIndex}) {
    switch(buttonIndex){
      case 0:
        return Center(child: Text('커뮤니티'),);;
        break;
      case 1:
        return Center(child: Text('게임'),);
        break;
      case 2:
        return HomeScreen();
        break;
      case 3:
        return Center(child: Text('캐릭터'),);
        break;
      case 4:
        return Center(child: Text('내정보'),);
        break;
      default:
        return Center(child: Column(children: [Text('해당 화면이 나오면 문의 주세요')]),);
        break;
    }
  }
}