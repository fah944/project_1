class ViewSecretariaModel
{
  late bool success;
  late String message;
  late SecretariaModel? secretary;

  ViewSecretariaModel({
    required this.success,
    required this.message,
    required this.secretary,
  });

  ViewSecretariaModel.fromJson(Map<String,dynamic>jsonData){
    success = jsonData['success'];
    message = jsonData['message'];
    secretary = jsonData['secretary'] != null ? SecretariaModel.fromJson(jsonData['secretary']) : null;
  }
}

class SecretariaModel
{
  late int id;
  late int user_id;
  late int department_id;
  late UserModel user;

  SecretariaModel({
    required this.id,
    required this.user_id,
    required this.department_id,
    required this.user,
  });

  SecretariaModel.fromJson(Map<String,dynamic> jsonData){
    id = jsonData['id'];
    user_id = jsonData['user_id'];
    department_id = jsonData['department_id'];
    user = UserModel.fromJson(jsonData['user']);
  }
}

class UserModel
{
  late String first_name;
  late String last_name;
  late String phone_num;
  late String email;

  UserModel({
    required this.first_name,
    required this.last_name,
    required this.phone_num,
    required this.email,
  });

  UserModel.fromJson(Map<String,dynamic> jsonData){
    first_name = jsonData['first_name'];
    last_name = jsonData['last_name'];
    phone_num = jsonData['phone_num'];
    email = jsonData['email'];
  }
}