import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => AppState(), child: App()));
}

class AppState with ChangeNotifier {
  int count = 0;
  List<String> tags = ["foo", "bar"];

  incrementCount() {
    count++;
    notifyListeners();
  }

  addTag(String tag) {
    tags.add(tag);
    notifyListeners();
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Code'),
      ),
      body: Center(
          child: Text(
              'You have pressed the button ${context.watch<AppState>().count ?? 0} times.')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AppState>().incrementCount(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
          child: Stack(alignment: Alignment.center, children: [
        ListView(
          children: List.of(context
              .watch<AppState>()
              .tags
              .map((e) => ListTile(title: Text(e)))),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
                labelText: "Add Tag", border: OutlineInputBorder()),
            onSubmitted: (foo) {
              context.read<AppState>().addTag(foo);
            },
          ),
        )
      ])),
    );
  }
}
