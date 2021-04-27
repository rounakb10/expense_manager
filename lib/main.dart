import 'package:expense_manager/Models/expense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:theme_provider/theme_provider.dart';

import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ExpenseAdapter());

  await Hive.openBox('expense');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    openBox();
//  }

//  Future openBox() async {
//    final expenseBox = await Hive.openBox('expense');
//  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = Color(0xff121212);
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme(
          id: "actual_dark",
          description: "Dark",
          data: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: bgColor,
            accentColor: Colors.grey[850],
            appBarTheme: AppBarTheme(
              color: bgColor,
            ),
            cardColor: Colors.transparent,
            bottomAppBarColor: bgColor,
            cardTheme: CardTheme(elevation: 2, color: Colors.blueGrey[900]),
            inputDecorationTheme:
                InputDecorationTheme(fillColor: Colors.grey.shade900),
          ),
        ),
        AppTheme(
          id: "actual_light",
          description: "Light",
          data: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            cardColor: Colors.transparent,
            appBarTheme: AppBarTheme(
              color: Colors.lightBlueAccent,
            ),
            cardTheme: CardTheme(elevation: 1, color: Colors.grey.shade300),
            inputDecorationTheme:
                InputDecorationTheme(fillColor: Colors.grey.shade300),
          ),
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.themeOf(themeContext).data,
            home: Home(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Hive.close();
  }
}
