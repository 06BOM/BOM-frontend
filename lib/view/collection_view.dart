import 'dart:ui';

import 'package:bom_front/provider/user_privider.dart';
import 'package:bom_front/view/components/bom_menu.dart';
import 'package:bom_front/view/components/character/character_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/character.dart';
import '../provider/character_provider.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CollectionScreen extends ConsumerStatefulWidget {
  const CollectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends ConsumerState<CollectionScreen> {
  late TextEditingController _textController;
  late TargetPlatform os;
  late BannerAd _banner;

  Map<String, String> UNIT_ID = kReleaseMode
      ? {
          'ios': 'ca-app-pub-9699588533861084~6583378542',
          'android': 'ca-app-pub-9699588533861084~3365655435',
        }
      : {
          'ios': 'ca-app-pub-3940256099942544/2934735716',
          'android': 'ca-app-pub-3940256099942544/6300978111',
        };

  // List<Character> display_list = List.from(bomCharacters);

  // void updateList(String value) {
  //   setState(() {
  //     display_list = bomCharacters
  //         .where((el) =>
  //             el.characterName!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  void initState() {
    _textController = TextEditingController(text: 'initial text');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    os = Theme.of(context).platform;

    _banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: AdRequest(),
    )..load();
  }

  @override
  void dispose() {
    _textController.dispose();
    _banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(characterListProvider);
    final userCharacters = ref.watch(userCharacterProvider.notifier).state;
    print('userCharacters : ${userCharacters}');
    final widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const BomAppBar(
        title: '캐릭터 도감',
        screenName: 'collection',
      ),
      drawer: BomMenu(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 15, right: 15, left: 15),
            width: widthSize * 0.9,
            height: 45,
            child: TextField(
              // focusNode: _focus,
              keyboardType: TextInputType.text,
              onChanged: (text) {
                // updateList(text);
                ref.read(characterListProvider.notifier).searchCharacter(text);
              },
              decoration: InputDecoration(
                // filled: true,
                //   fillColor: Color(0x),
                hintText: '검색',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.grey.shade500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: AdWidget(
              ad: _banner,
            ),
          ),
          characters.when(
              data: (data) {
                return gridBody(data, context, userCharacters, ref);
              },
              error: (e, st) => Container(),
              loading: () => Container())
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}

Widget gridBody(List<Character> display_list, BuildContext context, List<int> userCharacters, WidgetRef ref) {
  return display_list.length == 0
      ? Center(
          child: Text(
          "결과가 없습니다.",
        ))
      : Expanded(
          // 없었을 때, verticalviewport error 해결
          child: GridView(
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            children: display_list
                .map(
                  (bomCharacter) => GestureDetector(
                    onTap: () {
                      print('clicked');
                      !userCharacters.contains(bomCharacter.characterId) ? myShowDialog(context, bomCharacter, ref)
                          : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CharacterDetails(character: bomCharacter)),
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.4,
                      ),
                      margin: EdgeInsets.only(top: 10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(width: 4, color: Colors.orange),
                        ),
                        // color: Colors.white,
                        elevation: 10,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Container(
                            // color: Colors.black.withOpacity(0),
                            //   // decoration: BoxDecoration(
                            //   //     borderRadius: BorderRadius.all(
                            //   //         Radius.circular(30.0))),
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: 8.0, horizontal: 10.0),
                            //   child: BackdropFilter(
                            //     filter: ImageFilter.blur(sigmaX: 1.1, sigmaY: 1.1),
                            //     child: Image.network(
                            //       '${bomCharacter.imageUrl}',
                            //       width: 60,
                            //       height: 60,
                            //       fit: BoxFit.fitHeight,
                            //     ),
                            //   ),
                            // ),
                            Container(
                              // decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.all(
                              //         Radius.circular(30.0))),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              child: Image.network(
                                '${bomCharacter.imageUrl}',
                                width: 60,
                                height: 60,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30.0),
                                        bottomRight: Radius.circular(30.0))),
                                child: !userCharacters.contains(bomCharacter.characterId) // 99일 경우, 유저가 가지고 있찌 않은 코드
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.star_rounded,
                                              color: Colors.yellowAccent[700],
                                              size: 15.0),
                                          Text('${bomCharacter.star}',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white))
                                        ],
                                      )
                                    : Text('${bomCharacter.characterName}',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
}

void myShowDialog(BuildContext context, Character bomCharacter, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // FlutterLogo(
              //   size: 150,
              // ),
              Text(
                "해당 캐릭터는 별 ${bomCharacter.star}를 소모합니다.\n 계속 진행하시겠습니까?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        final currentUserStar = ref.watch(userProvider.notifier).state.star;
                        final remainStars = currentUserStar! - bomCharacter.star!;
                        print('$remainStars : remainStars');
                        ref.read(userProvider.notifier).editUserStar(remainStars);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.teal[400],
                            duration: Duration(milliseconds: 1000),
                            behavior: SnackBarBehavior.floating,
                            content: Text('구매가 완료되었습니다!'),
                          ),
                        );
                        ref.refresh(userProvider.notifier).getUser(); // 바로 적용이 안되는 경우가 있어서 위치 변경
                        // 아래 캐릭터 refresh 이전에 "해당 user의 캐릭터 콜랙션에 해당하는 character id 캐릭터를 추가한다"api 추가하기
                        ref.refresh(characterListProvider.notifier).getAllCharacter();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CharacterDetails(character: bomCharacter)),
                        );
                      },
                      style: ElevatedButton.styleFrom(primary: Color(0xffA876DE)),
                      child: Text("계속", style:TextStyle(color: Colors.white))),
                  SizedBox(width: 10,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(primary: Color(0xffA876DE)),
                      child: Text("닫기", style:TextStyle(color: Colors.white)))
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}