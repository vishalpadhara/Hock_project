import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hocky_game/screen/home/home_screen.dart';
import 'package:hocky_game/screen/play_demo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      title: 'Hockey-Sweeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData (
        fontFamily: "GorditasRegular",
        primarySwatch: Colors.blue,
      ),
      //home: const ExampleDragAndDrop(),
      home: const HomeScreen(),
    );
  }
}
