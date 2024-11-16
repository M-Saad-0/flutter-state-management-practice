import 'package:flutter_block_step_2/bloc/bloc_action.dart';
import 'package:flutter_block_step_2/bloc/person.dart';
import 'package:flutter_block_step_2/bloc/person_block.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

Iterable<Person> mockedPersons1 = [
  const Person(name: "Ali", age: 20),
  const Person(name: "Tanvir", age: 20)
];

Iterable<Person> mockedPersons2 = [
  const Person(name: "Hamza", age: 50),
  const Person(name: "Gulman", age: 25)
];

Future<Iterable<Person>> mockGetPerson1(String _) =>
    Future.value(mockedPersons1);
Future<Iterable<Person>> mockGetPerson2(String _) =>
    Future.value(mockedPersons2);

void main() {
  group("Testing bloc", () {
    late PersonBloc bloc;
    setUp(() {
      bloc = PersonBloc();
    });

    blocTest<PersonBloc, FetchResult?>("Testing initial state",
        build: () => bloc, verify: (bloc) => expect(bloc.state, null));

    blocTest<PersonBloc, FetchResult?>("Testing with person1",
        build: () => bloc,
        act: (bloc) {
          bloc.add(const LoadPersonAction(url: "url", loader: mockGetPerson1));
          bloc.add(const LoadPersonAction(url: "url", loader: mockGetPerson1));
        },
        expect: () => [
              FetchResult(persons: mockedPersons1, isRetrievedFromCache: false),
              FetchResult(persons: mockedPersons1, isRetrievedFromCache: true)
            ]);

    blocTest<PersonBloc, FetchResult?>("Testing with person2",
        build: () => bloc,
        act: (bloc) {
          bloc.add(const LoadPersonAction(url: "url", loader: mockGetPerson2));
          bloc.add(const LoadPersonAction(url: "url", loader: mockGetPerson2));
        },
        expect: () => [
              FetchResult(persons: mockedPersons2, isRetrievedFromCache: false),
              FetchResult(persons: mockedPersons2, isRetrievedFromCache: true)
            ]);

            
  });

  
}
