import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'BottomNavBarFb2.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  // Example latitude and longitude (update with actual location)
  final double latitude = 37.4219999;
  final double longitude = -122.0840575;

  // Function to launch Google Maps with the coordinates
  Future<void> _launchGoogleMaps() async {
    final String googleMapsUrl = 'https://maps.google.com/?q=$latitude,$longitude';

    // Checking if the URL can be launched
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      // Showing an error message if the URL can't be launched
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open Google Maps.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Location',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Longitude: $longitude',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Latitude: $latitude',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
  onPressed: _launchGoogleMaps,  // Call function on button press
  child: const Text('Open in Google Maps',
  style: TextStyle(color: Colors.white),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,  // Set the button color to black
  ),
)

          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarFb2(),
    );
  }
}
