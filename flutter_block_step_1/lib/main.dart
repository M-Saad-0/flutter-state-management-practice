import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

const name = ["foo", "bar", "baz"];
extension RandomElement<T> on Iterable<T>{
  T getRandomElement() => elementAt(math.Random().nextInt(length)); 
}

class NamesCubit extends Cubit<String?>{
  NamesCubit(): super(null);  
  void pickRandomName() => emit(name.getRandomElement());
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final NamesCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = NamesCubit();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(" "),
      ),
      body: StreamBuilder<String?>(stream: cubit.stream, builder: (context, snapshot){
        final button = TextButton(onPressed: (){
          cubit.pickRandomName();
        }, child: const Text("Pick a random name"));
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return button;
          case ConnectionState.waiting:
            return button;
          case ConnectionState.active:
            return Column(children: [Text(snapshot.data??" "),button],);
          case ConnectionState.done:
            return const SizedBox();
        }
      })
     
    );
  }
}
