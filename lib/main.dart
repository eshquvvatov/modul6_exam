import 'package:flutter/material.dart';
import 'package:modul6_exam/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modul6_exam/service/hive_service.dart';
void main()async {
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.DB_NAME);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
