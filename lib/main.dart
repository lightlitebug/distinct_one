import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'reducer.dart';

late final Store<int> store;

void main() {
  store = Store<int>(reducer, initialState: 0);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StoreConnector<int, _ViewModel>(
          distinct: true,
          converter: (Store<int> store) => _ViewModel.fromStore(store),
          builder: (BuildContext context, _ViewModel vm) {
            print('Building...');
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${vm.counter}',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        vm.incrementOne();
                      },
                      child: const Text(
                        '+1',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    FloatingActionButton(
                      onPressed: () {
                        vm.incrementZero();
                      },
                      child: const Text(
                        '+0',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final int counter;
  final VoidCallback incrementOne;
  final VoidCallback incrementZero;
  const _ViewModel({
    required this.counter,
    required this.incrementOne,
    required this.incrementZero,
  });

  static fromStore(Store<int> store) {
    return _ViewModel(
      counter: store.state,
      incrementOne: () => store.dispatch(IncrementOneAction()),
      incrementZero: () => store.dispatch(IncrementZeroAction()),
    );
  }

  @override
  List<Object> get props => [counter];
}
