import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'web/utils.dart' if (dart.library.io) 'stub/utils.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    initializeJsInterop(_incrementCounter);
  }
  
  @override
  void dispose() {
    disposeJsInterop();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _incrementReactCounter() {
    incrementReactCounter();
  }

  @override
  Widget build(BuildContext context) {
    final int randomIntValue = getRandomIntValue(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withAlpha((0.8 * 255).round()),
                Theme.of(context).colorScheme.secondary.withAlpha((0.9 * 255).round()),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flutter_dash, size: 22, color: Colors.white),
            const SizedBox(width: 8),
            const Text(
              kIsWeb ? 'Multi-view mode app' : 'Normal mode app',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 48,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            kIsWeb ? Text(
              'Random value from React: $randomIntValue',
              style: const TextStyle(fontSize: 14),
            ) : Text('Not on web, so no random value from React'),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Text(
                  '$_counter',
                  key: const Key('embedded_app_counter'),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 36,
                  child: ElevatedButton.icon(
                    key: const Key('local_fab'),
                    onPressed: _incrementCounter,
                    icon: const Icon(Icons.add, color: Colors.white, size: 18),
                    label: const Text('Flutter', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      minimumSize: const Size(0, 36),
                      elevation: 2,
                    ),
                  ),
                ),
                if (kIsWeb) 
                  const SizedBox(width: 16),
                if (kIsWeb) 
                  SizedBox(
                    height: 36,
                    child: ElevatedButton.icon(
                      key: const Key('external_fab'),
                      onPressed: _incrementReactCounter,
                      icon: const Icon(Icons.add, color: Colors.white, size: 18),
                      label: const Text('React', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        minimumSize: const Size(0, 36),
                        elevation: 2,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
