import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manage_app/cubit/states.dart';

import '../cubit/cubit.dart';
import '../styles/colors/colors.dart';

class MedManageLayout extends StatelessWidget {
  const MedManageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
        builder: (context, state) {

          var cubit = MedManageCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title:const Text(
                'MedManage',
              ),
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: FloatingActionButton (


              onPressed: ()
              {

              },
              child:const Icon(
                Icons.add,
              color: defaultColor,),
            ),
            bottomNavigationBar:BottomNavigationBar(

              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.currentIndex = index;
                print(index);
                cubit.changeBottom(index);
              },
              items:cubit.items,

              
            ) ,
          );
        },
        listener: (context, state) {});
  }
}
