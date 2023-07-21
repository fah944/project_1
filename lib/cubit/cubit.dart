
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manage_app/cubit/states.dart';
import 'package:med_manage_app/helper/dio_helper.dart';
import 'package:med_manage_app/models/department/add_department_model.dart';
import '../helper/end_points.dart';
import '../models/department/delete_department_model.dart';
import '../models/department/index_department_model.dart';
import '../models/department/update_department_model.dart';
import '../modules/department/department_screen.dart';
import '../modules/patients/patients_screen.dart';
import '../modules/settings/settings_screen.dart';

class MedManageCubit extends Cubit<MedManageStates>
{

  MedManageCubit() : super(MedManageInitialState());

 static MedManageCubit get(context) =>BlocProvider.of(context);
 int currentIndex = 0;
 List<Widget> bottomScreens =
 [
   DepartmentScreen(),
   PatientsScreen(),
   SettingsScreen()
 ];

  List <BottomNavigationBarItem> items =
  [
    BottomNavigationBarItem(
      icon: Icon(Icons.home,
      size: 25.0,),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person,
      size: 25.0,),
      label: 'Patients',
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

 }



  late DepartmentHomeModel departmentHomeModel;

  void getHomeDepData()
 {
   emit(MedManageLoadHomeDepDataState());

     DioHelper.getData(
         url: INDEX_DEPARTMENT,
         token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMjA1NTJkMzE3ZDQyMzBjMjhjYTI1NGQzNjk4NzU0MDI4NWQzNjM0YzI0MzA0NGRmMzA0NzVlYTY1NjBiNjUxMTEyZjAzY2YyMjQ3Y2RlMzUiLCJpYXQiOjE2ODk4NTc0NTcuNTE1Njk3LCJuYmYiOjE2ODk4NTc0NTcuNTE1NzA2LCJleHAiOjE3MjE0Nzk4NTcuNDg4NDk4LCJzdWIiOiIyMSIsInNjb3BlcyI6W119.qz57UmimCCCF0Gb76I0e5yO8vUjR_DO5g4u92tS9WJIhmfkUZPsDgGjn6CnVakX7zIPIUqIwFcRJHjIlzaAMbxQCIWpEvL978Lv5EUNjnrn8jZUIubsUaQ3S504aGLnjqIXsEouyHI94yvlFt0VlewdGlbaJ6SW1Bv3aD0w8SvgFhvbKkITdDGUGt1X_7x4GWiaoyTaP0I6hPKiJHqD3MxEaKiFMT_obKP6BEBAcaXvY-2AYbIH4JenEydfiQE2lOSmv2zxrF7vmv7COk_kF2wDwZ08OhXMyPeJ9fEjFDhQ2bJ-3NVH9zkCTQQSyVMlzc0KEV3mUNKBn667gPHQKftH2QGo3FEqzfdwS_B4EzVeL4e1_wJ5raBFygFlOKiIRl9wpu-5cRL213oS3FxcJnky8KPsbdZtl-fPo63s17SzJKyItV0F0b9pt3C9hDYzXoLbWu9g_R5qVePVtjHlsVI15zk0LjOClf6WBJ0xrQ5vkptAQQf2cdg1_kp3qrQslGHe4qPLce9aF6mx7hixougUhFuFZzGlstVN8eLowIYnR5BKBtAaz8maQWnfhRMP9gg0jHeUXxT8JYOgBYYCl8Qfci3bc5fsrMNRtLh_BzyIDEh5cja7K3LV1v_nfdTiCUlp0i9K0MiKZWvQkgjOuXx3NLYZ70WDdVnM_SLkQByE',

   ).then((value)
   {
   //  print(value.data);

     departmentHomeModel = DepartmentHomeModel.fromJson(value.data);
     print(departmentHomeModel.Department.toString());
    // print(departmentHomeModel.Department![0].name);
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
    required String img,
  })
  {
    DioHelper.postData(
        url: ADD_DEPARTMENT,
        token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMjA1NTJkMzE3ZDQyMzBjMjhjYTI1NGQzNjk4NzU0MDI4NWQzNjM0YzI0MzA0NGRmMzA0NzVlYTY1NjBiNjUxMTEyZjAzY2YyMjQ3Y2RlMzUiLCJpYXQiOjE2ODk4NTc0NTcuNTE1Njk3LCJuYmYiOjE2ODk4NTc0NTcuNTE1NzA2LCJleHAiOjE3MjE0Nzk4NTcuNDg4NDk4LCJzdWIiOiIyMSIsInNjb3BlcyI6W119.qz57UmimCCCF0Gb76I0e5yO8vUjR_DO5g4u92tS9WJIhmfkUZPsDgGjn6CnVakX7zIPIUqIwFcRJHjIlzaAMbxQCIWpEvL978Lv5EUNjnrn8jZUIubsUaQ3S504aGLnjqIXsEouyHI94yvlFt0VlewdGlbaJ6SW1Bv3aD0w8SvgFhvbKkITdDGUGt1X_7x4GWiaoyTaP0I6hPKiJHqD3MxEaKiFMT_obKP6BEBAcaXvY-2AYbIH4JenEydfiQE2lOSmv2zxrF7vmv7COk_kF2wDwZ08OhXMyPeJ9fEjFDhQ2bJ-3NVH9zkCTQQSyVMlzc0KEV3mUNKBn667gPHQKftH2QGo3FEqzfdwS_B4EzVeL4e1_wJ5raBFygFlOKiIRl9wpu-5cRL213oS3FxcJnky8KPsbdZtl-fPo63s17SzJKyItV0F0b9pt3C9hDYzXoLbWu9g_R5qVePVtjHlsVI15zk0LjOClf6WBJ0xrQ5vkptAQQf2cdg1_kp3qrQslGHe4qPLce9aF6mx7hixougUhFuFZzGlstVN8eLowIYnR5BKBtAaz8maQWnfhRMP9gg0jHeUXxT8JYOgBYYCl8Qfci3bc5fsrMNRtLh_BzyIDEh5cja7K3LV1v_nfdTiCUlp0i9K0MiKZWvQkgjOuXx3NLYZ70WDdVnM_SLkQByE',
        data:
        {
          'name':name,
          'img':img,
        }
    ).then((value)
    {

      addDepartmentModel = AddDepartmentModel.fromJson(value.data);
      emit(MedManageAddSuccessState());
    }).catchError((error)
    {
      emit(MedManageAddErrorState());
    });

  }


  late DeleteDepartmentModel deleteDepartmentModel;
  void deleteDepartment({
    required int id,
  })
  {
    DioHelper.postData(
        url: DELETE_DEPARTMENT,
        token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMjA1NTJkMzE3ZDQyMzBjMjhjYTI1NGQzNjk4NzU0MDI4NWQzNjM0YzI0MzA0NGRmMzA0NzVlYTY1NjBiNjUxMTEyZjAzY2YyMjQ3Y2RlMzUiLCJpYXQiOjE2ODk4NTc0NTcuNTE1Njk3LCJuYmYiOjE2ODk4NTc0NTcuNTE1NzA2LCJleHAiOjE3MjE0Nzk4NTcuNDg4NDk4LCJzdWIiOiIyMSIsInNjb3BlcyI6W119.qz57UmimCCCF0Gb76I0e5yO8vUjR_DO5g4u92tS9WJIhmfkUZPsDgGjn6CnVakX7zIPIUqIwFcRJHjIlzaAMbxQCIWpEvL978Lv5EUNjnrn8jZUIubsUaQ3S504aGLnjqIXsEouyHI94yvlFt0VlewdGlbaJ6SW1Bv3aD0w8SvgFhvbKkITdDGUGt1X_7x4GWiaoyTaP0I6hPKiJHqD3MxEaKiFMT_obKP6BEBAcaXvY-2AYbIH4JenEydfiQE2lOSmv2zxrF7vmv7COk_kF2wDwZ08OhXMyPeJ9fEjFDhQ2bJ-3NVH9zkCTQQSyVMlzc0KEV3mUNKBn667gPHQKftH2QGo3FEqzfdwS_B4EzVeL4e1_wJ5raBFygFlOKiIRl9wpu-5cRL213oS3FxcJnky8KPsbdZtl-fPo63s17SzJKyItV0F0b9pt3C9hDYzXoLbWu9g_R5qVePVtjHlsVI15zk0LjOClf6WBJ0xrQ5vkptAQQf2cdg1_kp3qrQslGHe4qPLce9aF6mx7hixougUhFuFZzGlstVN8eLowIYnR5BKBtAaz8maQWnfhRMP9gg0jHeUXxT8JYOgBYYCl8Qfci3bc5fsrMNRtLh_BzyIDEh5cja7K3LV1v_nfdTiCUlp0i9K0MiKZWvQkgjOuXx3NLYZ70WDdVnM_SLkQByE',
        data:
        {
          'id':id,
        }
    ).then((value)
    {

      deleteDepartmentModel = DeleteDepartmentModel.fromJson(value.data);
      emit(MedManageDeleteSuccessState());
    }).catchError((error)
    {
      emit(MedManageDeleteErrorState());
    });

  }


  late UpdateDepartmentModel updateDepartmentModel;
  void updateDepartment({
    required int id,
    required String name,
  })
  {
    DioHelper.postData(
        url: UPDATE_DEPARTMENT,
        token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMjA1NTJkMzE3ZDQyMzBjMjhjYTI1NGQzNjk4NzU0MDI4NWQzNjM0YzI0MzA0NGRmMzA0NzVlYTY1NjBiNjUxMTEyZjAzY2YyMjQ3Y2RlMzUiLCJpYXQiOjE2ODk4NTc0NTcuNTE1Njk3LCJuYmYiOjE2ODk4NTc0NTcuNTE1NzA2LCJleHAiOjE3MjE0Nzk4NTcuNDg4NDk4LCJzdWIiOiIyMSIsInNjb3BlcyI6W119.qz57UmimCCCF0Gb76I0e5yO8vUjR_DO5g4u92tS9WJIhmfkUZPsDgGjn6CnVakX7zIPIUqIwFcRJHjIlzaAMbxQCIWpEvL978Lv5EUNjnrn8jZUIubsUaQ3S504aGLnjqIXsEouyHI94yvlFt0VlewdGlbaJ6SW1Bv3aD0w8SvgFhvbKkITdDGUGt1X_7x4GWiaoyTaP0I6hPKiJHqD3MxEaKiFMT_obKP6BEBAcaXvY-2AYbIH4JenEydfiQE2lOSmv2zxrF7vmv7COk_kF2wDwZ08OhXMyPeJ9fEjFDhQ2bJ-3NVH9zkCTQQSyVMlzc0KEV3mUNKBn667gPHQKftH2QGo3FEqzfdwS_B4EzVeL4e1_wJ5raBFygFlOKiIRl9wpu-5cRL213oS3FxcJnky8KPsbdZtl-fPo63s17SzJKyItV0F0b9pt3C9hDYzXoLbWu9g_R5qVePVtjHlsVI15zk0LjOClf6WBJ0xrQ5vkptAQQf2cdg1_kp3qrQslGHe4qPLce9aF6mx7hixougUhFuFZzGlstVN8eLowIYnR5BKBtAaz8maQWnfhRMP9gg0jHeUXxT8JYOgBYYCl8Qfci3bc5fsrMNRtLh_BzyIDEh5cja7K3LV1v_nfdTiCUlp0i9K0MiKZWvQkgjOuXx3NLYZ70WDdVnM_SLkQByE',
        data:
        {
          'id': id,
          'name':name,
        }
    ).then((value)
    {

      updateDepartmentModel = UpdateDepartmentModel.fromJson(value.data);
      emit(MedManageUpdateSuccessState());
    }).catchError((error)
    {
      emit(MedManageUpdateErrorState());
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
