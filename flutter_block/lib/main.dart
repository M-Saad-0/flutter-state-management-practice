import 'package:flutter/material.dart';
import 'package:flutter_block/features/home/ui/homepage.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:const Homepage(),
      theme: ThemeData(brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(backgroundColor: Color.fromARGB(255, 49, 59, 58))
      ),
    );
  }
}