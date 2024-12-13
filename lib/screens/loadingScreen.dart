
import 'package:flutter/material.dart';
import 'package:snap/colorTheme.dart';
import 'package:snap/essentials.dart';
import 'package:snap/models/userModel.dart';
import 'package:snap/screens/homeScreen.dart';
import 'package:snap/screens/loginScreen.dart';
import 'package:snap/services/AuthService.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    initialize();
    super.initState();
  }

  User user = User();
  initialize() async{
    try{
      var result = await AuthService.getUserProfile();
      var token = await AuthService.readToken();
      setState(() {
        user = User.fromJson(result);
        User.setStaticUser(user);
        User.userToken=token;
      });
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColorBlack,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.6, end: 1.0),
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          builder: (__, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Align children properly
                  children: [
                    Essentials.logo(
                      width: MediaQuery.of(context).size.width - 80,
                    ),
                    const SizedBox(height: 10), // Add spacing between widgets
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0), // Add padding to prevent overflow
                      child: Text(
                        "Surveillance Network for Advanced Patrolling",
                        style: TextStyle(color: Colors.white70,
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center, // Align text in the center
                        maxLines: 2, // Limit the text to 2 lines
                        overflow: TextOverflow.ellipsis, // Handle text overflow gracefully
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          onEnd: () {
            if(user !=null && user.phoneNumber !=null){
              e.replace(context, Homescreen());
            }else e.replace(context, Homescreen());
          },
        ),
      ),
    );
  }
}
