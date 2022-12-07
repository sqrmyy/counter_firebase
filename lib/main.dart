import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:counter_firebase/normal_counter_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Homepage'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: const <Widget>[
          _PagePushButton(
            buttonTitle: 'ノーマルカウンター',
            pagename: NormalCounterPage(),
          ),
        ],
      ),
    );
  }
}

class _PagePushButton extends StatelessWidget {
  const _PagePushButton({
    Key? key,
    required this.buttonTitle,
    required this.pagename,
  }) : super(key: key);

  final String buttonTitle;
  final dynamic pagename;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pagename),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(buttonTitle),
      ),
    );
  }
}
