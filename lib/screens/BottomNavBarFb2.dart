import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snap/essentials.dart';
import 'package:snap/helpers/constants.dart';
import 'package:snap/main.dart';
import 'package:snap/models/userModel.dart';
import 'package:snap/screens/Report.dart';
import 'package:snap/screens/loadingScreen.dart';
import 'package:snap/screens/selectcar.dart';
import 'package:snap/services/AuthService.dart';
import 'package:snap/services/api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:permission_handler/permission_handler.dart';
import 'package:snap/screens/homeScreen.dart';
import 'Emergency.dart';
class BottomNavBarFb2 extends StatelessWidget {
  const BottomNavBarFb2({Key? key}) : super(key: key);

  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 20,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                text: "Home",
                icon: Icons.home,
                selected: true,
                onPressed: () {
                  e.replace(context, Homescreen());
                },
              ),
              IconBottomBar(
                text: "Emergency",
                icon: Icons.emergency_outlined,
                selected: false,
                onPressed: () {
                  e.replace(context, Emergency());
                },
              ),
              IconBottomBar(
                text: "Patrol",
                icon: Icons.safety_check_outlined,
                selected: false,
                onPressed: () {
                  e.replace(context, LocationDetailsWithNotes());; 
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);

  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? primaryColor : const Color.fromARGB(255, 74, 74, 74).withOpacity(.9),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            height: .1,
            color: selected
                ? primaryColor
                : const Color.fromARGB(255, 53, 61, 74).withOpacity(.9),
          ),
        ),
      ],
    );
  }
}









