import 'package:bom_front/view/components/bom_menu.dart';
import 'package:bom_front/view/components/character/character_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/character.dart';
import 'components/bottom_navigation.dart';
import 'components/plan/appbar.dart';

class CollectionScreen extends ConsumerStatefulWidget {
  const CollectionScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends ConsumerState<CollectionScreen> {
  late TextEditingController _textController;
  static List<Character> bomCharacters = [
    Character(
        characterId: 1,
        characterName: "a",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/rabbit.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "b",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "c",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/rabbit.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "d",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "a",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "e",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/rabbit.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "f",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "g",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/rabbit.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "h",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "i",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/rabbit.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "j",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "k",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/rabbit.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "l",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "m",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/rabbit.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "n",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "h",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/rabbit.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "i",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""), Character(
        characterId: 1,
        characterName: "j",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/rabbit.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "k",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "o",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/rabbit.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 0,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),
    Character(
        characterId: 1,
        characterName: "p",
        star: 1,
        imageUrl: "https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png",
        silhouetteUrl: "salkdfjs;lajdflajsd",
        introduction: "turtle",
        explanation: "it's practice",
        brain: 0,
        speed: 0,
        power: 0,
        teq: 55,
        strength: 0,
        height: 0,
        weight: 0,
        mbti: ""),


  ];

  void _showDialog(BuildContext context) {

    showDialog(
      context: context, builder: (BuildContext context) {
      // return object of type Dialog
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(30.0)),
        child: Container(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlutterLogo(size: 150,),
              Text("This is a Custom Dialog",style:TextStyle(fontSize: 20),),
              ElevatedButton(

                  onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text("닫기"))
            ],
          ),
        ),
      );
    },
    );
  }

    List<Character> display_list = List.from(bomCharacters);

  void updateList(String value) {
    setState(() {
      display_list = bomCharacters
          .where((el) =>
          el.characterName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    _textController = TextEditingController(text: 'initial text');
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthSize = MediaQuery
        .of(context)
        .size
        .width;
    final heightSize = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: const BomAppBar(title: '캐릭터 도감', screenName: 'collection',),
      drawer: BomMenu(),
      body: Center(
        child: Column(
          children: [
          Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(15),
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
        SizedBox(height: 20.0),
        display_list.length == 0
            ? Center(
            child: Text(
              "Now result found",
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
                  (bomCharacter) =>
                  GestureDetector(
                    onTap: (){
                      print('clicked');
                      // _showDialog(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CharacterDetails(character: bomCharacter)),
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth:
                        MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                      ),
                      margin: EdgeInsets.only(top: 10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(width: 4, color: Colors.orange),
                        ),
                        color: Colors.white,
                        elevation: 10,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                        Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
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
                              child: bomCharacter.teq == 55 ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star_rounded,
                                      color: Colors.yellowAccent[700],
                                      size: 15.0),
                                  const Text('10',
                                      style: TextStyle(fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white))
                                ],
                              ) : Text('${bomCharacter.characterName}',
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
    ),
    ],
    ),
    ),
    bottomNavigationBar
    :
    BottomNavigationBarWidget
    (
    )
    ,
    );
  }
}
