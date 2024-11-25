import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BreadCrumProvider(),
      child: MaterialApp(
        title: 'Provider_1',
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
          dialogTheme: const DialogTheme(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)))),
          textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll<Size>(Size(150, 45)),
                  elevation: WidgetStatePropertyAll<double>(10),
                  shape: WidgetStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.black),
                  textStyle: WidgetStatePropertyAll<TextStyle>(TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)))),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {'/new': (context) => const NewBreadCrumWidget()},
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BreadCrums"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<BreadCrumProvider>(
            builder: (context, value, child) =>
                BreadCrumWidget(breadCrums: value.item),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/new');
              },
              child: const Text("Add New BreadCrum")),
          TextButton(
              onPressed: () {
                context.read<BreadCrumProvider>().reset();
              },
              child: const Text("Reset"))
        ],
      ),
    );
  }
}

class NewBreadCrumWidget extends StatefulWidget {
  const NewBreadCrumWidget({super.key});

  @override
  State<NewBreadCrumWidget> createState() => _NewBreadCrumWidgetState();
}

class _NewBreadCrumWidgetState extends State<NewBreadCrumWidget> {
  TextEditingController breadCrumController = TextEditingController();
  @override
  void dispose() {
    breadCrumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add BreadCrum"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: breadCrumController,
          ),
          TextButton(onPressed: () {
            final text = breadCrumController.text;
            if(text.isNotEmpty){
              final breadCrum = BreadCrum(isActive: false, name: text);
              context.read<BreadCrumProvider>().addBreadCrum(breadCrum);
              Navigator.of(context).pop();
            }
          }, child: const Text("Add new BreadCrum"))
        ],
      ),
    );
  }
}

class BreadCrum {
  bool isActive;
  final String name;
  final String uuid;
  BreadCrum({required this.isActive, required this.name})
      : uuid = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrum other) {
    return uuid == other.uuid;
  }

  @override
  int get hashCode => uuid.hashCode;
  String get title => isActive ? "$name >" : name;
}

class BreadCrumProvider extends ChangeNotifier {
  final List<BreadCrum> _items = [];
  UnmodifiableListView<BreadCrum> get item => UnmodifiableListView(_items);

  void addBreadCrum(BreadCrum breadCrum) {
    for (final item in _items) {
      item.activate();
    }
    _items.add(breadCrum);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
}

class BreadCrumWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrum> breadCrums;
  const BreadCrumWidget({super.key, required this.breadCrums});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrums
          .map((l) => Text(
                l.title,
                style:
                    TextStyle(color: l.isActive ? Colors.cyan : Colors.black),
              ))
          .toList(),
    );
  }
}
