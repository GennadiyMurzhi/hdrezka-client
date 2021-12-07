import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity.comfortable,
  primaryColorBrightness: Brightness.light,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) return Colors.grey;
        if (states.contains(MaterialState.focused))
          return const Color(0xff00737e);
        if (states.contains(MaterialState.hovered))
          return const Color(0xff0a8b98);
        return const Color(0xff00a0b0);
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled))
          return const Color(0xffffffff);
        if (states.contains(MaterialState.focused))
          return const Color(0xffffffff);
        if (states.contains(MaterialState.hovered))
          return const Color(0xffffffff);
        return const Color(0xffffffff);
      }),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled))
          return const Color(0xffbdbdbd);
        if (states.contains(MaterialState.focused))
          return const Color(0xff369ebb);
        if (states.contains(MaterialState.hovered))
          return const Color(0xff369ebb);
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
          fontStyle: FontStyle.italic,
          fontSize: 36,
          color: Color(0xff000000),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400),
      headline5: TextStyle(
        color: Color(0xff77778a),
      ),
      headline6: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: 26,
          color: Color(0xff000000),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500),
      bodyText1: TextStyle(
        fontSize: 22,
        color: Color(0xff444444),
        fontFamily: 'Roboto',
      ),
      bodyText2: TextStyle(
        fontSize: 22,
        color: Color(0xff777777),
        fontFamily: 'Roboto',
      ),
      button: TextStyle(
        fontSize: 28,
        color: Color(0xffffffff),
      ),
      caption: TextStyle(
        color: Color(0xff848b8e),
      ),
      subtitle1: TextStyle(
          color: Color(0xff333333),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto_Mono',
          fontStyle: FontStyle.italic),
      subtitle2: TextStyle(
          color: Color(0xff77778a),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
          fontStyle: FontStyle.italic)),
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
          fontSize: 18)),
);
