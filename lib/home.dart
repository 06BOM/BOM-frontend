import 'package:bom_front/view/collection_view.dart';
import 'package:bom_front/view/community.dart';
import 'package:bom_front/view/components/bom_menu.dart';
import 'package:bom_front/view/components/bottom_navigation.dart';
import 'package:bom_front/view/components/plan/appbar.dart';
import 'package:bom_front/view/game_view.dart';
import 'package:bom_front/view/hom_view.dart';
import 'package:bom_front/view/home_detail_view.dart';
import 'package:bom_front/view/store_view.dart';
import 'package:bom_front/view/user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationBarIndex = StateProvider<int>((ref) => 2);

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonIndex = ref.watch(bottomNavigationBarIndex);
    print('buttonIndex: $buttonIndex in home');
    switch (buttonIndex) {
      case 0:
        return CommunityScreen();
        break;
      case 1:
        return GameScreen();
        break;
      case 2:
        return HomeScreen();
        break;
      case 3:
        return CollectionScreen();
        break;
      case 4:
        return UserScreen();
        break;
      default:
        return Center(
          child: Column(children: [Text('해당 화면이 나오면 문의 주세요')]),
        );
    }
  }
}
