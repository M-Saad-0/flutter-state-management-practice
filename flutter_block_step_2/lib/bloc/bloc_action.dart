import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_block_step_2/bloc/person.dart';

const String persons1Url =  "http://127.0.0.1:5500/api/person_1.json";
const String persons2Url =  "http://127.0.0.1:5500/api/person_2.json";

typedef PersonLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

class LoadPersonAction extends LoadAction {
  final String url;
  final PersonLoader loader;
  const LoadPersonAction({required this.url, required this.loader}) : super();
}


