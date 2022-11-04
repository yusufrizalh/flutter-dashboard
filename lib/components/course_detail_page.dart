import 'package:flutter/material.dart';
import '../models/course_model.dart';

class CourseDetailPage extends StatefulWidget {
  // constructor
  final Course courseModel;
  const CourseDetailPage({super.key, required this.courseModel});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Detail Course ID: ${widget.courseModel.id}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Course Name: ${widget.courseModel.name}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Course Price: ${widget.courseModel.price}"),
            Text("Description: ${widget.courseModel.description}"),
            Text("Created at: ${widget.courseModel.createdAt}"),
          ],
        ),
      ),
    );
  }
}
