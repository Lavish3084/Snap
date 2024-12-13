import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:action_slider/action_slider.dart';
import 'BottomNavBarFb2.dart';
import 'package:snap/widgets/bottum.dart'; // Import your custom Bottom Sheet file
import 'package:snap/helpers/constants.dart';
import 'package:snap/models/userModel.dart';
import 'package:snap/services/AuthService.dart';
import 'package:snap/essentials.dart';
import 'package:snap/screens/loginScreen.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  IO.Socket? socket;
  bool isPatrolling = User.user.active ?? false;
  Timer? locationTimer;

  @override
  void initState() {
    super.initState();
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io(
      Server.baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket?.connect();

    socket?.onConnect((_) {
      print('Connected to socket server');
    });

    socket?.onDisconnect((_) {
      print('Disconnected from socket server');
    });

    socket?.onConnectError((data) {
      print('Connection Error: $data');
    });
  }

  void _togglePatrolling() async {
    if (isPatrolling) {
      var _patrol = await AuthService.stop();
      if (!_patrol) return;
      setState(() {
        isPatrolling = false;
      });
      locationTimer?.cancel();
      locationTimer = null;
      print('Patrolling stopped');
    } else {
      var _patrol = await AuthService.start();
      if (!_patrol) return;
      setState(() {
        isPatrolling = true;
      });
      _startSendingLocation();
      print('Patrolling started');
    }
  }

  Future<void> _startSendingLocation() async {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      locationTimer = Timer.periodic(Duration(seconds: 5), (_) async {
        try {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          Map<String, dynamic> locationData = {
            'userId': User.user.id,
            'latitude': position.latitude,
            'longitude': position.longitude,
          };

          socket?.emit('location_update', locationData);
          print('Location sent: $locationData');
        } catch (e) {
          print('Error fetching location: $e');
        }
      });
    } else {
      print('Location permission denied');
    }
  }

  @override
  void dispose() {
    locationTimer?.cancel();
    socket?.disconnect();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  final user = User.user;

  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 208, 208, 208),
    body: Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.network(
            user.profilePicture ?? 'https://via.placeholder.com/150',
            fit: BoxFit.cover,
          ),
        ),
        // Top-left logo and title
        Positioned(
          top: 40,
          left: 16,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: const AssetImage('assets/appLogo.png'), // Replace with your logo asset
              ),
              const SizedBox(width: 8),
              const Text(
                "Snap",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        // Logout Button
        Positioned(
          top: 40,
          right: 16, // Adjust the position to the right
          child: IconButton(
            onPressed: () {
              _logoutUser(context); // Function to handle logout
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
              size: 28,
            ),
          ),
        ),
        // Bottom Sheet
        DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.directions_car,
                        color: Colors.green),
                    title: Text(
                      '${user.vehicleName} - ${user.vehicleNumber}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.red),
                    title: Text(
                      user.phoneNumber ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.badge, color: Colors.orange),
                    title: Text(
                      user.designation ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: Colors.black,
      onPressed: () {
        CustomBottomSheet.show(
          context: context,
          title: "New Report",
          description: "Please submit a report below",
          onConfirm: () {
            print("User confirmed from Bottom Sheet");
          },
        );
      },
      icon: const Icon(Icons.report, color: Colors.white),
      label: const Text(
        "Report",
        style: TextStyle(color: Colors.white),
      ),
    ),
    bottomNavigationBar: BottomNavBarFb2(),
  );
}

void _logoutUser(BuildContext context) {
  // Logic for logging out the user
  e.replace(context, Loginscreen());
  // Redirect to login screen or any other appropriate action
}

}
