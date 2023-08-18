import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_manage_app/modules/edit_secretaria_prof/widgets/edit_secretaria_prof_item.dart';

import '../../core/functions/custome_snack_bar.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../models/secretaria/view_secretaria_model.dart';
import '../../widgets/component.dart';
import '../secretaria_profile/secretaria_profile-screen.dart';

class EditSecretariaProfScreen extends StatelessWidget {

  final ViewSecretariaModel model;

  final int index;

  const EditSecretariaProfScreen({
    super.key,
    required this.index,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedManageCubit()..indexDepartment(),
      child: BlocConsumer<MedManageCubit,MedManageStates>(
        listener: (context, state) {
          if(state is SecretariaProfEditSuccssesState){
            CustomeSnackBar.showSnackBar(
              context,
              msg: 'Update Succsses',
              color: Colors.green,
            );
            navigateAndReplacement(context, SecretariaProfile(index: index,));
            MedManageCubit.get(context).viewSecretaria(user_id: model.secretary.userId,);
            print(state.toString());
            if(state is SecretariaProfSuccssesState) {

            }
          }
          if(state is SecretariaProfEditErrorState){
            CustomeSnackBar.showSnackBar(
              context,
              msg: 'Update Failed',
              color: Colors.red,
            );
            navigateAndReplacement(context, SecretariaProfile(index: index,));
          }
        },
        builder: (context, state) {
          if(state is SecretariaProfEditErrorState)
          {
            return const Scaffold(
              body: Center(
                child: Text(
                  'There is some thing error',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          }else if(state is SecretariaProfEditLoadingState)
          {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }else
          {
            if(state is IndexDepartmentListErrorState)
            {
              return const Scaffold(
                body: Center(
                  child: Text(
                    'deppppp error',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            }else if(state is IndexDepartmentListLoadingState)
            {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }else
            {
              return ConditionalBuilder(
                condition: state is! SecretariaProfEditLoadingState,
                builder: (context) => EditSecretariaProfItem(
                  model: model,
                  //modelIn: MedManageCubit.get(context).indexSecretariaModel,
                  index: index,
                ),
                fallback: (context) => Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
/*import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import 'widgets/edit_secretaria_prof_item.dart';

class EditSecretariaProfScreen extends StatelessWidget {

  final int index;

  const EditSecretariaProfScreen({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is SecretariaProfEditErrorState)
        {
          return const Center(
            child: Text(
              'There is some thing error',
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }else
        {
          return ConditionalBuilder(
            condition: state is! SecretariaProfEditLoadingState,
            builder: (context) => EditSecretariaProfItem(
              model: MedManageCubit.get(context).viewSecretariaModel,
              modelIn: MedManageCubit.get(context).indexSecretariaModel,
              index: index,
            ),
            fallback: (context) => Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}*/
