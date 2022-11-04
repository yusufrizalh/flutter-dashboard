import 'package:flutter/material.dart';
import 'package:flutter_first_app/components/course_page.dart';
import '../models/course_model.dart';
import 'package:http/http.dart' as http;
import '../forms/course_form.dart';

class CourseEdit extends StatefulWidget {
  final Course courseModel;
  const CourseEdit({super.key, required this.courseModel});

  @override
  State<CourseEdit> createState() => _CourseEditState();
}

class _CourseEditState extends State<CourseEdit> {
// properties
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.courseModel.name.toString());
    priceCtrl =
        TextEditingController(text: widget.courseModel.price.toString());
    descriptionCtrl =
        TextEditingController(text: widget.courseModel.description.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Course"),
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
                // perintah untuk proses mengubah data
                if (formKey.currentState!.validate()) {
                  updateCourse(context);
                  // snackbar atau alert
                  // redirect kembali ke halaman course page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CoursePage(),
                    ),
                  );
                }
              },
              child: const Text("Update Course"),
            ),
          ],
        ),
      ),
    );
  }

  Future updateCourse(BuildContext context) async {
    String url = "http://localhost/flutter-api/api/updateCourse.php";
    return await http.post(
      Uri.parse(url),
      body: {
        "name": nameCtrl.text,
        "price": priceCtrl.text,
        "description": descriptionCtrl.text,
        "id": widget.courseModel.id.toString(),
      },
    );
  }
}
