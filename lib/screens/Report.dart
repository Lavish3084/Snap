import 'package:flutter/material.dart';
import 'package:snap/screens/BottomNavBarFb2.dart';

class LocationDetailsWithNotes extends StatelessWidget {
  final String? locationName;
  final String? latitude;
  final String? longitude;
  final String? siteNotes;
  final Widget? actionButton; // Customizable button or action widget

  const LocationDetailsWithNotes({
    Key? key,
    this.locationName,
    this.latitude,
    this.longitude,
    this.siteNotes,
    this.actionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(235, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            // Location Details Section
            Text(
              "Location Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.blue),
                          Text(
                            locationName ?? "Location Name Not Available",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Lat: ${latitude ?? 'N/A'}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "Lon: ${longitude ?? 'N/A'}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Site Notes Section
            Card(
              color: const Color.fromARGB( 255, 246, 246, 246 ),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Site Notes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Divider(),
            const SizedBox(height: 8),
            Text(
              siteNotes ?? "No additional site notes provided.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Optional Action Button
            if (actionButton != null) actionButton!,
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarFb2(),
    );
  }
}
