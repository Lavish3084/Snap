import 'package:flutter/material.dart';
import 'package:snap/colorTheme.dart';
//import 'package:snap/screens/Emergency.dart';
//import 'package:snap/screens/loadingScreen.dart';
//import 'package:snap/screens/loginScreen.dart';
//import 'package:snap/screens/temp.dart';
import 'package:snap/screens/loginScreen.dart';
import 'background_task.dart';
//import 'package:snap/screens/homeScreen.dart';
//import 'package:snap/screens/selectcar.dart';
//import 'package:snap/screens/Terms.dart';
//import 'package:snap/screens/temp.dart';
//import 'package:background_location/background_location.dart';
//import  'package:snap/screens/backgroundfetch.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Workmanager
  // Workmanager().initialize(

  //   callbackDispatcher, // The top level function
  //   isInDebugMode: false, // Set to false for production
  // );

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: AppTheme.whiteTheme,
      home: const MyHomePage(title: 'Punjab Police'),
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // appBar: Essentials.appBar(title: Text("Punjab Police")),
        body: Loginscreen()  //Homescreen()
    );
  }
}
