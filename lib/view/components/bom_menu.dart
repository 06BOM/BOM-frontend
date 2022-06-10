import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/user_privider.dart';
import '../store_view.dart';

class BomMenu extends StatelessWidget {
  const BomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final user = ref.watch(userProvider.notifier).state;
              print('$user in bom menu.............................');
              return UserAccountsDrawerHeader(
                  accountName: const Text('bom'),
                  accountEmail: const Text("bom@gmail.com"),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('images/pokemon.png'),
                  ),
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('images/character.png'),
                    ),
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
                  ));
            },
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
            onTap: () => {
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
