import 'package:flutter/material.dart';

class CourseForm extends StatefulWidget {
  // properties
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameCtrl;
  late TextEditingController priceCtrl;
  late TextEditingController descriptionCtrl;

  // constructor
  CourseForm({
    super.key,
    required this.formKey,
    required this.nameCtrl,
    required this.priceCtrl,
    required this.descriptionCtrl,
  });

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: widget.nameCtrl,
            decoration: const InputDecoration(labelText: "Enter course name"),
            keyboardType: TextInputType.text,
          ),
          TextFormField(
            controller: widget.priceCtrl,
            decoration: const InputDecoration(labelText: "Enter course price"),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: widget.descriptionCtrl,
            decoration: const InputDecoration(labelText: "Description"),
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
