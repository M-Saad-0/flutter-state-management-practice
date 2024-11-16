import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ApiProvider(
        api: Api(),
        child: const HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueKey _textKey = const ValueKey<String?>(null);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(ApiProvider.of(context).api.dateAndTime??""),),
      body: GestureDetector(
        onTap: ()async{
          final api = ApiProvider.of(context).api;
          final dateAndTime = await api.getDateAndTime();

          setState(() {
            _textKey = ValueKey(dateAndTime);
          });
        },
        child: SizedBox.expand(child: Container(color: Colors.white,child: DateTimeWidget(key: _textKey,),))),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return  Text(api.dateAndTime??"Tap on the screen to fetch date and time");
  }
}

class Api{
  String? dateAndTime;
  Future<String> getDateAndTime(){
    return Future.delayed(const Duration(seconds: 20), (){
      return DateTime.now().toIso8601String();
    }).then((v){dateAndTime=v;return v;});
  }
}

class ApiProvider extends InheritedWidget{
  final Api api; 
  final String uuid;  
   ApiProvider({required this.api, required child}):uuid=const Uuid().v4(),super(child: child);
    @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return oldWidget.uuid!=uuid;
  }

  static ApiProvider of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}