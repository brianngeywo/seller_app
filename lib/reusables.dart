import 'package:flutter/material.dart';

class CustomSubmitMaterialButton extends StatelessWidget {
  final Function onpressed;
  final String actionText;
  const CustomSubmitMaterialButton({
    super.key, required this.onpressed, required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.blue.shade900,
        onPressed: () => onpressed(),
        child: Text(actionText, style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController _controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();

  const CustomTextField({super.key,
    required this.labelText,
    required TextEditingController controller,
  }) : _controller = controller;
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: widget._controller,
          decoration: InputDecoration(labelText: widget.labelText, border: InputBorder.none),
        ),
      ),
    );
  }
}

