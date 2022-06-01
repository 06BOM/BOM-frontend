import 'package:bom_front/view/hom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home.dart';

class StoreScreen extends ConsumerStatefulWidget {
  const StoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _StoreScreenState();
}

class _StoreScreenState extends ConsumerState<StoreScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.home_outlined, color: Colors.grey[500]),
          onPressed: () {
            ref.read(bottomNavigationBarIndex.notifier).state = 2;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          iconSize: 30.0,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam_outlined, color: Colors.grey[500]),
            onPressed: () {
              print('광고시청');
            },
          ),
        ],
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: const Color(0xff525c6e),
          unselectedLabelColor: const Color(0xffacb3bf),
          padding: EdgeInsets.only(bottom: 13.0),
          indicatorColor: const Color(0xffA876DE),
          controller: _tabController,
          tabs: [
            Text(
              '상점',
            ),
            Text('내아이템'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Center(child: Store(context)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(child: UserItems(context)),
            ),
          ),
        ],
      ),
    );
  }
}

Widget Store(BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('반가워요 \u{1F44B}',
              style: TextStyle(
                  color: Colors.grey[500], fontWeight: FontWeight.w600)),
        ],
      ),
      SizedBox(height: 10.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('현석님',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600)),
          Icon(Icons.star_rounded, color: Colors.yellowAccent[700], size: 40.0),
          Text('10',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600))
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.4,
            ),
            margin: EdgeInsets.only(top: 20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xffA876DE),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Text('랜덤뽑기',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white))),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(
                        'images/present.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.star_rounded,
                                color: Colors.yellowAccent[700], size: 30.0),
                            Text('x5',
                                style: TextStyle(
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white))
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xffA876DE)))
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}

Widget UserItems(BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('반가워요 \u{1F44B}',
              style: TextStyle(
                  color: Colors.grey[500], fontWeight: FontWeight.w600)),
        ],
      ),
      SizedBox(height: 10.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('현석님',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600)),
          Icon(Icons.star_rounded, color: Colors.yellowAccent[700], size: 40.0),
          Text('10',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600))
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.4,
            ),
            margin: EdgeInsets.only(top: 20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xffA876DE),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Text('랜덤뽑기',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white))),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.asset(
                        'images/present.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.star_rounded,
                                color: Colors.yellowAccent[700], size: 30.0),
                            Text('x5',
                                style: TextStyle(
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white))
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xffA876DE)))
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    ],
  );
}