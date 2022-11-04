// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_first_app/components/course_edit.dart';
import 'package:flutter_first_app/components/course_page.dart';
import '../models/course_model.dart';
import 'package:http/http.dart' as http;

class CourseDetailPage extends StatefulWidget {
  // constructor
  final Course courseModel;
  const CourseDetailPage({super.key, required this.courseModel});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  void deleteCourse(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Are you sure to delete?"),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Icon(Icons.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                // proses menghapus data
                confirmDelete(context);
              },
              child: const Icon(Icons.check),
            ),
          ],
        );
      },
    );
  }

  void confirmDelete(BuildContext context) async {
    String url = "http://localhost/flutter-api/api/deleteCourse.php";
    await http.post(
      Uri.parse(url),
      body: {
        "id": widget.courseModel.id.toString(),
      },
    );
    // redirect ke CoursePage
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CoursePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // membuka form untuk ubah data
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CourseEdit(courseModel: widget.courseModel),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Detail Course ID: ${widget.courseModel.id}"),
        actions: [
          IconButton(
            onPressed: () {
              deleteCourse(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
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
