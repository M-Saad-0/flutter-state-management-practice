import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block_step_2/bloc/bloc_action.dart';
import 'package:flutter_block_step_2/bloc/person.dart';

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};

  PersonBloc() : super(null) {
    on<LoadPersonAction>((event, emit) async {
      final url = event.url;

      if (_cache.containsKey(url)) {
        final cachedPerson = _cache[url]!;
        final result = FetchResult(persons: cachedPerson, isRetrievedFromCache: true);
        emit(result);
      } else {
        final loader = event.loader;
        final person = await loader(url);
        _cache[url] = person;
        final result = FetchResult(persons: person, isRetrievedFromCache: false);
        emit(result);
      }
    });
  }
}


@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResult({required this.persons, required this.isRetrievedFromCache});

  @override
  String toString() {
    return "Fetched Results: (RetrievedFromCache: $isRetrievedFromCache\tPersons: $persons)";
  }

  @override
  bool operator == (covariant FetchResult other)=>persons.isEqualIgnoringOrdering(other.persons)&& isRetrievedFromCache == other.isRetrievedFromCache;

  @override
  int get hashCode => Object.hash(persons, isRetrievedFromCache);
}

extension IsEqualIgnoringOrdering<T> on Iterable<T>{
  bool isEqualIgnoringOrdering(Iterable<T> other)=>
  length==other.length && {...this}.intersection({...other}).length == length;
}