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
        token:'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNjhmNWQ2NTE5OGQ5YWRiMTkzYWEzNWUwNGNmMDhkYzg5MjYzYWJiYmFmNThiYTQ2ZmY4MzIwYTA2ODQyNDFhMjFmZGI4NjNkZjYzNGRjZGIiLCJpYXQiOjE2OTA1MTA1MDEuNTY3MzAyLCJuYmYiOjE2OTA1MTA1MDEuNTY3MzEyLCJleHAiOjE3MjIxMzI5MDEuNTQwMzk4LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.Wdfou0Q6gbbC8cEGG17RGVRRgvp8_pEFPAnCBTPtWtVwjqf8IhZdg-bxi1NsSUVchaAISNcDvZLwKEu3qINSBltojP-CNRMBNxkyAfzHn_LPA0G3OHrEn463fJ0uoAamzE21p5MxzrTpUTfVO_fcomN1a6HgkK1VIXpQ7xSixz2z2HLeCsWzqzAlIhoHrQyPsiwkhfUyZ0bchmMEOD5XWbBpvUl2pKB4wP15s8PKoMdRiE_AYx9PQfmU_0zI-Q3TX96z7eDe41Twb-bLAQeFYvwyOcEp29Bg9DDsTBp93xMsJFAn4_4wp74Mr-fLT2SiijvIAD5tJ6i46fS46VHW7iudn674r-ospXKFFYMDZQH-xOzdfX3lS3Fffae8hyap3sG_TnYxd_fZx34ZDGrqVL3pfAT4BtDl-J-682XhLRpTAktjFIeEFOBjHGJIBA8zcaGc3Stif_IueN2fBhcl5NER0fLMM4zQQEyN5PEMbWgWGUQYbRYFmCl4CWi4PPMZQB-F5WKauJa_rV82BXSlse9At-1JuEYiOH6dyPRrtFALokCM7ULte3dHvslIX7WXbId-i1KgzSuG-5-WGuTZKlKcY1uHr4hTIACjmzpsT9XThvL6Dyk2mOJ9Y7tePxd0wv6HWcxTtzvsJtMfovaHSEjnypC3pJ0yeyfFverpGOY').then((value)
    {
      departmentHomeModel = DepartmentHomeModel.fromJson(value.data);
      print(departmentHomeModel.Department![0].img);
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
        token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNjhmNWQ2NTE5OGQ5YWRiMTkzYWEzNWUwNGNmMDhkYzg5MjYzYWJiYmFmNThiYTQ2ZmY4MzIwYTA2ODQyNDFhMjFmZGI4NjNkZjYzNGRjZGIiLCJpYXQiOjE2OTA1MTA1MDEuNTY3MzAyLCJuYmYiOjE2OTA1MTA1MDEuNTY3MzEyLCJleHAiOjE3MjIxMzI5MDEuNTQwMzk4LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.Wdfou0Q6gbbC8cEGG17RGVRRgvp8_pEFPAnCBTPtWtVwjqf8IhZdg-bxi1NsSUVchaAISNcDvZLwKEu3qINSBltojP-CNRMBNxkyAfzHn_LPA0G3OHrEn463fJ0uoAamzE21p5MxzrTpUTfVO_fcomN1a6HgkK1VIXpQ7xSixz2z2HLeCsWzqzAlIhoHrQyPsiwkhfUyZ0bchmMEOD5XWbBpvUl2pKB4wP15s8PKoMdRiE_AYx9PQfmU_0zI-Q3TX96z7eDe41Twb-bLAQeFYvwyOcEp29Bg9DDsTBp93xMsJFAn4_4wp74Mr-fLT2SiijvIAD5tJ6i46fS46VHW7iudn674r-ospXKFFYMDZQH-xOzdfX3lS3Fffae8hyap3sG_TnYxd_fZx34ZDGrqVL3pfAT4BtDl-J-682XhLRpTAktjFIeEFOBjHGJIBA8zcaGc3Stif_IueN2fBhcl5NER0fLMM4zQQEyN5PEMbWgWGUQYbRYFmCl4CWi4PPMZQB-F5WKauJa_rV82BXSlse9At-1JuEYiOH6dyPRrtFALokCM7ULte3dHvslIX7WXbId-i1KgzSuG-5-WGuTZKlKcY1uHr4hTIACjmzpsT9XThvL6Dyk2mOJ9Y7tePxd0wv6HWcxTtzvsJtMfovaHSEjnypC3pJ0yeyfFverpGOY',data:
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
        token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiN2Q3ODgxNzQxNDkzODJmMjc1MTVkNzhlMzk4YWYyYjY4YzM5OGJhZmMwYThkYjNlMmExOWFhNmU4ZjM4NjVhODM4ODE3OWYyYmFmN2QwNjEiLCJpYXQiOjE2OTA1MDg5NDMuODQyNzY0LCJuYmYiOjE2OTA1MDg5NDMuODQyNzY3LCJleHAiOjE3MjIxMzEzNDMuNzMxMDY4LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.feSKOdfyFQYHfvqQxvN88nf4_49WdbK0_jbHQ3bJ1E8cirq5JPPwSDU9hoykmvP3H6MHb4qnKIpESoK9r0owoPvjGVjDitg-wA2yS1WRUgPa1ZtYeRTL7OlbmjuzEY0js8LrGBDcBy5gHZGD6meq1Qto88Mfv8HVFVcn1q3ebmrMkzN6g1q_XA2Clq3r3y0zq3D2fDhtPfArXPhK6H2XsM_pDkdDpTZIcb6oO0XT-zIzJePnoo8BnLz1oFxcUIEjvK8668gCBSja1bEMUy31UFxlSTpT4yvkRj8DvoFfJ6g0QShgMLtITL1YzQ5qEuR_ZroRQvKzsjgbldaepKeH2nSZmMWuPv6L1l84p-k6v3KjMCzMVbocbUcUDoxn2N5urcrdEA-gseY5Tm8QpGBSZwrlo7FjOIRbo_4GhTa9GHCDMYi_EWXXvzIQvOwFS1DOc2TNO4Ul9NFwIpcRHOmLyvN6kDn5Ra9YRnoGTC1NeN8wm1i53J9RzIGjfhXYD2OIEv-iLCU90_SRlz7vRKN4xCrVSaSTnnUUIdXzigXwEHoY7eiyhvsj2jplU7JPh2U4g7asHox0oAYw1IdT6cWnGtngCj1N8bkv2-E6fvLQILprFSAXs8j7F8qD2n-Jp8-NiH7_ybl1SdDlmfZ1lIx3EJbOSLvnnfgRgYwPPcdAcP8',
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
        token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNjhmNWQ2NTE5OGQ5YWRiMTkzYWEzNWUwNGNmMDhkYzg5MjYzYWJiYmFmNThiYTQ2ZmY4MzIwYTA2ODQyNDFhMjFmZGI4NjNkZjYzNGRjZGIiLCJpYXQiOjE2OTA1MTA1MDEuNTY3MzAyLCJuYmYiOjE2OTA1MTA1MDEuNTY3MzEyLCJleHAiOjE3MjIxMzI5MDEuNTQwMzk4LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.Wdfou0Q6gbbC8cEGG17RGVRRgvp8_pEFPAnCBTPtWtVwjqf8IhZdg-bxi1NsSUVchaAISNcDvZLwKEu3qINSBltojP-CNRMBNxkyAfzHn_LPA0G3OHrEn463fJ0uoAamzE21p5MxzrTpUTfVO_fcomN1a6HgkK1VIXpQ7xSixz2z2HLeCsWzqzAlIhoHrQyPsiwkhfUyZ0bchmMEOD5XWbBpvUl2pKB4wP15s8PKoMdRiE_AYx9PQfmU_0zI-Q3TX96z7eDe41Twb-bLAQeFYvwyOcEp29Bg9DDsTBp93xMsJFAn4_4wp74Mr-fLT2SiijvIAD5tJ6i46fS46VHW7iudn674r-ospXKFFYMDZQH-xOzdfX3lS3Fffae8hyap3sG_TnYxd_fZx34ZDGrqVL3pfAT4BtDl-J-682XhLRpTAktjFIeEFOBjHGJIBA8zcaGc3Stif_IueN2fBhcl5NER0fLMM4zQQEyN5PEMbWgWGUQYbRYFmCl4CWi4PPMZQB-F5WKauJa_rV82BXSlse9At-1JuEYiOH6dyPRrtFALokCM7ULte3dHvslIX7WXbId-i1KgzSuG-5-WGuTZKlKcY1uHr4hTIACjmzpsT9XThvL6Dyk2mOJ9Y7tePxd0wv6HWcxTtzvsJtMfovaHSEjnypC3pJ0yeyfFverpGOY',data:
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
      print(viewSecretariaModel.secretary?.departmentId);
      print(viewSecretariaModel.secretary?.user.firstName);
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
      print(value.data);
      print(value.data['message']);
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
      print(value.toString());
      print(registerSecretariaModel.token);
      print(registerSecretariaModel.role);
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
      print(value.toString());
      print(indexPatientModel.patient[0].user.firstName);
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
      print(value.data);
      print(deletePatientModel.success);
      print(deletePatientModel.message);
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
      print(viewPatientModel.message);
      print(viewPatientModel.patient.user.firstName);
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
