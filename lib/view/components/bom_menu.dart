import 'package:flutter/material.dart';

import '../store_view.dart';

class BomMenu extends StatelessWidget {
  const BomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('bom'),
              accountEmail: Text("bom@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('images/pokemon.png'),
              ),
              otherAccountsPictures: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('images/character.png'),
                )
              ],
              onDetailsPressed: () => {print('clicked')},
              decoration: BoxDecoration(
                color: Color(0xffA876DE),
              )),
          ListTile(
            leading: Icon(Icons.notifications_none, color: Colors.grey[500]),
            title: Text('알림'),
            onTap: () => {print('알림')},
          ),
          ListTile(
            leading: Icon(Icons.list, color: Colors.grey[500]),
            title: Text('친구'),
            onTap: () => {print('친구')},
          ),
          ListTile(
            leading:
            Icon(Icons.emoji_events_outlined, color: Colors.grey[500]),
            title: Text('랭킹'),
            onTap: () => {print('랭킹')},
          ),
          ListTile(
            leading:
            Icon(Icons.shopping_cart_outlined, color: Colors.grey[500]),
            title: Text('상점'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StoreScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined, color: Colors.grey[500]),
            title: Text('로그아웃'),
            onTap: () => {print('로그아웃')},
          )
        ],
      ),
    );
  }
}
