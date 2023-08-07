import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_manage_app/cubit/states.dart';
import 'package:med_manage_app/helper/dio_helper.dart';
import 'package:med_manage_app/models/department/add_department_model.dart';

import '../constant.dart';
import '../helper/end_points.dart';
import '../models/department/delete_department_model.dart';
import '../models/department/index_department_model.dart';
import '../models/department/update_department_model.dart';
import '../models/patient/delete_patient_model.dart';
import '../models/patient/index_patient_model.dart';
import '../models/patient/view_patient_model.dart';
import '../models/secretaria/delete_secretaria_model.dart';
import '../models/secretaria/index_secretaria_model.dart';
import '../models/secretaria/register_secretaria_model.dart';
import '../models/secretaria/update_secretaria_model.dart';
import '../models/secretaria/view_secretaria_model.dart';
import '../modules/department/department_screen.dart';
import '../modules/patients/patients_screen.dart';
import '../modules/secretaria/secretaria_screen.dart';
import '../modules/settings/settings_screen.dart';

class MedManageCubit extends Cubit<MedManageStates>
{

  MedManageCubit() : super(MedManageInitialState());

 static MedManageCubit get(context) =>BlocProvider.of(context);



 int currentIndex = 0;
 List<Widget> bottomScreens =
 [
   DepartmentScreen(),
   const PatientsScreen(),
   const SecretariaScreen(),
   SettingsScreen()
 ];

