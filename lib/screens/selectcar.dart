import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:snap/essentials.dart';
import 'package:snap/screens/homeScreen.dart';
import 'package:snap/screens/loadingScreen.dart';
import 'package:snap/screens/selectcar.dart';
import 'package:snap/services/AuthService.dart';
import 'package:snap/widgets/TextField.dart';
import 'package:snap/widgets/snackbar.dart';

class SelectCar extends StatefulWidget {
  const SelectCar({super.key});

  @override
  State<SelectCar> createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  String carDropdownValue = 'Select Car'; // Car dropdown value
  String licenseDropdownValue = 'Select License Plate'; // License plate dropdown value
  List<String> licensePlateOptions = ['Select License Plate']; // Dynamic license plate options

  // Map of cars to their corresponding license plates
  final Map<String, List<String>> carToLicensePlates = {
    'Scorpio': ['ABC1234', 'DEF5678', 'GHI9012'],
    'Thar': ['XYZ1111', 'UVW2222', 'RST3333'],
    'Safari': ['JKL4444', 'MNO5555', 'PQR6666'],
  };

  void updateLicensePlates(String selectedCar) {
    setState(() {
      licensePlateOptions = carToLicensePlates[selectedCar] ?? ['Select License Plate'];
      licenseDropdownValue = licensePlateOptions.first; // Reset to the first valid option
    });
  }

  void _navigateToHomeScreen() {
    if (carDropdownValue != 'Select Car' && licenseDropdownValue != 'Select License Plate') {
      // Perform navigation logic
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Navigating with $carDropdownValue and $licenseDropdownValue')),
      );*/
    e.replace(context, Homescreen());
    } else {
      // Show an alert or message if either dropdown is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both a car and a license plate')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Car',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Car Selection Dropdown
            DropdownContainer(
              dropdownValue: carDropdownValue,
              items: ['Select Car', ...carToLicensePlates.keys],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    carDropdownValue = newValue;
                  });
                  updateLicensePlates(newValue);
                }
              },
            ),
            const SizedBox(height: 15), // Spacer between dropdowns

            // License Plate Selection Dropdown
            DropdownContainer(
              dropdownValue: licenseDropdownValue,
              items: licensePlateOptions,
              onChanged: (String? newValue) {
                setState(() {
                  licenseDropdownValue = newValue ?? 'Select License Plate';
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: _navigateToHomeScreen, // Navigate on button press
        child: const Icon(Icons.arrow_forward,
        color: Colors.white,),
        tooltip: 'Go to Home',
      ),
      
    );
  }
}

// Reusable dropdown container widget
class DropdownContainer extends StatelessWidget {
  final String dropdownValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const DropdownContainer({
    required this.dropdownValue,
    required this.items,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 400,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1),
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(255, 231, 231, 231),
      ),
      child: DropdownButtonHideUnderline(
        child: Center(
          child: DropdownButton<String>(
            value: dropdownValue, // Current selected value
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            dropdownColor: Colors.white,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
