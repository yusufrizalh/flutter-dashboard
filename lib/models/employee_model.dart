class EmployeeModel {
  int? id;
  String? name;
  int? age;
  int? salary;
  List<Department>? department;
  List<Address>? address;

  EmployeeModel({
    this.id,
    this.name,
    this.age,
    this.salary,
    this.department,
    this.address,
  });

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    salary = json['salary'];
    if (json['department'] != null) {
      department = <Department>[];
      json['department'].forEach((v) {
        department!.add(Department.fromJson(v));
      });
    }
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['salary'] = salary;
    if (department != null) {
      data['department'] = department!.map((v) => v.toJson()).toList();
    }
    if (address != null) {
      data['address'] = address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Department {
  int? id;
  String? name;
  List<Manager>? manager;

  Department({this.id, this.name, this.manager});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['manager'] != null) {
      manager = <Manager>[];
      json['manager'].forEach((v) {
        manager!.add(Manager.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (manager != null) {
      data['manager'] = manager!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Manager {
  int? id;
  String? name;

  Manager({this.id, this.name});

  Manager.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Address {
  String? street;
  String? city;
  String? postal;

  Address({this.street, this.city, this.postal});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    postal = json['postal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['postal'] = postal;
    return data;
  }
}
