import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hdrezka_client/theme.dart';

import 'injection_container.dart' as di;
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.initSearch();
  await di.initListDisplay();
  await di.initPage();

  runApp(const HdClient());
}

class HdClient extends StatelessWidget{
  const HdClient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HDRezka mobile',
      theme: lightTheme,
      routes: {
        '/' : (context) => const MainScreen()
      },
      initialRoute: '/',
    );
  }
}