  List <BottomNavigationBarItem> items =
  [
    BottomNavigationBarItem(
      icon: Icon(Icons.home,
      size: 25.0,),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person,
      size: 25.0,),
      label: 'Patients',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.manage_accounts,
        size: 25.0,),
      label: 'Secretary',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings,
      size: 25.0,),
      label: 'Settings',
    ),
  ];

 void changeBottom(int index)
 {
   currentIndex = index;
   emit(MedManageChangeBottomNavState());
   if(index == 1)
   {
     indexPatientsList();
   }
   if(index == 2)
   {
     indexSecretariaList();
   }
 }

 IconData suffixIcon = Icons.visibility;
 bool isPassShow = false;

 void changePassVisibility(){
   isPassShow = !isPassShow;
   suffixIcon = isPassShow ? Icons.visibility_off : Icons.visibility;
   emit(MedManageChangePassVisibilityState());
 }

  late DepartmentHomeModel departmentHomeModel;
  void getHomeDepData()
  {
    emit(MedManageLoadHomeDepDataState());

    DioHelper.getData(
        url: INDEX_DEPARTMENT,
        token:'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMDc4NjFiOGM4MTViZTgwMDg5MDc3YjlhMWQxY2U4OGU5ODgyNTY5NjcyMjY3NWFkMWQyMDBjNWEyZWY4Mzk2ZDIzMDZlZmVhZWY5MWExZDciLCJpYXQiOjE2OTE0Mjk4MTQuNzkxMDc0LCJuYmYiOjE2OTE0Mjk4MTQuNzkxMDgsImV4cCI6MTcyMzA1MjIxNC41NDczOTMsInN1YiI6IjciLCJzY29wZXMiOltdfQ.Bjb42xZgQlkPX1PkiAxQXQNY70Hu-QU_68UZOadheT2huDaQFJYeo2ksh4Sh35XZnL7qbQhX1qyq6smzd7EFMcZ-thfR1FHmpxc_ADvQZDBcPAj1UKRqsR6o9L-AK6BUSylxdlC8anXDW7BtdAfSDhzH4CKUmQHZ3ZIbHRiaW3Ufu2qKjwqzG5kf-V6bFqXASnXqADNWpIcruHWMNJuE2LIPQbY8JPgksWPKU9IhgvIQB0xZC4gPOneCn3Jvyhzgqj8ZFqblOVLOQj09BEkZJ1C4E4ord4HDG2_-nyeGSlPr53dE3Al-_u_4-_cgtPYLsv4-rDwSYBFZywX1w5qj8WTger6UAmUfTJAU0egYQW-1OQh6X7dqU_pxkDLaUm5FbJcQe2wNckgYl6Fj5W-Ua3IN4_B32CS3dmb6_P1BDmefH5nfcQxLdsQ5weHum5ZfWc_1y6cEmneViK9m1KMbtueKNxPRmGhmc6Cv-AxG0rla88J7MckVoNu6oz40u8UJe9eOUbXrPXrimKdiIGBlrPOY7DvwJ5poDrAlNdnjjzoO4wHzgE5Rj48oFHYEZH_cEdLzJKOML_myIv5fTY5BagC7BvZ1xYc89V2P4OZgxG1D0AaIueoMwg3_-yZAm7lQo_GZ-_POtj_HYVljqWY1TvvSIy1FRKQznVVNFvDv8ZY',
    ).then((value)
    {
      departmentHomeModel = DepartmentHomeModel.fromJson(value.data);
      print(departmentHomeModel.Department![1].img);
      emit(MedManageSuccessHomeDepDataState());
    }
    ).catchError((error)
    {
      emit(MedManageErrorHomeDepDataState(error.toString()));
      print('err: ${error.toString()}');
    });

  }

  late AddDepartmentModel addDepartmentModel;
  void addDepartment({
    required String name,
    //required String img,
  })
  {
    DioHelper.postData(
        url: ADD_DEPARTMENT,
        token:'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMDc4NjFiOGM4MTViZTgwMDg5MDc3YjlhMWQxY2U4OGU5ODgyNTY5NjcyMjY3NWFkMWQyMDBjNWEyZWY4Mzk2ZDIzMDZlZmVhZWY5MWExZDciLCJpYXQiOjE2OTE0Mjk4MTQuNzkxMDc0LCJuYmYiOjE2OTE0Mjk4MTQuNzkxMDgsImV4cCI6MTcyMzA1MjIxNC41NDczOTMsInN1YiI6IjciLCJzY29wZXMiOltdfQ.Bjb42xZgQlkPX1PkiAxQXQNY70Hu-QU_68UZOadheT2huDaQFJYeo2ksh4Sh35XZnL7qbQhX1qyq6smzd7EFMcZ-thfR1FHmpxc_ADvQZDBcPAj1UKRqsR6o9L-AK6BUSylxdlC8anXDW7BtdAfSDhzH4CKUmQHZ3ZIbHRiaW3Ufu2qKjwqzG5kf-V6bFqXASnXqADNWpIcruHWMNJuE2LIPQbY8JPgksWPKU9IhgvIQB0xZC4gPOneCn3Jvyhzgqj8ZFqblOVLOQj09BEkZJ1C4E4ord4HDG2_-nyeGSlPr53dE3Al-_u_4-_cgtPYLsv4-rDwSYBFZywX1w5qj8WTger6UAmUfTJAU0egYQW-1OQh6X7dqU_pxkDLaUm5FbJcQe2wNckgYl6Fj5W-Ua3IN4_B32CS3dmb6_P1BDmefH5nfcQxLdsQ5weHum5ZfWc_1y6cEmneViK9m1KMbtueKNxPRmGhmc6Cv-AxG0rla88J7MckVoNu6oz40u8UJe9eOUbXrPXrimKdiIGBlrPOY7DvwJ5poDrAlNdnjjzoO4wHzgE5Rj48oFHYEZH_cEdLzJKOML_myIv5fTY5BagC7BvZ1xYc89V2P4OZgxG1D0AaIueoMwg3_-yZAm7lQo_GZ-_POtj_HYVljqWY1TvvSIy1FRKQznVVNFvDv8ZY',
        data:
    {
      'name':name,
      //'img':img,
    }
    ).then((value)
    {

      addDepartmentModel = AddDepartmentModel.fromJson(value.data);
      emit(MedManageAddDepartmentSuccessState());
    }).catchError((error)
    {
      emit(MedManageAddDepartmentErrorState());
    });

  }
  late DeleteDepartmentModel deleteDepartmentModel;
  void deleteDepartment({
    required int id,
  })
  {
    DioHelper.postData(
        url: DELETE_DEPARTMENT,
        token:'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMDc4NjFiOGM4MTViZTgwMDg5MDc3YjlhMWQxY2U4OGU5ODgyNTY5NjcyMjY3NWFkMWQyMDBjNWEyZWY4Mzk2ZDIzMDZlZmVhZWY5MWExZDciLCJpYXQiOjE2OTE0Mjk4MTQuNzkxMDc0LCJuYmYiOjE2OTE0Mjk4MTQuNzkxMDgsImV4cCI6MTcyMzA1MjIxNC41NDczOTMsInN1YiI6IjciLCJzY29wZXMiOltdfQ.Bjb42xZgQlkPX1PkiAxQXQNY70Hu-QU_68UZOadheT2huDaQFJYeo2ksh4Sh35XZnL7qbQhX1qyq6smzd7EFMcZ-thfR1FHmpxc_ADvQZDBcPAj1UKRqsR6o9L-AK6BUSylxdlC8anXDW7BtdAfSDhzH4CKUmQHZ3ZIbHRiaW3Ufu2qKjwqzG5kf-V6bFqXASnXqADNWpIcruHWMNJuE2LIPQbY8JPgksWPKU9IhgvIQB0xZC4gPOneCn3Jvyhzgqj8ZFqblOVLOQj09BEkZJ1C4E4ord4HDG2_-nyeGSlPr53dE3Al-_u_4-_cgtPYLsv4-rDwSYBFZywX1w5qj8WTger6UAmUfTJAU0egYQW-1OQh6X7dqU_pxkDLaUm5FbJcQe2wNckgYl6Fj5W-Ua3IN4_B32CS3dmb6_P1BDmefH5nfcQxLdsQ5weHum5ZfWc_1y6cEmneViK9m1KMbtueKNxPRmGhmc6Cv-AxG0rla88J7MckVoNu6oz40u8UJe9eOUbXrPXrimKdiIGBlrPOY7DvwJ5poDrAlNdnjjzoO4wHzgE5Rj48oFHYEZH_cEdLzJKOML_myIv5fTY5BagC7BvZ1xYc89V2P4OZgxG1D0AaIueoMwg3_-yZAm7lQo_GZ-_POtj_HYVljqWY1TvvSIy1FRKQznVVNFvDv8ZY',
        data:
        {
          'id':id,
        }
    ).then((value)
    {
      deleteDepartmentModel = DeleteDepartmentModel.fromJson(value.data);
      emit(MedManageDeleteDepartmentSuccessState());
      getHomeDepData();
    }).catchError((error)
    {
      emit(MedManageDeleteDepartmentErrorState());
    });

  }

  void updateDepartment({
    required int id,
    required String name,
  })
  {
    DioHelper.postData(
        url: UPDATE_DEPARTMENT,
        token:'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMDc4NjFiOGM4MTViZTgwMDg5MDc3YjlhMWQxY2U4OGU5ODgyNTY5NjcyMjY3NWFkMWQyMDBjNWEyZWY4Mzk2ZDIzMDZlZmVhZWY5MWExZDciLCJpYXQiOjE2OTE0Mjk4MTQuNzkxMDc0LCJuYmYiOjE2OTE0Mjk4MTQuNzkxMDgsImV4cCI6MTcyMzA1MjIxNC41NDczOTMsInN1YiI6IjciLCJzY29wZXMiOltdfQ.Bjb42xZgQlkPX1PkiAxQXQNY70Hu-QU_68UZOadheT2huDaQFJYeo2ksh4Sh35XZnL7qbQhX1qyq6smzd7EFMcZ-thfR1FHmpxc_ADvQZDBcPAj1UKRqsR6o9L-AK6BUSylxdlC8anXDW7BtdAfSDhzH4CKUmQHZ3ZIbHRiaW3Ufu2qKjwqzG5kf-V6bFqXASnXqADNWpIcruHWMNJuE2LIPQbY8JPgksWPKU9IhgvIQB0xZC4gPOneCn3Jvyhzgqj8ZFqblOVLOQj09BEkZJ1C4E4ord4HDG2_-nyeGSlPr53dE3Al-_u_4-_cgtPYLsv4-rDwSYBFZywX1w5qj8WTger6UAmUfTJAU0egYQW-1OQh6X7dqU_pxkDLaUm5FbJcQe2wNckgYl6Fj5W-Ua3IN4_B32CS3dmb6_P1BDmefH5nfcQxLdsQ5weHum5ZfWc_1y6cEmneViK9m1KMbtueKNxPRmGhmc6Cv-AxG0rla88J7MckVoNu6oz40u8UJe9eOUbXrPXrimKdiIGBlrPOY7DvwJ5poDrAlNdnjjzoO4wHzgE5Rj48oFHYEZH_cEdLzJKOML_myIv5fTY5BagC7BvZ1xYc89V2P4OZgxG1D0AaIueoMwg3_-yZAm7lQo_GZ-_POtj_HYVljqWY1TvvSIy1FRKQznVVNFvDv8ZY',
        data:
    {
      'id': id,
      'name':name,
    }
    ).then((value)
    {
      departmentHomeModel = DepartmentHomeModel.fromJson(value.data);
      emit(MedManageUpdateDepartmentSuccessState());
      getHomeDepData();
    }).catchError((error)
    {
      emit(MedManageUpdateDepartmentErrorState());
    });

  }

  File? departmentImage;
  final picker = ImagePicker();

  Future<void> getImage() async
  {
    final pickedFile= await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      departmentImage =File(pickedFile.path);
      emit(MedManageDepImagePickedSuccessState());
    }else
    {
      print('no image selected.');
      emit(MedManageDepImagePickedErrorState());
    }
    //uploadImage(departmentImage!);
  }



  //Secritary AND Patient*********************************************************************************************************************

  late IndexSecretariaModel indexSecretariaModel;

  void indexSecretariaList()
  {
    emit(MedManageLoadingSecretariaListState());
    DioHelperG.getDataG(
        url: 'indexSecretary',
        query: null,
        token: tokenG
    ).then((value) {
      indexSecretariaModel = IndexSecretariaModel.fromJson(value.data);
      print(value.toString());
      print(indexSecretariaModel.message);
      print(indexSecretariaModel.secretary[0].user.firstName);
      emit(MedManageSuccssesSecretariaListState());
    }).catchError((error){
      print(error.toString());
      emit(MedManageErrorSecretariaListState());
    });
  }

  late DeleteSecretariaModel deleteSecretariaModel;

  void deleteSecretaria({
    required int user_id,
  })
  {
    emit(MedManageLoadingSecretariaProfDeleteState());
    DioHelperG.postDataG(
      url: 'deleteSecretary',
      data: {
        'user_id': user_id,
      },
      token: tokenG,
    ).then((value) {
      deleteSecretariaModel = DeleteSecretariaModel.fromJson(value.data);
      print(value.data);
      print(deleteSecretariaModel.success);
      print(deleteSecretariaModel.message);
      emit(MedManageSuccssesSecretariaProfDeleteState());
      indexSecretariaList();
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorSecretariaProfDeleteState());
    });
  }

  late ViewSecretariaModel viewSecretariaModel;

  void viewSecretaria({
    required int user_id,
  })
  {
    emit(MedManageLoadingSecretariaProfState());
    DioHelperG.postDataG(
        url: 'viewSecretary',
        data: {
          'user_id': user_id,
        },
        token: tokenG
    ).then((value) {
      print(value.data);
      viewSecretariaModel = ViewSecretariaModel.fromJson(value.data);
      //print(viewSecretariaModel.secretary?.departmentId);
      //print(viewSecretariaModel.secretary?.user.firstName);
      emit(MedManageSuccssesSecretariaProfState());
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorSecretariaProfState());
    });
  }

  late UpdateSecretariaModel updateSecretariaModel;

  void updateSecretaria({
    required String? first_name,
    required String? last_name,
    required String? department_name,
    required String? phone_num,
    required int user_id,
  })
  {
    emit(MedManageLoadingSecretariaProfState());
    DioHelperG.postDataG(
        url: 'updateSecretary',
        data: {
          'first_name': first_name,
          'last_name': last_name,
          'department_name': department_name,
          'phone_num': phone_num,
          'user_id': user_id,
        },
        token: tokenG
    ).then((value) {
      //print(value.data);
     // print(value.data['message']);
      updateSecretariaModel = UpdateSecretariaModel.fromJson(value.data);
      print(updateSecretariaModel.success);
      emit(MedManageSuccssesSecretariaProfEditState());
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorSecretariaProfEditState());
    });
  }

  late RegisterSecretariaModel registerSecretariaModel;

  void registerSecretaria({
    required String first_name,
    required String last_name,
    required String phone_num,
    required String email,
    required String password,
    required String department_name,
  })
  {
    emit(MedManageLoadingSecretariaRegisterState());
    DioHelperG.postDataG(
        url: 'registerSecretary',
        data: {
          'first_name': first_name,
          'last_name': last_name,
          'phone_num': phone_num,
          'email': email,
          'password': password,
          'department_name': department_name,
        },
        token: tokenG
    ).then((value) {
      print(value.data);
      registerSecretariaModel = RegisterSecretariaModel.fromJson(value.data);
      // print(value.toString());
      // print(registerSecretariaModel.token);
     // print(registerSecretariaModel.role);
      emit(MedManageSuccssesSecretariaRegisterState());
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorSecretariaRegisterState());
    });
  }

  late IndexPatientModel indexPatientModel;

  void indexPatientsList()
  {
    emit(MedManageLoadingPatientsListState());
    DioHelperG.getDataG(
        url: 'indexPatient',
        query: null,
        token: tokenG
    ).then((value) {
      indexPatientModel = IndexPatientModel.fromJson(value.data);
      //print(value.toString());
      //print(indexPatientModel.patient[0].user.firstName);
      emit(MedManageSuccssesPatientsListState());
    }).catchError((error){
      print(error.toString());
      emit(MedManageErrorPatientsListState());
    });
  }

  late DeletePatientModel deletePatientModel;

  void deletePatient({
    required int user_id,
  })
  {
    emit(MedManageLoadingPatientsDeleteState());
    DioHelperG.postDataG(
      url: 'deletePatient',
      data: {
        'user_id': user_id,
      },
      token: tokenG,
    ).then((value) {
      deletePatientModel = DeletePatientModel.fromJson(value.data);
     // print(value.data);
     // print(deletePatientModel.success);
      // print(deletePatientModel.message);
      emit(MedManageSuccssesPatientsDeleteState());
      indexPatientsList();
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorPatientsDeleteState());
    });
  }

  late ViewPatientModel viewPatientModel;

  void viewPatient({
    required int user_id,
  })
  {
    emit(MedManageLoadingPatientsProfState());
    DioHelperG.postDataG(
        url: 'viewPatient',
        data: {
          'user_id': user_id,
        },
        token: tokenG
    ).then((value) {
      print(value.data);
      viewPatientModel = ViewPatientModel.fromJson(value.data);
     // print(viewPatientModel.message);
     // print(viewPatientModel.patient.user.firstName);
      emit(MedManageSuccssesPatientsProfState());
    }).catchError((error) {
      print(error.toString());
      emit(MedManageErrorPatientsProfState());
    });
  }

/*
  bool isDark = false;
   void changeMode({ bool? fromShared})
    {
      if(fromShared != null)
      {
        isDark = fromShared;//true
        emit(MedManageChangeModeState());
      } else
      {
        isDark = !isDark;
        CacheHelper.putBoolean(
            key: 'isDark',
            value: isDark).
        then((value)
        {
          emit(MedManageChangeModeState());
        });
      }


    }
*/


}
