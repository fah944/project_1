import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_assets.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../models/patient/index_patient_model.dart';
import '../../styles/colors/colors.dart';
import 'widgets/patient_profile_item.dart';

class PatientProfileScreen extends StatelessWidget {

  final IndexPatientModel? model;
  final int? index;
  final String? profImage;

  const PatientProfileScreen({
    super.key,
    this.model,
    this.index,
    this.profImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        MedManageCubit cubit = MedManageCubit.get(context);
        if(state is PatientProfLoadingState)
        {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }else if(state is PatientProfSuccssesState)
        {
          return PatientProfileItem(
            model: cubit.viewPatientModel,
            index: index,
            profImage: profImage!,);
        }else if(state is PatientProfErrorState)
        {
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
            /*appBar: AppBar(
              backgroundColor: defaultColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(20.r))),
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 16.w,
                  top: 8.5.w,
                  bottom: 8.5.w,
                ),
                //child: const CustomArrowBackIconButton(),
              ),
            ),*/
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