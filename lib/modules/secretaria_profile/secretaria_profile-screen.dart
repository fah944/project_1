import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../models/secretaria/index_secretaria_model.dart';
import '../../styles/colors/colors.dart';
import 'widgets/secretaria_profile_item.dart';

class SecretariaProfile extends StatelessWidget {

  final IndexSecretariaModel? model;
  final int index;

  const SecretariaProfile({
    super.key,
    this.model,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        MedManageCubit cubit = MedManageCubit.get(context);
        if(state is SecretariaProfLoadingState)
        {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }else if (state is SecretariaProfSuccssesState)
        {
          return SecretariaProfileItem(model: cubit.viewSecretariaModel, index: index,);
        }else if (state is SecretariaProfErrorState){
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
                onPressed: (){
                  cubit.indexSecretariaList();
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              child: Text(
                'There is some thing error',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          );
        }else
        {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}