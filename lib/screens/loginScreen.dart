import 'package:flutter/material.dart';
import 'package:snap/essentials.dart';
import 'package:snap/screens/Terms.dart';
import 'package:snap/screens/homeScreen.dart';
import 'package:snap/screens/loadingScreen.dart';
import 'package:snap/screens/selectcar.dart';
import 'package:snap/services/AuthService.dart';
import 'package:snap/widgets/TextField.dart';
import 'package:snap/widgets/snackbar.dart';
import 'package:snap/screens/slider.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _loader = false;

  _login() {
    // Add your login functionality here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 36, 36), // Set the entire background to black
      body: SingleChildScrollView( // This makes the whole content scrollable
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 30), // Spacer at the top
              Padding(
                padding: EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 12),
                child: Image.asset('assets/images/punjab-police.webp', height: 180),
              ),
              SizedBox(height: 28), // Additional Spacer
              Text(
                "Surveillance Network for Advanced Patrolling.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white), // White text
              ),
              SizedBox(height: 24),
              // TabBar implementation
              DefaultTabController(
                length: 2, // Changed to 2 tabs
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Material(
                        elevation: 0, // Removes the shadow
                        color: Colors.transparent, // Keeps the background transparent
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 36, 36, 36), // Set background to black
                          ),
                          child: TabBar(
                            labelColor: Colors.black, // Active tab label color is black
                            unselectedLabelColor: Colors.white, // Inactive tab label color is white
                            indicator: BoxDecoration(
                              color: Colors.white, // Indicator color is white
                              borderRadius: BorderRadius.circular(30),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            dividerColor: Colors.transparent, // Keeps the
                            tabs: [
                              Tab(text: "Mobile Number"),
                              Tab(text: "E-mail"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300, // Adjusted height
                      child: TabBarView(
                        children: [
                          // Mobile Number Login Form
                          Column(
                            children: [
                              // Label for Phone number aligned to the left
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // White text color
                                  ),
                                ),
                              ),
                              EmailInputFb2(
                                inputController: _phoneController,
                                suffixIcon: Icons.phone,
                                title: "Phone",
                                hintText: "1234567890",
                              ),
                              SizedBox(height: 16),
                              // Label for Password aligned to the left
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // White text color
                                  ),
                                ),
                              ),
                              EmailInputFb2(
                                suffixIcon: Icons.lock,
                                inputController: _passwordController,
                                password: true,
                                title: "Password",
                                hintText: "********",
                              ),
                            ],
                          ),
                          // E-mail Login Form
                          Column(
                            children: [
                              // Label for Email aligned to the left
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // White text color
                                  ),
                                ),
                              ),
                              EmailInputFb2(
                                inputController: _phoneController,
                                suffixIcon: Icons.email,
                                title: "Email",
                                hintText: "example@email.com",
                              ),
                              SizedBox(height: 16),
                              // Label for Password aligned to the left
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // White text color
                                  ),
                                ),
                              ),
                              EmailInputFb2(
                                suffixIcon: Icons.lock,
                                inputController: _passwordController,
                                password: true,
                                title: "Password",
                                hintText: "********",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              e.button(
                "Sign In",
                onPress: () 
                {e.replace(context, TermsAndConditionsScreen());},
                /*async{
              setState(() {
                _loader=true;
              });
              String email = _phoneController.text;
              String password = _passwordController.text;

              try{
                if (email.isEmpty) {
                  openPrimarySnackBar(context, "Please enter your email", color: Colors.redAccent);
                } else if (password.isEmpty ) {
                  openPrimarySnackBar(context, "Please enter your password", color: Colors.redAccent);
                }else{
                  final result = await AuthService.login(_phoneController.text, _passwordController.text);
                  if(result) e.replace(context, LoadingScreen());
                }
              }catch(e){}
              finally {
                setState(() {
                  _loader = false;
                });
              }
            }*/
              ),
              SizedBox(height: 12),
              Text(
                "Made with LOVE❤️ by CU TBI",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white, // White text color
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
