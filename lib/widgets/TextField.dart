import 'package:flutter/material.dart';
import 'package:snap/colorTheme.dart';
import 'package:snap/essentials.dart';

class EmailInputFb2 extends StatefulWidget {
  final TextEditingController inputController;
  final String title, hintText;
  double height;
  var suffixIcon, maxLines, keyboardType, onTap, onChanged, borderColor;
  var floatingLabelBehaviour;
  var focusNode, fontHeight;
  bool readOnly = false, password;

  EmailInputFb2({
    Key? key,
    this.focusNode,
    this.floatingLabelBehaviour = FloatingLabelBehavior.auto,
    this.fontHeight = 2.2,
    required this.inputController,
    this.borderColor = AppColors.grey,
    this.onChanged,
    this.onTap,
    this.suffixIcon,
    required this.title,
    this.password = false,
    this.readOnly = false,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.emailAddress,
    this.height = 55,
  }) : super(key: key);

  @override
  _EmailInputFb2State createState() => _EmailInputFb2State();
}

class _EmailInputFb2State extends State<EmailInputFb2> {
  bool _obscurePassword = false;

  @override
  Widget build(BuildContext context) {
    if (widget.keyboardType == TextInputType.multiline)
      widget.floatingLabelBehaviour = FloatingLabelBehavior.always;

    const primaryColor = Color.fromARGB(255, 176, 176, 176);
    const accentColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 6, bottom: 6),
          height: widget.height,
          child: TextField(
            // ... (other properties remain the same)
            decoration: InputDecoration(
              label: Text(
                widget.title,
                style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)), // Light gray color for label
              ),
              floatingLabelBehavior: widget.floatingLabelBehaviour,
              prefixIcon: widget.suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        widget.suffixIcon,
                        color: Colors.white, // Light gray color for prefix icon
                      ),
                    )
                  : null,
              suffixIcon: widget.password
                  ? IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white, // Light gray color for suffix icon
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: const Color.fromARGB(255, 66, 66, 66), // White color for the text field background
              hintText: widget.hintText,
              hintStyle: TextStyle(height: widget.fontHeight, color: Color(0xFFB0B0B0).withOpacity(.75)), // Light gray color for hint text
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0), // Light gray color for border
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0), // Light gray color for focused border
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFEF4444), width: 1.0), // Red color for error border
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0), // Light gray color for enabled border
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        ],
    );
  }
}
