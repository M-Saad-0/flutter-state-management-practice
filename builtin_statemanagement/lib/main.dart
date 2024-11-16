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
      home: const HomePage(),
      theme: ThemeData.light(useMaterial3: false),
      routes: {
        '/new-contact':(context)=>const NewContactsView()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (contact, value, child) {
          final contacts = value;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Dismissible(
                onDismissed: (_){
                  ContactBook().remove(contact:contact); 
                },
                key: ValueKey(contact.id),
                child: Material(
                  elevation: 6,
                  child: ListTile(
                    title: Text(contact.name),
                  ),
                ),
              );
            });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.of(context).pushNamed("/new-contact");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Contacts {
  final String id;
  final String name;
  Contacts({required this.name}):id=const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contacts>>{
  ContactBook._sharedInstance():super([Contacts(name: "name")]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  int get lenght => value.length;

  void add({required Contacts contact}) {
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  void remove({required Contacts contact}) {
    final contacts = value;
    if(contacts.contains(contact)){
      contacts.remove(contact);
      notifyListeners();
    }
  }

  Contacts? contacts({required int index}) =>
      value.length > index ? value[index] : null;
}

class NewContactsView extends StatefulWidget {
  const NewContactsView({super.key});

  @override
  State<NewContactsView> createState() => _NewContactsViewState();
}

class _NewContactsViewState extends State<NewContactsView> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new contacts"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
                hintText: "Enter new contact name here..."),
          ),
          TextButton(
              onPressed: () {
                Contacts newContact = Contacts(name: _controller.text);
                ContactBook().add(contact: newContact);
                Navigator.of(context).pop();
              },
              child: const Text("Add Contact"))
        ],
      ),
    );
  }
}
