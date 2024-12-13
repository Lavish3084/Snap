import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CustomBottomSheet {
  /// Displays a customizable bottom sheet with image picker and report submission
  static void show({
    required BuildContext context,
    required String title,
    required String description,
    required Function onConfirm, // Function to handle "I Agree" action
    List<Widget>? actions, // Optional additional actions
  }) {
    final ImagePicker _picker = ImagePicker();
    TextEditingController _titleController = TextEditingController(); // Controller for the title
    TextEditingController _descriptionController = TextEditingController(); // Controller for the description
    File? _image; // Variable to hold the selected image

    // State management for the radio buttons
    int? _selectedOption = 0; // Default selected option

    // Function to open the camera
    Future<void> _openCamera() async {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _image = File(image.path);
        print("Image path: ${image.path}");
      } else {
        print("No image selected");
      }
    }

    // Function to open the gallery
    Future<void> _openGallery() async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _image = File(image.path);
        print("Image path: ${image.path}");
      } else {
        print("No image selected");
      }
    }

    // Function to show a modal bottom sheet with the camera/gallery options
    Future<void> _showImageSourceDialog() async {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (BuildContext ctx) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take Photo'),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _openCamera();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Photo Library'),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _openGallery();
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true, // Make sure the sheet can be scrolled
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.9, // 90% height
              child: Stack(
                children: [
                  // Main content
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Texts
                        Center(
                          child: Column(
                            children: const [
                              Text(
                                "New Report",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Divider(thickness: 2),
                              Text(
                                "Please submit a report below",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Title TextField with character count
                        const Text(
                          "Report Details *",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Stack(
                          children: [
                            TextField(
                              controller: _titleController,
                              maxLength: 20, // Maximum length of 20
                              decoration: const InputDecoration(
                                hintText: 'Enter a title...',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 246, 246, 246),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Text(
                                "${_titleController.text.length}/20",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Description TextField with character count
                        const Text(
                          "Enter Description:",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Stack(
                          children: [
                            TextField(
                              controller: _descriptionController,
                              maxLength: 100, // Maximum length of 100
                              decoration: const InputDecoration(
                                hintText: 'Write a description...',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 246, 246, 246),
                              ),
                              maxLines: 4,
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Text(
                                "${_descriptionController.text.length}/100",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Image Picker Button
                        ElevatedButton(
                          onPressed: _showImageSourceDialog,
                          child: const Text(
                            "Choose File",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.black),
                          ),
                        ),

                        // Display selected image
                        _image != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Image.file(_image!),
                              )
                            : Container(),

                        const SizedBox(height: 20),

                        // Radio Options
                        const Text(
                          "Select Option:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            ListTile(
                              title: const Text('Option 1'),
                              leading: Radio<int>(
                                value: 0,
                                groupValue: _selectedOption,
                                onChanged: (int? value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  }
                                },
                                activeColor: Colors.black,
                              ),
                            ),
                            ListTile(
                              title: const Text('Option 2'),
                              leading: Radio<int>(
                                value: 1,
                                groupValue: _selectedOption,
                                onChanged: (int? value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  }
                                },
                                activeColor: Colors.black,
                              ),
                            ),
                            ListTile(
                              title: const Text('Option 3'),
                              leading: Radio<int>(
                                value: 2,
                                groupValue: _selectedOption,
                                onChanged: (int? value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  }
                                },
                                activeColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Submit and Clear Buttons
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _titleController.clear();
                          _descriptionController.clear();
                          _image = null;
                          _selectedOption = 0;
                        });
                      },
                      child: const Text(
                        "Clear",
                        style: TextStyle(
                          color: Colors.white, // Ensure the text color is white for visibility
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black), // Set background to black
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm();
                        print("Report Submitted");
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
