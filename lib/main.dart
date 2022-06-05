import 'package:bom_front/home.dart';
import 'package:bom_front/view/create_room_screen.dart';
import 'package:bom_front/view/forRoute.dart';
import 'package:bom_front/view/join_room_screen.dart';
import 'package:bom_front/view/main_menu_screen.dart';
import 'package:bom_front/view/quiz_screen.dart';
import 'package:bom_front/view/wating_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // initializeDateFormatting('ko_KR', null)
  //     .then((_) => runApp(const ProviderScope(child: MyApp()))); // flutter_localizations와 충돌
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team BOM',
      theme: ThemeData(primaryColor: const Color(0xffA876DE)),
      home: const Home(),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko', 'KR')],
      routes: {
        ForRoute.routeName: (context) => const ForRoute(),
        MainMenuScreen.routeName: (context) => const MainMenuScreen(),
        JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
        CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
        WaitingLobby.routeName: (context) => const WaitingLobby(),
        QuizScreen.routeName: (context) => const QuizScreen(),
      },
      // initialRoute: ForRoute.routeName,
      // home: ForRoute(), // initialRoute때문에 두개가 잡힘
    );
  }
}