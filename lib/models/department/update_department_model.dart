/*"success": true,
"message": "Department updated successfully.",
"Department": {
"id": 3,
"name": "public",
"created_at": "2023-07-04T20:19:34.000000Z",
"updated_at": "2023-07-06T09:20:50.000000Z"
}*/

class UpdateDepartmentModel
{
late bool success;
late String message;
late DepartmentData Department;


UpdateDepartmentModel.fromJson(Map<String,dynamic> json)
{
success = json['success'];
message = json['message'];
Department = (json['Department'] != null ? DepartmentData.fromJson(json['Department']): null)!;

}



}

class DepartmentData
{
int? id;
String? name;
String? created_at;
String ?updated_at;

DepartmentData({
this.id,
this.name,
this.created_at,
this.updated_at,
});

//named
DepartmentData.fromJson(Map <String,dynamic> json)
{
id = json['id'];
name = json['name'];
created_at = json['created_at'];
updated_at = json['updated_at'];
}
}