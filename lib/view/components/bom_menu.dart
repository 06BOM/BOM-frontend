import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/character_provider.dart';
import '../../provider/user_privider.dart';
import '../store_view.dart';

class BomMenu extends ConsumerStatefulWidget {
  const BomMenu({Key? key}) : super(key: key);

  @override
  ConsumerState<BomMenu> createState() => _BomMenuState();
}

class _BomMenuState extends ConsumerState<BomMenu> {
  late final user;
  @override
  void didChangeDependencies() async {
    user = ref
        .watch(userProvider.notifier)
        .state;
    // ref.watch(characterListProvider.notifier).getCharacterUrl();
    // ref.watch(userCharacterUrlProvider.notifier).state;
  }

  @override
  Widget build(BuildContext context) {
    // print('user character uri = > ${}');
    final charUri = ref.watch(userCharacterUrlProvider);
    print('$user in bom menu.............................');
    print('$charUri in bom menu.............................');
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('bom'),
            accountEmail: const Text("bom@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: charUri == '' ? Container() : Container( //  Invalid argument(s): No host specified in URI file:/// <- 처음 charUri가 어떤 값도 없기 때문에 발생
                height: 100.0,
                child: charUri.when(
                    data: ((data) => Image.network(data, fit: BoxFit.fitHeight)),
                    error: (e, stackTrace) => Text('Monthly Stars Load Error : $e'),
                    loading: () => Container()
                ),
              ),
              // backgroundImage: AssetImage('images/pokemon.png'),
            ),
            otherAccountsPictures: [
              Icon(Icons.star_rounded,
                  color: Colors.yellowAccent,
                  size: 15.0),
              Text('${user.star ?? 0}',
                  style: TextStyle(fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white))
            ],
            onDetailsPressed: () => {print('clicked')},
            decoration: const BoxDecoration(
              color: Color(0xffA876DE),
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications_none, color: Colors.grey[500]),
            title: const Text('알림'),
            onTap: () => {print('알림')},
          ),
          ListTile(
            leading: Icon(Icons.list, color: Colors.grey[500]),
            title: const Text('친구'),
            onTap: () => {print('친구')},
          ),
          ListTile(
            leading:
            Icon(Icons.emoji_events_outlined, color: Colors.grey[500]),
            title: const Text('랭킹'),
            onTap: () => {print('랭킹')},
          ),
          ListTile(
            leading:
            Icon(Icons.shopping_cart_outlined, color: Colors.grey[500]),
            title: const Text('상점'),
            onTap: () =>
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StoreScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined, color: Colors.grey[500]),
            title: const Text('로그아웃'),
            onTap: () => {print('로그아웃')},
          )
        ],
      ),
    );
  }
}
