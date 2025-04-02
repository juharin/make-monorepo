import 'package:flutter/material.dart';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:ui_web';
import 'view_interop.dart' show InitialViewData, incrementCounter;

// Add top-level external setter for JS interop
@JS()
external set exportedIncrement(JSFunction value);

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Embeddable Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 63, 138, 236)),
      ),
      home: const MyHomePage(title: 'Embeddable Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Remove @JS() from this class
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Assign the function to the top-level setter
    exportedIncrement = _incrementCounter.toJS;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Remove the external setter from the class
  // @JS()
  // external set exportedIncrement(JSFunction value);

  void _incrementReactCounter() {
    incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    final int viewId = View.of(context).viewId;
    final jsInitialData = views.getInitialData(viewId) as JSObject;
    final initialData = InitialViewData.fromJS(jsInitialData);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('This is an embeddable Flutter app in multi-view mode.'),
            Text('Random int value from initial data: ${initialData.randomIntValue}'),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              key: const Key('embedded_app_counter'),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: const Key('local_fab'),
            onPressed: _incrementCounter,
            tooltip: 'Increment local counter',
            heroTag: 'local_fab',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            key: const Key('external_fab'),
            onPressed: _incrementReactCounter,
            tooltip: 'Increment external counter',
            heroTag: 'external_fab',
            child: const Text('Increment React counter'),
          ),
        ],
      ),
    );
  }
}
