class DepartmentHomeModel
{
  String? success;
  String? message;
  DepHomeModelData? dataOfDepartment;

  DepartmentHomeModel.fromJson(Map<String,dynamic> json)
  {

    success = json['success'];
    message = json['message'];
    dataOfDepartment = DepHomeModelData.fromJson(json['Department']);

  }

}
class DepHomeModelData
{
 List<DepartmentModel> department=[];

 DepHomeModelData.fromJson(Map<String,dynamic> json)
 {
   json['Department'].forEach((element)
   {
     department.add(element);
   });
 }
}

class DepartmentModel
{
  late int id;
  late String name;
  late String image;
  late String createdAt;
  late String updatedAt;

  DepartmentModel.fromJson(Map<String,dynamic> json)
  {

    id = json['id'];
    name = json['name'];
    image = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];


  }

}