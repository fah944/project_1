import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manage_app/cubit/states.dart';

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

  List <BottomNavigationBarItem> items = const
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
