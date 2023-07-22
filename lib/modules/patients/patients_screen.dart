import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../widgets/patients_list_view_item.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedManageCubit,MedManageStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: PatientsListViewItem(context,profImage: 'assets/images/default_photo.jpg', model: MedManageCubit.get(context).indexPatientModel,),
        );
      },
    );
  }
}
