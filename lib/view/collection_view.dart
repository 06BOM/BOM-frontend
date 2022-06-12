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
  late RewardedAd? _rewardedAd;
  late List<Character> displayList;

  Map<String, String> UNIT_ID = kReleaseMode
      ? {
    'ios': 'ca-app-pub-9699588533861084~6583378542',
    'android': 'ca-app-pub-9699588533861084~3365655435',
  }
      : {
    'ios': 'ca-app-pub-3940256099942544/2934735716',
    'android': 'ca-app-pub-3940256099942544/6300978111',
  };

  Map<String, String> UNIT_ID2 = kReleaseMode
      ? {
    'ios': 'ca-app-pub-9699588533861084~6583378542',
    'android': 'ca-app-pub-9699588533861084~3365655435',
  }
      : {
    'ios': 'ca-app-pub-3940256099942544/1712485313',
    'android': 'ca-app-pub-3940256099942544/5224354917',
  };

  void updateList(String value) {
    setState(() {
      displayList = ref.watch(characterListProvider)
          .where((el) =>
              el.characterName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      print('updateList -> $displayList');
    });
  }

  void loadRewardedAd() {
    RewardedAd.load(
        adUnitId: UNIT_ID2[os == TargetPlatform.iOS ? 'ios' : 'android']!,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (RewardedAd ad) {
              _rewardedAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
        })
    );
  }

  @override
  void initState() {
    _textController = TextEditingController(text: 'initial text');
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    os = Theme
        .of(context)
        .platform;

    _banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: AdRequest(),
    )
      ..load();
    displayList = ref.watch(characterListProvider.notifier).state;
    loadRewardedAd();
  }

  @override
  void dispose() {
    _textController.dispose();
    _banner.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userCharacters = ref
        .watch(userCharacterProvider.notifier)
        .state;
    print('userCharacters : ${userCharacters}');
    final widthSize = MediaQuery
        .of(context)
        .size
        .width;
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
                updateList(text);
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
            height: 60,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: AdWidget(
              ad: _banner,
            ),
          ),
          gridBody(context, userCharacters)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add',
        child: const Icon(Icons.ondemand_video),
        backgroundColor: const Color(0xffA876DE),
        onPressed: () {
          print('click');
          if (_rewardedAd != null) {
            _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (RewardedAd ad) {
                  print("Ad onAdShowedFullScreenContent");
                },
                onAdDismissedFullScreenContent: (RewardedAd ad) {
                  print('bye rewarded screen!');
                  ref.refresh(userProvider.notifier).getUser(); // _rewardedAd!.show( -> read이후 바로 적용시 가져오지 못하는 에러때문에 위치 변경
                  ad.dispose();
                  loadRewardedAd();
                },
                onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
                  ad.dispose();
                  loadRewardedAd();
                }
            );

            _rewardedAd!.setImmersiveMode(true);
            _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              print("${reward.amount} ${reward.type}");
              final int remainStars = ref.watch(userProvider.notifier).state.star! + 5;
              print('$remainStars : remainStars');
              ref.read(userProvider.notifier).editUserStar(remainStars);
            });
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }

  Widget gridBody(BuildContext context,
      List<int> userCharacters) {
    return displayList.length == 0
        ? Center(
        child: Text(
          "결과가 없습니다.",
        ))
        : Expanded(
      // 없었을 때, verticalviewport error 해결
      child: GridView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: displayList
            .map(
              (bomCharacter) =>
              GestureDetector(
                onTap: () {
                  print('clicked');
                  !userCharacters.contains(bomCharacter.characterId)
                      ? myShowDialog(context, bomCharacter)
                      : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CharacterDetails(character: bomCharacter)),
                  );
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4,
                    maxHeight: MediaQuery
                        .of(context)
                        .size
                        .width * 0.4,
                  ),
                  // margin: EdgeInsets.only(top: 10.0),
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
                        Container(
                          padding: EdgeInsets.only(top: 13.0, bottom: 4.0,),
                          child: !userCharacters.contains(bomCharacter
                              .characterId) ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                '${bomCharacter.imageUrl}',
                                height: 60,
                                fit: BoxFit.fitHeight,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[600]!,
                                          blurRadius: 13.0,
                                        ),
                                      ]
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 1.0,
                                        top: 2.0,
                                        child: Icon(Icons.lock, color: Colors.black54, size:36),
                                      ),
                                      Icon(
                                        Icons.lock,
                                        color: Colors.yellow,
                                        size:36,
                                      )],
                                  )
                              ),
                            ],
                          ) : Image.network(
                            '${bomCharacter.imageUrl}',
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
                            child: !userCharacters.contains(bomCharacter
                                .characterId) // 99일 경우, 유저가 가지고 있찌 않은 코드
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

  void myShowDialog(BuildContext context, Character bomCharacter) {
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
                        onPressed: () async {
                          final currentUserStar = ref
                              .watch(userProvider.notifier)
                              .state
                              .star;
                          final remainStars = currentUserStar! -
                              bomCharacter.star!;
                          print('$remainStars : remainStars');
                          ref.read(userProvider.notifier).editUserStar(
                              remainStars);
                          ref.read(characterListProvider.notifier).addCharacter(
                              bomCharacter.characterId!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.teal[400],
                              duration: Duration(milliseconds: 2000),
                              behavior: SnackBarBehavior.floating,
                              content: Text('구매가 완료되었습니다!'),
                            ),
                          );
                          ref.refresh(characterListProvider.notifier)
                              .getAllCharacter();
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CharacterDetails(character: bomCharacter)),
                          );
                          displayList = result;
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xffA876DE)),
                        child: Text("계속", style: TextStyle(color: Colors.white))),
                    SizedBox(width: 10,),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xffA876DE)),
                        child: Text("닫기", style: TextStyle(color: Colors.white)))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}