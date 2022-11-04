import 'package:flutter/material.dart';
import '../models/employee_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as converter;

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  String url = "http://localhost:3000/employees";
  List<EmployeeModel> employeeList = []; // diawal masih kosong
  List<EmployeeModel> searchEmployeeList = []; // diawal masih kosong

  // memanggil data dari API
  Future<List<EmployeeModel>> getEmployeeList() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        debugPrint(response.body);
        List<EmployeeModel> employees = parsingJson(response.body);
        return employees;
      } else {
        throw Exception("Error while getting data...");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<EmployeeModel> parsingJson(String body) {
    final parsedJson = converter.json.decode(body).cast<Map<String, dynamic>>();
    return parsedJson
        .map<EmployeeModel>((json) => EmployeeModel.fromJson(json))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    getEmployeeList().then((value) {
      setState(() {
        searchEmployeeList = value;
        employeeList = searchEmployeeList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nested JSON"),
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
                    employeeList = searchEmployeeList
                        .where(
                          (element) =>
                              (element.name!.toLowerCase().contains(
                                    keyword.toLowerCase(),
                                  )) ||
                              (element.department![0].name!
                                  .toLowerCase()
                                  .contains(
                                    keyword.toLowerCase(),
                                  )) ||
                              (element.department![0].manager![0].name!
                                  .toLowerCase()
                                  .contains(
                                    keyword.toLowerCase(),
                                  )) ||
                              (element.address![0].street!
                                  .toLowerCase()
                                  .contains(
                                    keyword.toLowerCase(),
                                  )) ||
                              (element.address![0].city!.toLowerCase().contains(
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
                itemCount: employeeList.length,
                itemBuilder: (context, position) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.numbers),
                      title: Text(
                        employeeList[position].name.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        "Dept: ${employeeList[position].department![0].name}\nManager: ${employeeList[position].department![0].manager![0].name}\nAddress: ${employeeList[position].address![0].city}",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
