import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'injection_container.dart' as di;
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.initSearch();
  runApp(const HdClient());
}

class HdClient extends StatelessWidget{
  const HdClient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HDRezka mobile',
      theme: _lightTheme,
      routes: {
        '/' : (context) => const MainScreen()
      },
      initialRoute: '/',
    );
  }
}

ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity.comfortable,
  primaryColorBrightness: Brightness.light,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return Colors.grey;
            if (states.contains(MaterialState.focused)) return const Color(0xff00737e);
            if (states.contains(MaterialState.hovered)) return const Color(0xff0a8b98);
            return const Color(0xff00a0b0);
          }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return const Color(0xffffffff);
            if (states.contains(MaterialState.focused)) return const Color(0xffffffff);
            if (states.contains(MaterialState.hovered)) return const Color(0xffffffff);
            return const Color(0xffffffff);
          }),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) return const Color(0xffbdbdbd);
            if (states.contains(MaterialState.focused)) return const Color(0xff369ebb);
            if (states.contains(MaterialState.hovered)) return const Color(0xff369ebb);
            return const Color(0xff2e859e);
          }),
    ),
  ),
  primarySwatch: Colors.blueGrey,
  primaryColor: const Color(0xffffffff),
  primaryColorLight: const Color(0xffffffff),
  primaryColorDark: Colors.grey,
  canvasColor: const Color(0xffefefef),
  scaffoldBackgroundColor: const Color(0xffefefef),
  bottomAppBarColor: const Color(0xffffffff),
  cardColor: const Color(0xff313131),
  indicatorColor: const Color(0xff369ebb),
  hintColor: const Color(0xff777777),
  errorColor: Colors.deepOrange,
  toggleableActiveColor: const Color(0xff3e464c),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 56,
      color: Color(0xff000000),
    ),
    headline2: TextStyle(
      fontSize: 44,
      color: Color(0xff000000),
    ),
    headline3: TextStyle(
      fontSize: 44,
      color: Color(0xff000000),
    ),
    headline4: TextStyle(
      fontSize: 36,
      color: Color(0xff000000),
    ),
    headline5: TextStyle(
      color: Color(0xff77778a),
    ),
    headline6: TextStyle(
      fontSize: 22,
    ),
    bodyText1: TextStyle(
      fontSize: 14,
      color: Color(0xff444444),
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      color: Color(0xff777777),
    ),
    button: TextStyle(
      fontSize: 28,
      color: Color(0xffffffff),
    ),
    caption: TextStyle(
      color: Color(0xff848b8e),
    ),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xffffffff),
      iconTheme: IconThemeData(
        color: Color(0xff000000),
        size: 10,
      ),
      titleTextStyle: TextStyle(
          inherit: false,
          color: Color(0xff000000),
          fontWeight: FontWeight.w700,
          fontSize: 18
      )
  ),

);