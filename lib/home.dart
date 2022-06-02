import 'package:bom_front/view/collection_view.dart';
import 'package:bom_front/view/community.dart';
import 'package:bom_front/view/game_view.dart';
import 'package:bom_front/view/hom_view.dart';
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
        return const CommunityScreen();
        break;
      case 1:
        return const GameScreen();
        break;
      case 2:
        return const HomeScreen();
        break;
      case 3:
        return const CollectionScreen();
        break;
      case 4:
        return const UserScreen();
        break;
      default:
        return Center(
          child: Column(children: const [Text('해당 화면이 나오면 문의 주세요')]),
        );
    }
  }
}
