import 'package:flutter/material.dart';
import 'package:flutter_first_app/components/course_page.dart';
import 'package:http/http.dart' as http;
import '../forms/course_form.dart';

class CourseCreate extends StatefulWidget {
  const CourseCreate({super.key});
  @override
  State<CourseCreate> createState() => _CourseCreateState();
}

class _CourseCreateState extends State<CourseCreate> {
  // properties
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Course"),
      ),
      body: Center(
        child: Column(
          children: [
            CourseForm(
              formKey: formKey,
              nameCtrl: nameCtrl,
              priceCtrl: priceCtrl,
              descriptionCtrl: descriptionCtrl,
            ),
            ElevatedButton(
              onPressed: () {
                // perintah untuk proses menyimpan data
                if (formKey.currentState!.validate()) {
                  createCourse(context);
                  // snackbar atau alert
                  // redirect kembali ke halaman course page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CoursePage(),
                    ),
                  );
                }
              },
              child: const Text("Create Course"),
            ),
          ],
        ),
      ),
    );
  }

  Future createCourse(BuildContext context) async {
    String url = "http://localhost/flutter-api/api/createCourse.php";
    return await http.post(Uri.parse(url), body: {
      "name": nameCtrl.text,
      "price": priceCtrl.text,
      "description": descriptionCtrl.text,
    });
  }
}
