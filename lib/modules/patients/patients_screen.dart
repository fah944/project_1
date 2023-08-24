import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import 'widgets/patients_list_view_item.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit, MedManageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is IndexPatientListLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }else if (state is IndexPatientListSuccssesState) {
          return PatientsListViewItem(
            context,
            profImage: 'assets/images/undraw_Male_avatar_g98d.png',
            model: MedManageCubit.get(context).indexPatientModel,
          );
        }else  if (state is IndexPatientListErrorState)
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
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
