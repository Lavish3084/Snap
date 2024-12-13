import 'package:flutter/material.dart';

void main() {
  runApp(ReportApp());
}

class ReportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the Report1 screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Report1(title: 'BottomSheet Demo')),
            );
          },
          child: Text('Go to Report Screen'),
        ),
      ),
    );
  }
}

class Report1 extends StatefulWidget {
  final String title;

  Report1({Key? key, required this.title}) : super(key: key);

  @override
  _Report1State createState() => _Report1State();
}

class _Report1State extends State<Report1> {
  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: Text("Welcome to AndroidVille!"),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Click the floating action button to show bottom sheet.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayBottomSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
