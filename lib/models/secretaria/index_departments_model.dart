class IndexDepartmentModel {
  IndexDepartmentModel({
    required this.success,
    required this.message,
    required this.department,
  });
  late final bool success;
  late final String message;
  late final List<DepartmentModel> department;

  IndexDepartmentModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    message = json['message'];
    department = List.from(json['Department']).map((e)=>DepartmentModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['Department'] = department.map((e)=>e.toJson()).toList();
    return data;
  }
}

class DepartmentModel {
  DepartmentModel({
    required this.id,
    required this.name,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String img;
  late final String createdAt;
  late final String updatedAt;

  DepartmentModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}