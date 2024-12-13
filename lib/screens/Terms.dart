import 'package:flutter/gestures.dart'; // Add this import for TapGestureRecognizer
import 'package:flutter/material.dart';
import 'package:snap/essentials.dart';
import 'package:snap/screens/homeScreen.dart';
import 'package:snap/screens/loadingScreen.dart';
import 'package:snap/screens/loginScreen.dart';
import 'package:snap/screens/selectcar.dart';
import 'package:snap/services/AuthService.dart';
import 'package:snap/widgets/TextField.dart';
import 'package:snap/widgets/snackbar.dart';
import 'package:snap/screens/slider.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            // Header
            Row(
              children: [
                Icon(
                  Icons.description,
                  color: Colors.blue,
                  size: 30,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Accept TBI's Terms & Review Privacy Notice",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Description Text with Inline Buttons
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "By selecting ‘I Agree’ below, I have reviewed and agree to the ",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  TextSpan(
                    text: "Terms of Use",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('tapped');
                      },
                  ),
                  TextSpan(
                    text: " and acknowledge the ",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  TextSpan(
                    text: "Privacy Notice",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('tapped');
                      },
                  ),
                  TextSpan(
                    text: " I am Police Employee under Punjab Police.",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Agree Checkbox on the rightmost side
            Row(
              children: [
                Text(
                  "I agree",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(child: Container()), // This will push the checkbox to the right
                Checkbox(
                  
                  value: isAgreed,
                  onChanged: (bool? value) {
                    setState(() {
                      isAgreed = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    e.replace(context, Loginscreen());
                  },
                ),
                // Next button
                ElevatedButton(
                  onPressed: isAgreed
                      ? () {
                          e.replace(context, SelectCar());
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                    backgroundColor:
                        isAgreed ? Colors.black : Colors.grey, // Change color when not agreed
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
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
