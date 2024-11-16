import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_step_2/bloc/bloc_action.dart';
import 'package:flutter_block_step_2/bloc/person.dart';
import 'package:flutter_block_step_2/bloc/person_block.dart';
import 'package:http/http.dart' as http;

// Entry point of the app
void main() {
  runApp(const MyApp());
}

// Main app widget
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
      home: BlocProvider(
        create: (_) => PersonBloc(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

// Person model class


// Enum to define API URLs


// Fetch result model class


// Bloc load actions

// Bloc for person loading


// Function to fetch person data from the API
Future<Iterable<Person>> getPerson(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final List<dynamic> list = json.decode(response.body);
    return list.map((e) => Person.fromJson(e));
  } else {
    throw Exception('Failed to load persons');
  }
}

// Log extension for debugging
extension Log on Object {
  void log() => debugPrint(toString());
}

// Subscript extension to access list elements safely
extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

// Main screen widget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// State class for MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Buttons to load JSON data
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<PersonBloc>().add(const LoadPersonAction(url: persons1Url, loader:getPerson));
                },
                child: const Text("Load Json #1"),
              ),
              TextButton(
                onPressed: () {
                  context.read<PersonBloc>().add(const LoadPersonAction(url: persons2Url, loader: getPerson));
                },
                child: const Text("Load Json #2"),
              ),
            ],
          ),
          // Display persons data using BlocBuilder
          BlocBuilder<PersonBloc, FetchResult?>(
            buildWhen: (previousResult, currentResult) =>
                previousResult?.persons != currentResult?.persons,
            builder: (context, state) {
              final persons = state?.persons;

              if (persons == null) {
                return const SizedBox();
              } else {
                state!.log();
                return Expanded(
                  child: ListView.builder(
                    itemCount: persons.length,
                    itemBuilder: (context, index) {
                      final person = persons[index]!;
                      return Text("-> ${person.name}");
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}


// Future<Iterable<Person>> getPerson(String url) => HttpClient()
//     .getUrl(Uri.parse(url))
//     .then((req) => req.close())
//     .then((resp) => resp.transform(utf8.decoder).join())
//     .then((str) => json.decode(str) as List<dynamic>)
//     .then((list) => list.map((e) => Person.fromJson(e)));