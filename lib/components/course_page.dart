import 'package:flutter/material.dart';
import 'package:flutter_first_app/components/course_create.dart';
import 'package:flutter_first_app/components/course_detail_page.dart';
import '../models/course_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converter;

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String url = "http://localhost/flutter-api/api/getAllCourses.php";
  List<Course> courseList = []; // diawal masih kosong
  List<Course> searchCourseList = []; // diawal masih kosong

  // memanggil data dari API
  Future<List<Course>> getCourseList() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        debugPrint(response.body);
        List<Course> courses = parsingJson(response.body);
        return courses;
      } else {
        throw Exception("Error while getting data...");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<Course> parsingJson(String body) {
    final parsedJson = converter.json.decode(body).cast<Map<String, dynamic>>();
    return parsedJson.map<Course>((json) => Course.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    getCourseList().then((value) {
      setState(() {
        searchCourseList = value;
        courseList = searchCourseList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // filter data
            Container(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (keyword) {
                  // perintah untuk filter data
                  setState(() {
                    courseList = searchCourseList
                        .where(
                          (element) => (element.name.toLowerCase().contains(
                                keyword.toLowerCase(),
                              )),
                        )
                        .toList();
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(6.0),
                itemCount: courseList.length,
                itemBuilder: (context, position) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.list),
                      title: Text(courseList[position].name.toString()),
                      subtitle: Text(
                        courseList[position].price.toString(),
                      ),
                      onTap: () {
                        // membuka halaman detail course
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailPage(
                              courseModel: courseList[position],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CourseCreate(),
        )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
